package ma.ensaevents.service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import ma.ensaevents.utils.UpdatePassword;
import ma.ensaevents.utils.CreateUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import ma.ensaevents.dao.RoleDao;
import ma.ensaevents.dao.UserDao;
import ma.ensaevents.entity.Role;
import ma.ensaevents.entity.User;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	@Transactional
	public User findByUserName(String userName) {
		// check the database if the user already exists
		return userDao.findByUserName(userName);
	}

	@Override
	@Transactional
	public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
		User user = userDao.findByUserName(userName);
		if (user == null) {
			throw new UsernameNotFoundException("Invalid username or password.");
		}
		return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(),
				getAuthorities(user.getRole()));
	}

	// Pour changer la collection de role aux user role!
	/*
	 *This function is for multiple role !
	private Collection<? extends GrantedAuthority > mapRolesToAuthorities(Collection<Role> roles) {
		return roles.stream().map(role -> new SimpleGrantedAuthority(role.getName())).collect(Collectors.toList());
	}
	*/

    public Collection<? extends GrantedAuthority> getAuthorities(Role role) {
        return Arrays.asList(new SimpleGrantedAuthority(role.getName()));
    } 
	

	@Override
	@Transactional
	public void save(CreateUser createUser) {
		User user = new User();
		 // assign user details to the user object
		user.setUsername(createUser.getUserName());
		user.setPassword(passwordEncoder.encode(createUser.getPassword()));
		user.setFirstname(createUser.getFirstName());
		user.setLastname(createUser.getLastName());
		user.setEmail(createUser.getEmail());
		user.setRole(roleDao.findRoleByName("ROLE_USER"));

		// save user in the database
		userDao.save(user);
	}

	@Override
	@Transactional
	public void update(User currentUser) {
		userDao.save(currentUser);
	}

	@Override
	public boolean checkPassword(User user, UpdatePassword changePassword) {
		return passwordEncoder.matches(changePassword.getOldPassword(), user.getPassword());
	}

	@Override
	@Transactional
	public void changePassword(HttpServletRequest request, UpdatePassword changePassword) {
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		user.setPassword(passwordEncoder.encode(changePassword.getPassword()));

		session.setAttribute("user", user);

		userDao.save(user);
	}

	@Override
	@Transactional
	public List<String> usersUsernames() {
		List<User> users = userDao.getUsers();

		List<String> Usernames = new ArrayList<String>();
		for(User user : users)	{
			if(user.getRole().getName().equals("ROLE_USER"))
				Usernames.add(user.getUsername());
		}

		return Usernames;
	}

}
