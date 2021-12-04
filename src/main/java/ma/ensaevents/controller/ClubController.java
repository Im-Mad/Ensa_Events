package ma.ensaevents.controller;

import java.util.List;

import ma.ensaevents.service.UserService;
import ma.ensaevents.utils.CreateClub;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import ma.ensaevents.entity.Club;
import ma.ensaevents.service.ClubService;

import javax.validation.Valid;


@Controller
@RequestMapping("/club")
public class ClubController {

    @Autowired
    private ClubService clubService;

    @Autowired
    private UserService userService;

    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {

        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);

        dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
    }

    @GetMapping("/all")
    public String listClubs(Model theModel) {

        List<Club> theClubs = clubService.getClubs();

        theModel.addAttribute("clubs",theClubs);

        return "user/login";
    }

    @GetMapping("/{id}")
    public String getClub(Model model, @PathVariable int id) {
        System.out.println(id);
        Club club = clubService.getClub(id);
        model.addAttribute("club",club);
        return "createClub";
    }


    @GetMapping("/create")
    public String formCreateClub(Model theModel) {
        CreateClub newClub = new CreateClub();
        theModel.addAttribute("newClub", newClub);

        List<String> usernames = userService.usersUsernames();
        theModel.addAttribute("userNames",usernames);

        return "admin/createClub";
    }

    @PostMapping("/create")
    public String processCreateClub(@Valid @ModelAttribute("newClub") CreateClub newClub,
                                    BindingResult theBindingResult,
                                    Model theModel) {
        String name = newClub.getClubName();

        Club existing = clubService.getClubByName(name);


        if (existing != null){
            theModel.addAttribute("newClub", newClub);
            List<String> usernames = userService.usersUsernames();
            theModel.addAttribute("userNames",usernames);
            theModel.addAttribute("registrationError", "Username already exists.");
            return "admin/createClub";
        }

        if(theBindingResult.hasErrors()) {
            List<String> usernames = userService.usersUsernames();
            theModel.addAttribute("userNames",usernames);
            return "admin/createClub";
        }

        clubService.createClub(newClub);
        theModel.addAttribute("creationClubConfirmation","The club is created successfully");
        return "admin/createClub";
    }



    @GetMapping("/update")
    public String showFormForUpdate(@RequestParam("club_id") int theId,
                                    Model theModel) {

        Club theClub = clubService.getClub(theId);

        theModel.addAttribute("club", theClub);


        return null;
    }

    @GetMapping("/delete")
    public String deleteClub(@RequestParam("clubId") int theId) {


        clubService.deleteClub(theId);

        return null;
    }



}
