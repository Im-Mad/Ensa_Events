//Entity CLUB----------------------------------------

//---------------------------------------------------
package ma.ensaevents.entity;

//import java.util.List;

import javax.persistence.*;
import java.util.List;
//import javax.persistence.OneToMany;


@Entity
@Table(name="club")
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

    @Column(name="coverphoto")
    private String cover_photo;


    @OneToOne(cascade=CascadeType.ALL)
    @JoinColumn(name="user_id")
    private User user;

	@OneToMany(mappedBy = "club",cascade=CascadeType.ALL,fetch = FetchType.EAGER)
	private List<Event> events;

    //getters and setters ----------------------------

    public Club() {

    }



    public Club( String name, String description, String logo, String cover_photo) {

        this.name = name;
        this.description = description;
        this.logo = logo;
        this.cover_photo = cover_photo;
        //this.user = user;
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



    public String getCover_photo() {
        return cover_photo;
    }



    public void setCover_photo(String cover_photo) {
        this.cover_photo = cover_photo;
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


}




