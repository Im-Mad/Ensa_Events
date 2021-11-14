package ma.ensaevents.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;

import ma.ensaevents.dao.EventDao;
import ma.ensaevents.entity.Event;

public class EventServiceImp implements EventService {

	@Autowired
	private EventDao eventDao;
	
	@Transactional
	public Event findByEventId(int eventId) {
		return eventDao.FindById(eventId);
	}
	
	@Transactional
	public List<Event> findAllEvents() {
		return eventDao.findAllEvents();
	}

	@Override
	public void deleteEvent(Event event) {
		eventDao.Delete(event);
		
	}

	@Override
	public void createEvent(Event event) {
		eventDao.Create(event);
		
	}
	
	

}
