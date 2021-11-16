package ma.ensaevents.dao;

import java.util.List;

import ma.ensaevents.entity.Event;

public interface EventDao {

    public Event FindById(int eventId);

    public void Create(Event event);

    public void Delete(Event event);

    public List<Event> findAllEvents();
}
