package ma.ensaevents.controller;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import ma.ensaevents.entity.User;
import ma.ensaevents.service.UserService;
import ma.ensaevents.user.CrmUser;

import java.net.http.HttpResponse;


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
		
		theModel.addAttribute("crmUser", new CrmUser());
		
		return "registration-form";
	}

	@PostMapping("/register")
	public String processRegistrationForm(
			@Valid @ModelAttribute("crmUser") CrmUser theCrmUser,
			BindingResult theBindingResult, 
			Model theModel,
			HttpServletResponse response) {
	
		String username = theCrmUser.getUserName();
		
		// check the database if user already exists
	    User existing = userService.findByUserName(username);
	    
	    if (existing != null){
	    	theModel.addAttribute("crmUser", theCrmUser);
			theModel.addAttribute("registrationError", "Username already exists.");
	    	return "registration-form";
	    }

		if(theBindingResult.hasErrors()) {
			return "registration-form";
		}
	    
	    // create user account        						
	    return "registration-confirmation";
	}
}
