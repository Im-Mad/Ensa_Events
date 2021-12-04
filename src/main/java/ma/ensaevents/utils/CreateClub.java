package ma.ensaevents.utils;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

public class CreateClub {

    private String username;

    @NotNull(message = "A club name is required")
    @Size(min = 1, message = "A club name is required")
    private String clubName;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getClubName() {
        return clubName;
    }

    public void setClubName(String clubName) {
        this.clubName = clubName;
    }
}
