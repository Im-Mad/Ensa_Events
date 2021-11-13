package ma.ensaevents.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import ma.ensaevents.entity.User;
import ma.ensaevents.service.UserService;

@Controller
public class HomeController {

	@Autowired
	UserService userService;
	
	@GetMapping("/")
	public String homePage(Model theModel,HttpServletRequest request) {
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username  =((org.springframework.security.core.userdetails.User) principal).getUsername();
		

		User user = userService.findByUserName(username);
		
		theModel.addAttribute("currentUser", user);
		
		return "home";
	}
}
