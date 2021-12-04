package ma.ensaevents.dao;

import ma.ensaevents.entity.User;

import java.util.List;

public interface UserDao {

	User findByUserName(String username);

	void save(User user);

	List<User> getUsers();
}
