package ma.ensaevents.controller;

import java.util.Date;
import java.util.List;

import ma.ensaevents.service.EventService;
import ma.ensaevents.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


import ma.ensaevents.entity.Event;
import ma.ensaevents.entity.Review;
import ma.ensaevents.entity.User;
import ma.ensaevents.service.UserService;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private UserService userService;
    @Autowired
    private EventService eventService;

    //----------------- GET EVENT's REVIEWS ------------------------
    @GetMapping("/list")
    public String listCustomers(@RequestParam("eventId") int eventId, Model theModel) {

        Event event = eventService.findByEventId(eventId);
        List<Review> reviews = reviewService.getReviews(event);

        // add the reviews to the model
        theModel.addAttribute("reviews", reviews);

        //return a view that contains all the EVENT's Reviews
        return "add-review";
    }


    @GetMapping("/showFormToAddReview")
    public String addReview(@RequestParam("eventId") int eventId , Model theModel)
    {
        //create model attribute to bin form data
        Review review = new Review();
        theModel.addAttribute("eventId",eventId);
        theModel.addAttribute("review",review);

        //return a form where the user will write the review
        return "add-review";
    }

    @PostMapping("/add")
    public String saveReview(@ModelAttribute("review") Review review, HttpServletRequest request) {

            Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
            String username = ((org.springframework.security.core.userdetails.User) principal).getUsername();

            User user = userService.findByUserName(username);

            int eventId = Integer.parseInt(request.getParameter("eventId"));
            //get EVENT by event_id
            Event event = eventService.findByEventId(eventId);
            review.setUser(user);
            review.setEvent(event);
            review.setDate(new Date());
            System.out.println(user);
            System.out.println(event);

            reviewService.saveReview(review);

           return "redirect:" + request.getContextPath() + "/event/" + eventId;
    }

    //------------------------UPDATE THE REVIEW--------------------------------
    @GetMapping("/showFormToUpdateReview")
    public String showFormUpdate(@RequestParam("eventId") int eventId ,
                                 Model theModel) {

        //get EVENT
        Event event = eventService.findByEventId(eventId);

        //get USER by USERNAME
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userName  =((org.springframework.security.core.userdetails.User) principal).getUsername();
        User user = userService.findByUserName(userName);

        //get the review from db
        Review review = reviewService.getReview(event, user);

        //set customer as a model att ribute
        theModel.addAttribute("review",review);

        //send over to our form
        return "form-add-review";
    }

    @GetMapping("/delete")
    public String deleteReview(@RequestParam("eventId") int eventId) {

        //get EVENT
        Event event = eventService.findByEventId(eventId);

        //get USER by USERNAME
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String userName  =((org.springframework.security.core.userdetails.User) principal).getUsername();
        User user = userService.findByUserName(userName);

        //get the review from db
        Review review = reviewService.getReview(event, user);

        reviewService.deleteReview(review);
        return "redirect:/review/list";
    }


}
