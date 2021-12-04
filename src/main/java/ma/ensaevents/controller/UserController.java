package ma.ensaevents.controller;

import ma.ensaevents.entity.User;
import ma.ensaevents.service.UserService;
import ma.ensaevents.utils.ChangePassword;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
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

        theModel.addAttribute("changePassword", new ChangePassword());
        return "user/account";
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
        // TODO if change it cut the password field
        return "user/account";
    }

    // TODO Change to UpdateUser
    @PostMapping("/updatePassword")
    public String updatePassword(
                        @Valid @ModelAttribute("changePassword") ChangePassword changePassword,
                        BindingResult theBindingResult,
                        Model theModel,
                        HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");


        if(!userService.checkPassword(user, changePassword)) {
            theModel.addAttribute("oldPasswordMatch", "The password is incorrect");
            return "user/account";
        }


        if(theBindingResult.hasErrors()) {
            return "user/account";
        }


        userService.changePassword(request, changePassword);


        theModel.addAttribute("passwordChangeConfirm", "The password change is confirmed");
        return "user/account";
    }
}