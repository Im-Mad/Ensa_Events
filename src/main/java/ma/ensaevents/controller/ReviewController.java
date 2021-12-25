package ma.ensaevents.controller;

import java.util.Date;
import java.util.List;

import ma.ensaevents.exceptions.NotFoundException;
import ma.ensaevents.exceptions.UnauthorizedException;
import ma.ensaevents.service.EventService;
import ma.ensaevents.service.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import ma.ensaevents.entity.Event;
import ma.ensaevents.entity.Review;
import ma.ensaevents.entity.User;
import ma.ensaevents.service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/reviews")
public class ReviewController {

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private UserService userService;
    @Autowired
    private EventService eventService;
    
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

        final String redirectUrl = "redirect:/event/" + eventId;
        return redirectUrl;
    }

    @GetMapping("/delete/{id}")
    public String deleteReview(@PathVariable("id") int reviewId,
                               @RequestParam(value = "redirect", defaultValue = "0") int eventId,
                               HttpServletRequest request)
            throws NotFoundException, UnauthorizedException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if(user == null)
            throw new UnauthorizedException();

        //get the review from db
        Review review = reviewService.getReview(reviewId);
        if (review == null)
            throw new NotFoundException();
        reviewService.deleteReview(review);
        if (eventId == 0)
            return "redirect:/";
        else
            return "redirect:/event/" + eventId;
    }
}
