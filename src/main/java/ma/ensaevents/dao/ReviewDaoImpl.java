package ma.ensaevents.dao;

import java.util.List;

import ma.ensaevents.entity.Event;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ma.ensaevents.entity.Review;
import ma.ensaevents.entity.User;


@Repository
public class ReviewDaoImpl implements ReviewDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public void saveReview(Review review) {

        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(review);

    }

    @Override
    public List<Review> getReviews(Event event) {

        Session currentSession = sessionFactory.getCurrentSession();
        Query<Review> query= currentSession.createQuery("FROM Review r WHERE event=:event",Review.class);
        query.setParameter("event",event );
        List<Review> reviews = query.getResultList();

        return reviews;
    }

    @Override
    public void deleteReview(Review review) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.delete(review);

    }

    @Override
    public Review getReview(int reviewId) {

        Session currentSession = sessionFactory.getCurrentSession();
        Review review = currentSession.get(Review.class, reviewId);

        return review;
    }



}
