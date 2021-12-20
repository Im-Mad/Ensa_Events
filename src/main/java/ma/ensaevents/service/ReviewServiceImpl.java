package ma.ensaevents.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ma.ensaevents.entity.Event;
import ma.ensaevents.dao.ReviewDaoImpl;
import ma.ensaevents.entity.Review;
import ma.ensaevents.entity.User;

@Service
public class ReviewServiceImpl implements ReviewService {


    @Autowired
    private ReviewDaoImpl reviewDao;

    @Override
    @Transactional
    public void saveReview(Review review) {
        reviewDao.saveReview( review);

    }

    @Override
    @Transactional
    public List<Review> getReviews(Event event) {
        return reviewDao.getReviews(event);
    }

    @Override
    @Transactional
    public Review getReview(int reviewId) {
        return reviewDao.getReview(reviewId);
    }

    @Override
    @Transactional
    public void deleteReview(Review review) {
        reviewDao.deleteReview( review);
    }

}
