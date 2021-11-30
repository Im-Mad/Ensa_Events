package ma.ensaevents.controller;

import javax.servlet.http.HttpServletRequest;


import ma.ensaevents.entity.Club;
import ma.ensaevents.entity.Event;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import ma.ensaevents.service.UserService;
import ma.ensaevents.service.ClubService;
import ma.ensaevents.service.EventService;

import java.util.List;

@Controller
public class HomeController {

	@Autowired
	UserService userService;
	@Autowired
	ClubService clubService;
	@Autowired
	EventService eventService;

	
	@GetMapping("/")
	public String homePage(Model theModel,HttpServletRequest request) {
		/*if (true) {
			Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			String username  =((org.springframework.security.core.userdetails.User) principal).getUsername();

			User user = userService.findByUserName(username);
			theModel.addAttribute("currentUser", user);
		}*/

		List<Event> events = eventService.findAllEvents();
		theModel.addAttribute("events",events);

		List<Club> clubs = clubService.getClubs();
		theModel.addAttribute("clubs",clubs);

		return "home";
	}
}
