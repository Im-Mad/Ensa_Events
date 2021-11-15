package ma.ensaevents.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ma.ensaevents.entity.Club;
import ma.ensaevents.service.ClubService;


@Controller
@RequestMapping("/club")
public class ClubController {

    @Autowired
    private ClubService clubService;

    @GetMapping("/list")
    public String listClubs(Model theClub) {

        List<Club> theClubs = clubService.getClubs();

        theClub.addAttribute("clubs",theClubs);

        return null;
    }


    @GetMapping("/add")
    public String showFormForAdd(Model theModel) {
        Club theClub = new Club();
        theModel.addAttribute("club", theClub);
        return "club-form";
    }


    @PostMapping("/saveClub")
    public String saveClub(@ModelAttribute("club") Club theClub) {
        clubService.saveClub(theClub);
        return "club-confirmation";
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
