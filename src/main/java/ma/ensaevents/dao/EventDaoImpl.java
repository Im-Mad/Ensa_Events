package ma.ensaevents.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import ma.ensaevents.exceptions.NotFoundException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ma.ensaevents.entity.Event;

@Repository
public class EventDaoImpl implements EventDao{

    @Autowired
    public SessionFactory sessionFactory;

    @Override
    public Event findById(int eventId) throws NotFoundException{

        Session session = sessionFactory.getCurrentSession();
        Event event = session.get(Event.class, eventId);
        if (event == null)
            throw new NotFoundException();
        System.out.println(event.getParticipants());
        System.out.println(event.getReviews());
        return event;
    }

    @Override
    public void create(Event event) {

        Session session = sessionFactory.getCurrentSession();

        session.save(event);

    }

    @Override
    public void delete(Event event) {

        Session session = sessionFactory.getCurrentSession();

        Query<Event> query = session.createQuery("delete from Event where id=:eventId");

        query.setParameter("eventId", event.getId());

        query.executeUpdate();

    }

    @Override
    public List<Event> findAllEvents() {
        Session session = sessionFactory.getCurrentSession();

        Query<Event> query = session.createQuery("FROM Event",Event.class);
        List<Event> events = query.list();

        for(Event event:events) {
            event.getParticipants().size();
        }

        return events;
    }

    @Override
    public List<Event> findByDate() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime now = LocalDateTime.now();
        String date =formatter.format(now);

        Session session = sessionFactory.getCurrentSession();
        Query<Event> query = session.createQuery("FROM Event WHERE  date>'"+date+"' OR endDate>'"+date+"' ORDER BY date", Event.class);

        return query.list();
    }

    @Override
    public List<Event> executeQuery(String Query) {
        Session session = sessionFactory.getCurrentSession();
        Query<Event> query = session.createQuery(Query, Event.class);

        List<Event> events = query.list();
        for(Event event:events) {
            event.getParticipants().size();
        }
        return events;
   }

    @Override
    public void updateEvent(Event event) {
        Session session = sessionFactory.getCurrentSession();
        session.update(event);
    }
}
