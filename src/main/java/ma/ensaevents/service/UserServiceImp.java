package ma.ensaevents.service;

import java.util.Arrays;
import java.util.Collection;

import javax.transaction.Transactional;

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
import ma.ensaevents.user.CrmUser;

@Service
public class UserServiceImp implements UserService {

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
	public void save(CrmUser crmUser) {
		User user = new User();
		 // assign user details to the user object
		user.setUsername(crmUser.getUserName());
		user.setPassword(passwordEncoder.encode(crmUser.getPassword()));
		user.setFirstname(crmUser.getFirstName());
		user.setLastname(crmUser.getLastName());
		user.setEmail(crmUser.getEmail());
		user.setRole(roleDao.findRoleByName("ROLE_USER"));

		// save user in the database
		userDao.save(user);
	}

	@Override
	public void update(User currentUser) {
		// TODO Auto-generated method stub
		
	}

}
