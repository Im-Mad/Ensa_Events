package ma.ensaevents.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import ma.ensaevents.entity.Club;
import ma.ensaevents.entity.User;
import ma.ensaevents.exceptions.UnauthorizedException;
import ma.ensaevents.utils.CreateEvent;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import ma.ensaevents.entity.Event;
import ma.ensaevents.service.EventService;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/event")
public class EventController {
    SimpleDateFormat formatter=new SimpleDateFormat("MM/dd/yyyy HH:mm");
    SimpleDateFormat formatterDay =new SimpleDateFormat("yyyy/MM/dd");
    @Autowired
    private EventService eventService;

    @GetMapping("/all")
    public String allEvent(Model theModel) {
        List<Event> events = eventService.findAllEvents();

        theModel.addAttribute("events",events);

        return "event/filterEvents";
    }

    @GetMapping("/{id}")
    public String getEvent(@PathVariable int id, Model model) {

        Event event = eventService.findByEventId(id);
        model.addAttribute("event", event);

        return "event/event";
    }

    @GetMapping("/create")
    public String formCreateEvent() {
        return "event/createEvent";
    }

    @PostMapping("/create")
    public String processAddEvent(Model theModel,
                                  HttpServletRequest request,
                                  @RequestParam("name") String eventName,
                                  @RequestParam("date") String eventDate,
                                  @RequestParam("endDate") String eventEndDate,
                                  @RequestParam("description")String eventDescription,
                                  @RequestParam("eventCover") MultipartFile eventCover) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        boolean validation = true;

        Event event = new Event();

        if (CreateEvent.validate(eventName)) {
            Event existEvent = eventService.findEventByName(eventName);
            if(existEvent == null ) {
                event.setName(eventName);
            } else {
                validation = false;
                theModel.addAttribute("eventNameError", "This event already exists");
            }

        } else {
            validation = false;
            theModel.addAttribute("eventNameError", "A name cannot be more than 12 characters ");
        }

        Date startDate = null;
        Date endDate = null;
        try {
            startDate = formatter.parse(eventDate);
            endDate = formatter.parse(eventEndDate);


            if (CreateEvent.validate(startDate, endDate)) {
                event.setDate(startDate);
                event.setEndDate(endDate);
                System.out.println(event.getEndDate() + " " + event.getDate());
            } else {
                validation = false;
                theModel.addAttribute("eventEndDateError", "End date must be after starting date");
            }
        } catch (Exception e) {
            validation = false;
            theModel.addAttribute("eventDate", "Please give a correct date");
        }

        if (!eventCover.isEmpty()) {
            try {
                String extension = FilenameUtils.getExtension(eventCover.getOriginalFilename());
                String name = event.getName() + System.currentTimeMillis() + "." + extension;
                eventCover.transferTo(new File(session.getServletContext().getRealPath("/assets/img/events/") + name));
                event.setCoverPhoto(name);
            } catch (IOException e) {
                theModel.addAttribute("eventPhotoError", "Upload photo has failed");
                validation = false;
            }
        } else {
            event.setCoverPhoto("default.jpg");
        }

        event.setName(eventName);
        event.setDescription(eventDescription);

        if (validation) {
            event.setClub(user.getClub());
            eventService.createEvent(event);
            theModel.addAttribute("eventAddSuccess", "The event has been added successfully");
            return "event/createEvent";
        }

        theModel.addAttribute("event", event);
        return "event/createEvent";
    }

    @GetMapping("/filterEvents")
    public String processFilterEvent(@RequestParam("selectedClub")String selectedClub,
                                     @RequestParam("dateRange")String dateRange,
                                     Model theModel) {
        List<Event> events = null;

        if(selectedClub.equals("All Clubs")) {
            try {
                String[] dates = dateRange.split(" - ");
                String startDate = formatterDay.format(formatterDay.parse(dates[0]));
                String endDate = formatterDay.format(formatterDay.parse(dates[1]));

                events = eventService.findAllEventsBetween(startDate,endDate);
            } catch (Exception e) {
                events=eventService.findAllEvents();
            }
        }
        else {
            try {
                String[] dates = dateRange.split(" - ");
                String startDate = formatterDay.format(formatterDay.parse(dates[0]));
                String endDate = formatterDay.format(formatterDay.parse(dates[1]));
                events = eventService.findClubEventsBetween(startDate,endDate,selectedClub);
            } catch (Exception e) {
                events = eventService.findClubEvents(selectedClub);
            }
        }

        theModel.addAttribute("events",events);
        return "/event/filterEvents";
    }

    @GetMapping("/{eventId}/participate")
    public String participate(@PathVariable int eventId, HttpServletRequest request) throws UnauthorizedException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user == null)
            return "redirect:/login";
        eventService.addParticipant(eventId, user);

        return "redirect:/event/" + eventId;
    }

    @GetMapping("/{eventId}/unparticipate")
    public String unparticipate(@PathVariable int eventId, HttpServletRequest request) throws UnauthorizedException{

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        eventService.removeParticipant(eventId, user);

        return "redirect:/event/" + eventId;
    }

    @GetMapping("/manage")
    public String manageEvents(Model theModel,
                               HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Club club = user.getClub();
        List<Event> events = eventService.findClubEvents(club.getName());

        theModel.addAttribute("events",events);
        return "event/manageEvent";
    }

    @PostMapping("/selectUpdate")
    public String formUpdateEvent(Model theModel,
                                  HttpServletRequest request,
                                  @RequestParam("selectedEvent")String eventName) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Club club = user.getClub();
        List<Event> events = eventService.findClubEvents(club.getName());
        theModel.addAttribute("events",events);

        Event event = eventService.findEventByName(eventName);
        theModel.addAttribute("event",event);

        return "event/manageEvent";
    }

    @PostMapping("/update")
    public  String processUpdateEvent(Model theModel,
                                      HttpServletRequest request,
                                      @RequestParam("name") String eventName,
                                      @RequestParam("date") String eventDate,
                                      @RequestParam("endDate") String eventEndDate,
                                      @RequestParam("description")String eventDescription) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Club club = user.getClub();
        List<Event> events = eventService.findClubEvents(club.getName());
        theModel.addAttribute("events",events);

        Event event = eventService.findEventByName(eventName);

        Date startDate = null;
        Date endDate = null;
        boolean validation = true;
        try {
            startDate = formatter.parse(eventDate);
            endDate = formatter.parse(eventEndDate);

            if (CreateEvent.validate(startDate, endDate)) {
                event.setDate(startDate);
                event.setEndDate(endDate);
            } else {
                validation = false;
                theModel.addAttribute("eventEndDateError", "End date must be after starting date");
            }
        } catch (Exception e) {
            validation = false;
            theModel.addAttribute("eventDate", "Please give a correct date");
        }

        if (validation) {
            event.setDescription(eventDescription);
            eventService.update(event);
            theModel.addAttribute("eventAddSuccess", "The update succeeded");
            return "event/manageEvent";
        }

        theModel.addAttribute("event",event);
        return "event/manageEvent";
    }

    @PostMapping("/delete")
    public  String processDeleteEvent(Model theModel,
                                      HttpServletRequest request,
                                      @RequestParam("selectedEvent") String eventName) {


        eventService.deleteByName(eventName);
        theModel.addAttribute("eventDeleteSuccess", "The Delete succeeded");

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Club club = user.getClub();
        List<Event> events = eventService.findClubEvents(club.getName());
        theModel.addAttribute("events",events);
        return "event/manageEvent";
    }
}


