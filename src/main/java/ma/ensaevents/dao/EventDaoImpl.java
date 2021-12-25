package ma.ensaevents.dao;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import ma.ensaevents.email.sendMail;
import ma.ensaevents.entity.User;
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
    public Event findEventByName(String eventName) {
        Session session = sessionFactory.getCurrentSession();

        Query<Event> theQuery = session.createQuery("from Event where name=:uName", Event.class);
        theQuery.setParameter("uName", eventName);
        Event event = null;
        try {
            event = theQuery.getSingleResult();
        } catch (Exception e) {
            event = null;
        }

        return event;
    }

    @Override
    public Event FindById(int eventId) {

        Session session = sessionFactory.getCurrentSession();
        Event event = session.get(Event.class, eventId);
        event.getParticipants().size();
        event.getReviews().size();
        return event;
    }

    @Override
    public void Create(Event event) {

        Session session = sessionFactory.getCurrentSession();

        session.save(event);

        List<String> recipient = new ArrayList<>();
        for(User member:event.getClub().getMembers()) {
            recipient.add(member.getEmail());
        }
        sendMail.sendEmail(recipient,"A Club Created A New Event !",event);
    }

    @Override
    public void Delete(Event event) {
        Session session = sessionFactory.getCurrentSession();
        Query<Event> query = session.createQuery("delete from Event where id=:eventId");
        query.setParameter("eventId", event.getId());
        query.executeUpdate();
    }

    @Override
    public List<Event> findAllEvents() {
        Session session = sessionFactory.getCurrentSession();

        Query<Event> query = session.createQuery("FROM Event ORDER BY date ",Event.class);
        List<Event> events = query.list();

        for(Event event:events) {
            event.getParticipants().size();
        }

        return events;
    }

    @Override
    public List<Event> findAllEventsAfterToday() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime now = LocalDateTime.now();
        String date =formatter.format(now);

        Session session = sessionFactory.getCurrentSession();
        Query<Event> query = session.createQuery("FROM Event WHERE  date>'"+date+"' OR end_date>'"+date+"' ORDER BY date", Event.class);

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
    public void update(Event event) {
        Session session = sessionFactory.getCurrentSession();
        session.update(event);
    }

    @Override
    public void deleteByName(Event event) {
        Session session = sessionFactory.getCurrentSession();
        Query q = session.createQuery("delete Participants where id = "+event.getId());
        q.executeUpdate();
        q = session.createQuery("delete Review where  event= "+event.getId());
        q.executeUpdate();
        q = session.createQuery("delete Event where  id= "+event.getId());
        q.executeUpdate();
    }
}
