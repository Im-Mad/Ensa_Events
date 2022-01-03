package ma.ensaevents.entity;

import javax.persistence.*;
import java.util.List;



@Entity
@Table(name="clubs")
public class Club {

    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="id")
    private int id;

    @Column(name="name")
    private String name;

    @Column(name="description")
    private String description;

    @Column(name="logo")
    private String logo;

    @Column(name= "cover_photo")
    private String coverPhoto;


    @OneToOne(cascade=CascadeType.ALL)
    @JoinColumn(name="user_id")
    private User user;

	@OneToMany(mappedBy = "club",fetch = FetchType.EAGER)
	private List<Event> events;

    @ManyToMany
    @JoinTable(
            name="members",
            joinColumns=@JoinColumn(name="club_id"),
            inverseJoinColumns=@JoinColumn(name="user_id")
    )
    private List<User> members;

    public Club() {
        this.logo = "default.png";
        this.coverPhoto = "default.jpg";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public String getCoverPhoto() {
        return coverPhoto;
    }

    public void setCoverPhoto(String cover_photo) {
        this.coverPhoto = cover_photo;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Event> getEvents() {
    		return events;
    	}

    public void setEvents(List<Event> events) {
        this.events = events;
    }

    public List<User> getMembers() {
        return members;
    }

    public void setMembers(List<User> members) {
        this.members = members;
    }

    public void addMember(User user) {
        this.members.add(user);
    }

    public void removeMember(User user) {
        this.members.remove(user);
    }
}




