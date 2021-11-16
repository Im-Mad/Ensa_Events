package ma.ensaevents.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="event")
public class Event {


    @Id
    @GeneratedValue(strategy=GenerationType.IDENTITY)
    @Column(name="id")
    private int id;

    @Column(name="date")
    private String date;

    @Column(name="name")
    private String name;

    @Column(name="description")
    private String description;

    @Column(name="coverphoto")
    private String coverPhoto;

    @ManyToOne
    @JoinColumn(name="club_id")
    private Club club;

    public Event() {

    }


    public Event(String date, String name, String description, String coverPhoto) {
        super();
        this.date = date;
        this.name = name;
        this.description = description;
        this.coverPhoto = coverPhoto;
    }



    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
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


}
