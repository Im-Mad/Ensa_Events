package ma.ensaevents.dao;

import java.util.List;

import ma.ensaevents.entity.Event;

public interface EventDao {

    Event findEventByName(String eventName);

    Event FindById(int eventId);

    void Create(Event event);

    void Delete(Event event);

    List<Event> findAllEvents();

    List<Event> findAllEventsAfterToday();

    List<Event> executeQuery(String Query);

    void update(Event event);

    void deleteByName(Event event);
}
