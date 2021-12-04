package ma.ensaevents.service;

import ma.ensaevents.utils.ChangePassword;
import org.springframework.security.core.userdetails.UserDetailsService;

import ma.ensaevents.entity.User;
import ma.ensaevents.utils.CreateUser;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

public interface UserService extends UserDetailsService {

    User findByUserName(String userName);
	
    void save(CreateUser createUser);

	void update(User currentUser);

	boolean checkPassword(User user, ChangePassword changePassword);

    void changePassword(HttpServletRequest request, ChangePassword changePassword);

    List<String> usersUsernames();
}
