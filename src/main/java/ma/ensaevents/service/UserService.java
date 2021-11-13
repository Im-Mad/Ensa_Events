package ma.ensaevents.service;

import ma.ensaevents.entity.User;

public interface UserService {

	User findByUserName(String userName);
}
