package ma.ensaevents.dao;

import java.util.List;

import ma.ensaevents.entity.Event;

public interface EventDao {

    public Event findById(int eventId);

    public void create(Event event);

    public void delete(Event event);

    public List<Event> findAllEvents();

    public List<Event> findByDate();

    List<Event> executeQuery(String Query);

    void updateEvent(Event event);
}
