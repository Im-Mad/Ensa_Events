package ma.ensaevents.service;

import java.util.List;

import ma.ensaevents.entity.Event;

public interface EventService {

	public Event findByEventId(int eventId);
	
	public List<Event> findAllEvents();
	
	public void deleteEvent(Event event);
	
	public void createEvent(Event event);
}
