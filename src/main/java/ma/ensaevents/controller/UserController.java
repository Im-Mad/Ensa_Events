package ma.ensaevents.controller;

import ma.ensaevents.entity.Club;
import ma.ensaevents.entity.Event;
import ma.ensaevents.entity.User;
import ma.ensaevents.service.UserService;
import ma.ensaevents.utils.UpdatePassword;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.List;

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
    public String formUpdateUser(Model theModel) {
        theModel.addAttribute("changePassword", new UpdatePassword());
        return "user/account";
    }

    @PostMapping("/me")
    public String processUpdateUser(Model theModel,
                                    HttpServletRequest request,
                                    @RequestParam("firstName") String firstName,
                                    @RequestParam("lastName") String lastName,
                                    @RequestParam("email") String email,
                                    @RequestParam("avatarFile") MultipartFile avatarFile) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        user.setEmail(email);
        user.setFirstname(firstName);
        user.setLastname(lastName);

        if(!avatarFile.isEmpty()) {
            try {
                String extension = FilenameUtils.getExtension(avatarFile.getOriginalFilename());
                String name = user.getUsername()+System.currentTimeMillis()+"."+extension;
                avatarFile.transferTo(new File(session.getServletContext().getRealPath("/assets/img/users/")+name));
                user.setAvatar(name);
            } catch (IOException e) {
                theModel.addAttribute("updateResultError","Update Failed");
                return "club/updateClub";
            }
        }
        userService.update(user);
        theModel.addAttribute("changePassword", new UpdatePassword());
        theModel.addAttribute("updateResultSuccess","Update Succeeded");
        return "user/account";
    }

    @PostMapping("/updatePassword")
    public String processUpdatePassword(
                        @Valid @ModelAttribute("changePassword") UpdatePassword changePassword,
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

    @GetMapping("/myEvents")
    public String myEvents(Model theModel,
                           HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Event> events = userService.myEvents(user);

        theModel.addAttribute("events",events);
        return "user/myEvents";
    }

    @GetMapping("/myClubs")
    public String myClubs(Model theModel,
                           HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        List<Club> clubs = userService.myClubs(user);

        theModel.addAttribute("clubs",clubs);
        return "user/myClubs";
    }

    @GetMapping("/manage")
    public String manageUsers(Model theModel) {
        List<User> usersActive = userService.findActiveUsers();

        List<User> usersSuspended = userService.findSuspendedUsers();

        theModel.addAttribute("usersActive", usersActive);
        theModel.addAttribute("usersSuspended",usersSuspended);

        return "/admin/manageUsers";
    }
}