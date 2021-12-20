package ma.ensaevents.service;

import java.util.List;

import ma.ensaevents.entity.Event;

import javax.transaction.Transactional;

public interface EventService {

    public Event findByEventId(int eventId);

    public List<Event> findAllEvents();

    List<Event> findAllEventsAfterToday();

    public void deleteEvent(Event event);

    public void createEvent(Event event);

    List<Event> findAllEventsBetween(String startDate, String endDate);

    List<Event> findClubEventsBetween(String startDate, String endDate, String clubName);

    List<Event> findClubEvents(String clubName);
}
