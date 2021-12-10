package ma.ensaevents.entity;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name="events")
public class Event {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="id")
    private int id;

    @Column(name="date")
    private Date date;

    @Column(name="name")
    private String name;

    @Column(name="description")
    private String description;

    @Column(name="cover_photo")
    private String coverPhoto;

    @ManyToOne
    @JoinColumn(name="club_id")
    private Club club;

    @ManyToMany
    @JoinTable(
            name="participants",
            joinColumns=@JoinColumn(name="event_id"),
            inverseJoinColumns=@JoinColumn(name="user_id")
    )
    private List<User> participants;

    @OneToMany(mappedBy = "event")
    private List<Review> reviews;

    @Transient
    private double avgRating;
    
    @Transient
    private int[] ratingStats = new int[5];

    @PostLoad
    public void calculateAvgRating(){
        if (reviews.size() == 0)
            avgRating = 4;
        else {
            try {
                avgRating = reviews.stream().mapToInt(o -> o.getRating()).average().getAsDouble();
                reviews.stream().forEach(review -> {
                    ratingStats[review.getRating()-1]++;
                });
            } catch (Exception e){
                e.printStackTrace();
            }
        }

    }

    public List<Review> getReviews() {
        return reviews;
    }

    public void setReviews(List<Review> reviews) {
        this.reviews = reviews;
    }

    public Event() {

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverPhoto() {
        return coverPhoto;
    }

    public void setCoverPhoto(String coverPhoto) {
        this.coverPhoto = coverPhoto;
    }

    public Club getClub() {
        return club;
    }

    public void setClub(Club club) {
        this.club = club;
    }

    public List<User> getParticipants() {
        return participants;
    }

    public void setParticipants(List<User> participants) {
        this.participants = participants;
    }

    public double getAvgRating() {
        return avgRating;
    }

    public void setAvgRating(double avgRating) {
        this.avgRating = avgRating;
    }

    public int[] getRatingStats() {
        return ratingStats;
    }

    public void setRatingStats(int[] ratingStats) {
        this.ratingStats = ratingStats;
    }
}
