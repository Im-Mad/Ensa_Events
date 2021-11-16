package ma.ensaevents.service;

import java.util.List;

import javax.transaction.Transactional;

import ma.ensaevents.entity.Club;
import ma.ensaevents.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import ma.ensaevents.dao.EventDao;
import ma.ensaevents.entity.Event;

@Service
public class EventServiceImpl implements EventService {

    @Autowired
    private EventDao eventDao;

    @Autowired
    private UserService userService;

    @Override
    @Transactional
    public Event findByEventId(int eventId) {
        return eventDao.FindById(eventId);
    }

    @Override
    @Transactional
    public List<Event> findAllEvents() {
        return eventDao.findAllEvents();
    }

    @Override
    @Transactional
    public void deleteEvent(Event event) {
        eventDao.Delete(event);

    }

    @Override
    @Transactional
    public void createEvent(Event event) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username  =((org.springframework.security.core.userdetails.User) principal).getUsername();

        User user = userService.findByUserName(username);

        Club club = user.getClub();

        event.setClub(club);

        eventDao.Create(event);
    }

}
