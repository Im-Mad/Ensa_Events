package ma.ensaevents.controller;

import java.util.List;

import ma.ensaevents.entity.Club;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import ma.ensaevents.entity.Event;
import ma.ensaevents.service.EventService;

@Controller
@RequestMapping("/event")
public class EventController {

    @Autowired
    private EventService eventService;

    @GetMapping("/list")
    public String eventsList(Model model) {

        List<Event> events = eventService.findAllEvents();

        model.addAttribute("events", events);

        return "home";
    }

    @GetMapping("/{id}")
    public String getEvent(@PathVariable int id, Model model){

        Event event = eventService.findByEventId(id);
        model.addAttribute("event", event);

        return "event/event";
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


