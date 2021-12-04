package ma.ensaevents.controller;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import ma.ensaevents.utils.CreateUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import ma.ensaevents.entity.User;
import ma.ensaevents.service.UserService;


@Controller
public class RegistrationController {
	
    @Autowired
    private UserService userService;
 
	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		
		StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
		
		dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
	}	
	
	@GetMapping("/register")
	public String showMyLoginPage(Model theModel) {
		
		theModel.addAttribute("newUser", new CreateUser());
		
		return "user/registration-form";
	}

	@PostMapping("/register")
	public String processRegistrationForm(
			@Valid @ModelAttribute("newUser") CreateUser newUser,
			BindingResult theBindingResult,
			Model theModel,
			HttpServletRequest request) throws ServletException {
	
		String username = newUser.getUserName();
		
		// check the database if user already exists
	    User existing = userService.findByUserName(username);
	    
	    if (existing != null){
	    	theModel.addAttribute("newUser", newUser);
			theModel.addAttribute("registrationError", "Username already exists.");
	    	return "user/registration-form";
	    }

		if(theBindingResult.hasErrors()) {
			return "user/registration-form";
		}

		userService.save(newUser);

	    return "user/login";
	}
}
