package ma.ensaevents.dao;

import ma.ensaevents.entity.User;

public interface UserDao {

	User findByUserName(String username);
	
}
