package ma.ensaevents.service;

import org.springframework.security.core.userdetails.UserDetailsService;

import ma.ensaevents.entity.User;
import ma.ensaevents.user.CrmUser;

public interface UserService extends UserDetailsService {

	User findByUserName(String userName);
	
    void save(CrmUser crmUser);

	void update(User currentUser);
}
