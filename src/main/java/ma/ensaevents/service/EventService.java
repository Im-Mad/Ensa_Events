package ma.ensaevents.service;

import java.util.List;

import ma.ensaevents.entity.Event;
import ma.ensaevents.entity.User;

public interface EventService {

    public Event findByEventId(int eventId);

    public List<Event> findAllEvents();

    List<Event> findUpcomingEvents();

    public void deleteEvent(Event event);

    public void createEvent(Event event);

    List<Event> findAllEventsBetween(String startDate, String endDate);

    List<Event> findClubEventsBetween(String startDate, String endDate, String clubName);

    List<Event> findClubEvents(String clubName);

    Event findEventByName(String eventName);

    void update(Event event);

    void deleteByName(String eventName);

    void addParticipant(int eventId, User user);

    void removeParticipant(int eventId, User user);
}
