package ma.ensaevents.dao;
import ma.ensaevents.entity.Event;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import ma.ensaevents.entity.Review;
import ma.ensaevents.entity.User;

public interface ReviewDao {

    public void saveReview(Review review);

    public List<Review> getReviews(Event event);

    public Review getReview(int reviewId);

    public void deleteReview(Review review);
}
