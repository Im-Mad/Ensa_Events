package ma.ensaevents.controller;

import java.util.List;

import ma.ensaevents.entity.Club;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ma.ensaevents.entity.Event;
import ma.ensaevents.service.EventService;

@Controller
@RequestMapping("/events")
public class EventController {

    @Autowired
    private EventService eventService;

    @GetMapping("/list")
    public String eventsLis(Model model) {

        List<Event> events = eventService.findAllEvents();

        model.addAttribute("events", events);

        return "home";
    }

    @GetMapping("/add")
    public String addEvent(Model model) {
        Event event = new Event();

        model.addAttribute("event", event);

        return "add-event";
    }

    @PostMapping("/processAdd")
    public String addProcess(@ModelAttribute("event") Event event) {

        eventService.createEvent(event);

        return "event-confirmation";
    }
}
