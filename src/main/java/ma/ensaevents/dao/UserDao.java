package ma.ensaevents.dao;

import ma.ensaevents.entity.Club;
import ma.ensaevents.entity.Event;
import ma.ensaevents.entity.User;

import java.util.List;

public interface UserDao {

	User findByUserName(String username);

	void save(User user);

	List<User> getUsers();

    List<Event> getMyEvents(User currentUser);

	List<Club> getMyClubs(User currentUser);

    List<User> findActiveUsers();

	List<User> findSuspendedUsers();
}
