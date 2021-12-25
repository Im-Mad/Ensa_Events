package ma.ensaevents.service;

import java.util.List;

import javax.transaction.Transactional;

import ma.ensaevents.dao.ClubDao;
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

    @Autowired
    private ClubDao clubDao;

    @Override
    @Transactional
    public Event findByEventId(int eventId) {
        return eventDao.findById(eventId);
    }

    @Override
    @Transactional
    public List<Event> findAllEvents() {
        return eventDao.findAllEvents();
    }

    @Override
    @Transactional
    public List<Event> findUpcomingEvents() {
        return eventDao.findByDate();
    }

    @Override
    @Transactional
    public void deleteEvent(Event event) {
        eventDao.delete(event);

    }

    @Override
    @Transactional
    public void createEvent(Event event) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username  =((org.springframework.security.core.userdetails.User) principal).getUsername();

        User user = userService.findByUserName(username);

        Club club = user.getClub();

        event.setClub(club);

        eventDao.create(event);
    }

    @Override
    @Transactional
    public List<Event> findAllEventsBetween(String startDate, String endDate) {
        String Query = "FROM Event WHERE  date between '"+startDate+"' AND '"+endDate+" 23:59' ORDER BY date";
        return eventDao.executeQuery(Query);
    }

    @Override
    @Transactional
    public List<Event> findClubEventsBetween(String startDate, String endDate, String clubName) {
        Club club = clubDao.findByName(clubName);
        System.out.println("'"+startDate+"' '"+endDate+" 23:59' "+club.getId());
        String Query = "FROM Event WHERE  date between '"+startDate+"' AND '"+endDate+" 23:59' AND club_id="+club.getId()+" ORDER BY date";
        return eventDao.executeQuery(Query);
    }

    @Override
    @Transactional
    public List<Event> findClubEvents(String clubName) {
        Club club = clubDao.findByName(clubName);
        String Query = "FROM Event WHERE club_id="+club.getId()+" ORDER BY date";
        return eventDao.executeQuery(Query);
    }

    @Override
    @Transactional
    public Event findEventByName(String eventName) {
        return eventDao.findEventByName(eventName);
    }

    @Override
    @Transactional
    public void update(Event event) {
        eventDao.update(event);
    }

    @Override
    @Transactional
    public void deleteByName(String eventName) {
        Event event = eventDao.findEventByName(eventName);
        eventDao.deleteByName(event);
    }

    @Override
    public void addParticipant(int eventId, User user) {

        Event event = eventDao.findById(eventId);
        event.addParticipant(user);

        eventDao.updateEvent(event);
    }

    @Override
    public void removeParticipant(int eventId, User user) {
        Event event = eventDao.findById(eventId);
        event.removeParticipant(user);

        eventDao.updateEvent(event);
    }
}
