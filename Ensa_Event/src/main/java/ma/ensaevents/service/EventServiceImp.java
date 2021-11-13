package ma.ensaevents.service;

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
	
	

}
