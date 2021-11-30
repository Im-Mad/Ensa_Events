package ma.ensaevents.controller;

import ma.ensaevents.entity.User;
import ma.ensaevents.service.EventService;
import ma.ensaevents.service.ReviewService;
import ma.ensaevents.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;

    @GetMapping("/me")
    public String getUserAccount() {
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
}