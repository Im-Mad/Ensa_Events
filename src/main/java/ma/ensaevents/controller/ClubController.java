package ma.ensaevents.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import ma.ensaevents.entity.User;
import ma.ensaevents.exceptions.NotFoundException;
import ma.ensaevents.exceptions.UnauthorizedException;
import ma.ensaevents.service.UserService;
import ma.ensaevents.utils.CreateClub;
import org.apache.commons.io.FilenameUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import ma.ensaevents.entity.Club;
import ma.ensaevents.service.ClubService;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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

    @GetMapping("/{clubName}")
    public String getClub(Model model, @PathVariable String clubName) throws NotFoundException {
        Club club = clubService.getClubByName(clubName);
        if (club == null)
            throw new NotFoundException();
        model.addAttribute("club",club);
        return "club/club";
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
    public String formUpdateClub(HttpServletRequest request,
                                    Model theModel) {
        HttpSession session=request.getSession();
        User user = (User) session.getAttribute("user");

        Club club = user.getClub();
        theModel.addAttribute("club", club);

        return "club/updateClub";
    }

    @PostMapping("/update")
    public String processUpdateClub(@RequestParam("description") String description,
                                    @RequestParam("clubLogoFile") MultipartFile LogoFile,
                                    @RequestParam("clubCoverFile") MultipartFile CoverFile,
                                    HttpSession session,
                                    HttpServletRequest request,
                                    Model theModel) {
        HttpSession sess=request.getSession();
        User user = (User) sess.getAttribute("user");
        Club club = user.getClub();

        theModel.addAttribute("club",club);

        if(!LogoFile.isEmpty()) {
            try {
                String extension = FilenameUtils.getExtension(LogoFile.getOriginalFilename());
                String name = club.getName()+System.currentTimeMillis()+"."+extension;
                LogoFile.transferTo(new File(session.getServletContext().getRealPath("/assets/img/clubs/logos/")+name));
                club.setLogo(name);
            } catch (IOException e) {
                theModel.addAttribute("updateResultError","Update Failed");
                return "club/updateClub";
            }
        }

        if(!CoverFile.isEmpty()) {
            try {
                String extension = FilenameUtils.getExtension(CoverFile.getOriginalFilename());
                String name = club.getName()+System.currentTimeMillis()+"."+extension;
                CoverFile.transferTo(new File(session.getServletContext().getRealPath("/assets/img/clubs/cover_photos/")+name));
                club.setCoverPhoto(name);
            } catch (IOException e) {
                theModel.addAttribute("updateResultError","Update Failed");
                return "club/updateClub";
            }
        }
        club.setDescription(description);
        clubService.update(club);
        theModel.addAttribute("club",club);
        theModel.addAttribute("updateResultSuccess","Update Succeeded");
        return "club/updateClub";
    }

    @GetMapping("/{clubName}/participate")
    public String participate(@PathVariable String clubName, HttpServletRequest request) throws UnauthorizedException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user == null)
            return "redirect:/login";
        clubService.addMember(clubName, user);

        return "redirect:/club/" + clubName;
    }

    @GetMapping("/{clubName}/unparticipate")
    public String unparticipate(@PathVariable String clubName, HttpServletRequest request) throws UnauthorizedException{

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        clubService.removeMember(clubName, user);

        return "redirect:/club/" + clubName;
    }
}
