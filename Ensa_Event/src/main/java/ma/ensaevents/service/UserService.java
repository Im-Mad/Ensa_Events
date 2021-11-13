package ma.ensaevents.service;

import ma.ensaevents.entity.User;

public interface UserService {

	public User findByUserName(String userName);
}
