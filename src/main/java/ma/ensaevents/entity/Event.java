package ma.ensaevents.entity;

import javax.persistence.*;
import java.time.Duration;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@Table(name = "events")
public class Event {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "date")
    private Date date;

    @Column(name="end_date")
    private Date endDate;

    @Column(name="name")
    private String name;

    @Column(name = "description")
    private String description;

    @Column(name = "cover_photo")
    private String coverPhoto;

    @ManyToOne
    @JoinColumn(name = "club_id")
    private Club club;

    @ManyToMany
    @JoinTable(
            name = "participants",
            joinColumns = @JoinColumn(name = "event_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<User> participants;

    @OneToMany(mappedBy = "event")
    private List<Review> reviews;

    @Transient
    private double avgRating;

    @Transient
    private EventStatus status;

    @Transient
    private Long leftDays;

    @Transient
    private int[] ratingStats = new int[5];

    @Transient
    private List<String> reviewers = new ArrayList<>();


    @PostLoad
    public void calculation() {
        if (reviews.size() == 0)
            avgRating = 4;
        else {
            try {
                avgRating = reviews.stream().mapToInt(o -> o.getRating()).average().getAsDouble();
                reviewers = reviews.stream().map(review -> review.getUser().getUsername()).collect(Collectors.toList());
                reviews.stream().forEach(review -> {
                    ratingStats[review.getRating() - 1]++;
                });
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (date.after(new Date())) {
            System.out.println("Hello" + id);
            System.out.println(date);
            System.out.println(new Date());
            status = EventStatus.UPCOMING;
            LocalDateTime date = this.date.toInstant().atZone(ZoneId.systemDefault()).toLocalDateTime();
            LocalDateTime now = LocalDateTime.now();
            leftDays = Duration.between(now, date).toDays();
            System.out.println ("Days: " + leftDays);
        }

        else if(endDate.before(new Date()))
            status = EventStatus.ENDED;
        else status =  EventStatus.ONGOING;
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

    public Long getLeftDays() {
        return leftDays;
    }

    public void setLeftDays(Long leftDays) {
        this.leftDays = leftDays;
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

    public void setStatus(EventStatus status) {
        this.status = status;
    }

    public List<String> getReviewers() {
        return reviewers;
    }

    public void setReviewers(List<String> reviewers) {
        this.reviewers = reviewers;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public EventStatus getStatus() {
        return status;
    }
}
