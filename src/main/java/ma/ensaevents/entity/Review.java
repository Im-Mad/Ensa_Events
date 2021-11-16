package ma.ensaevents.entity;

import java.io.Serializable;

import javax.persistence.*;
import javax.validation.constraints.Size;



@Entity
@Table(name="review")
public class Review {

    @Id
    @Column(name="id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name="description")
    private String description;

    @Column(name="rating")
    private int rating;

    @ManyToOne
    @JoinColumn(name="user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name="event_id")
    private Event event;

    // Constructeurs
    public Review() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Event getEvent() {
        return event;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    @Override
    public String toString() {
        return "Review{" +
                "id=" + id +
                ", description='" + description + '\'' +
                ", rating=" + rating +
                ", user=" + user.getUsername() +
                ", event=" + event.getId() +
                '}';
    }
}
