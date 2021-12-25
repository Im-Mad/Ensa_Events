package ma.ensaevents.dao;

import java.util.List;

import ma.ensaevents.entity.Event;

public interface EventDao {

    Event findById(int eventId);

    Event findEventByName(String eventName);

    void create(Event event);

    void delete(Event event);

    List<Event> findByDate();

    List<Event> findAllEvents();

    List<Event> executeQuery(String Query);

    void updateEvent(Event event);

    void update(Event event);

    void deleteByName(Event event);
}
