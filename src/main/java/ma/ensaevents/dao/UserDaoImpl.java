package ma.ensaevents.dao;

import ma.ensaevents.entity.Club;
import ma.ensaevents.entity.Event;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ma.ensaevents.entity.User;

import java.util.List;

@Repository
public class UserDaoImpl implements UserDao {

	// need to inject the session factory
	@Autowired
	private SessionFactory sessionFactory;
	
	@Override
	public User findByUserName(String theUserName) {
		// get the current hibernate session
		Session session = sessionFactory.getCurrentSession();

		// now retrieve/read from database using username
		Query<User> theQuery = session.createQuery("from User where username=:uName", User.class);
		theQuery.setParameter("uName", theUserName);
		User theUser = null;
		try {
			theUser = theQuery.getSingleResult();
		} catch (Exception e) {
			theUser = null;
		}

		return theUser;
	}

	@Override
	public void save(User user) {
		// get current hibernate session
		Session session = sessionFactory.getCurrentSession();

		// create the user ... finally LOL
		session.saveOrUpdate(user);
		
	}

	@Override
	public List<User> getUsers() {
		Session session = sessionFactory.getCurrentSession();

		Query<User> theQuery =
				session.createQuery("FROM User",User.class);

		List<User> Users = theQuery.getResultList();

		return Users;
	}

	@Override
	public List<Event> getMyEvents(User currentUser) {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, currentUser.getId());
		List<Event> events = user.getMyEvents();
		for(Event event:events) {
			event.getParticipants().size();
		}
		return user.getMyEvents();
	}

	@Override
	public List<Club> getMyClubs(User currentUser) {
		Session session = sessionFactory.getCurrentSession();
		User user = session.get(User.class, currentUser.getId());
		user.getMyClubs().size();
		return user.getMyClubs();
	}

	@Override
	public List<User> findActiveUsers() {
		Session session = sessionFactory.getCurrentSession();
		Query<User> theQuery = session.createQuery("FROM User WHERE enabled=true AND role!= 3",User.class);
		return theQuery.getResultList();
	}

	@Override
	public List<User> findSuspendedUsers() {
		Session session = sessionFactory.getCurrentSession();
		Query<User> theQuery = session.createQuery("FROM User WHERE enabled=false",User.class);
		return theQuery.getResultList();
	}

	@Override
	public void suspendUser(String username) {
		Session session = sessionFactory.getCurrentSession();
		Query theQuery = session.createQuery("Update User set enabled=0 WHERE username=:username");
		theQuery.setParameter("username",username);
		theQuery.executeUpdate();
	}

	@Override
	public void unsuspendUser(String username) {
		Session session = sessionFactory.getCurrentSession();
		Query theQuery = session.createQuery("Update User set enabled=1 WHERE username=:username");
		theQuery.setParameter("username",username);
		theQuery.executeUpdate();
	}
}
