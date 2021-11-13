package ma.ensaevents.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import ma.ensaevents.entity.Event;

public class EventDaoImp implements EventDao{
	
	@Autowired
	public SessionFactory sessionFactory;

	@Override
	public Event FindById(int eventId) {
		
		Session session = sessionFactory.getCurrentSession();
		
		return session.get(Event.class, eventId);
	}

	@Override
	public void Create(Event event) {
		
		Session session = sessionFactory.getCurrentSession();
		
		session.save(event);
		
	}

	@Override
	public void Delete(Event event) {
		
		Session session = sessionFactory.getCurrentSession();
		
		Query query = session.createQuery("delete from event where id=eventId");
		query.setParameter("eventId", event.getId());
		
		query.executeUpdate();
		
	}
	
	
	
	

}
