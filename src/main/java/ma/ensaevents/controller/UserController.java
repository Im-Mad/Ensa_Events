package ma.ensaevents.controller;

import ma.ensaevents.entity.User;
import ma.ensaevents.service.EventService;
import ma.ensaevents.service.ReviewService;
import ma.ensaevents.service.UserService;
import ma.ensaevents.user.CrmPassword;
import ma.ensaevents.user.CrmUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {

        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);

        dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
    }

    @GetMapping("/me")
    public String getUserAccount(Model theModel) {

        theModel.addAttribute("crmPassword", new CrmPassword());
        return "account";
    }

    @PostMapping("/me")
    public String updateUserAccount(Model theModel,
                                    HttpServletRequest request,
                                    @RequestParam("firstName") String firstName,
                                    @RequestParam("lastName") String lastName,
                                    @RequestParam("email") String email) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        user.setEmail(email);
        user.setFirstname(firstName);
        user.setLastname(lastName);
        userService.update(user);
        return "account";
    }

    // TODO Change to crmUpdateUser
    @PostMapping("/updatePassword")
    public String updatePassword(
                        @Valid @ModelAttribute("crmPassword") CrmPassword crmPassword,
                        BindingResult theBindingResult,
                        Model theModel,
                        HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        System.out.println("ha 1");
        if(!userService.checkPassword(user,crmPassword)) {
            theModel.addAttribute("oldPasswordMatch", "The password is incorrect");
            return "account";
        }
        System.out.println("ha 2");

        if(theBindingResult.hasErrors()) {
            return "account";
        }
        System.out.println("ha 3");

        userService.changePassword(request,crmPassword);
        System.out.println("ha 4");

        theModel.addAttribute("passwordChangeConfirm", "The change is confirmed");
        return "account";
    }
}