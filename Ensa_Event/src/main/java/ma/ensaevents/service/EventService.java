package ma.ensaevents.service;

import ma.ensaevents.entity.Event;

public interface EventService {

	public Event findByEventId(int eventId);
}
