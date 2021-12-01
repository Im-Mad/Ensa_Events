package ma.ensaevents.service;

import ma.ensaevents.user.CrmPassword;
import org.springframework.security.core.userdetails.UserDetailsService;

import ma.ensaevents.entity.User;
import ma.ensaevents.user.CrmUser;

import javax.servlet.http.HttpServletRequest;

public interface UserService extends UserDetailsService {

    User findByUserName(String userName);
	
    void save(CrmUser crmUser);

	void update(User currentUser);

	boolean checkPassword(User user, CrmPassword crmPassword);

    void changePassword(HttpServletRequest request, CrmPassword crmPassword);
}
