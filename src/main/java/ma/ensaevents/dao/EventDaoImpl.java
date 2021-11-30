package ma.ensaevents.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import ma.ensaevents.entity.Event;

@Repository
public class EventDaoImpl implements EventDao{

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

        Query<Event> query = session.createQuery("delete from Event where id=eventId");

        query.setParameter("eventId", event.getId());

        query.executeUpdate();

    }

    @Override
    public List<Event> findAllEvents() {
        Session session = sessionFactory.getCurrentSession();

        Query<Event> query = session.createQuery("FROM Event",Event.class);
        List<Event> events = query.list();

        return events;
    }





}
