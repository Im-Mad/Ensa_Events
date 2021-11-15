package ma.ensaevents.service;


import java.util.List;

import ma.ensaevents.entity.Club;

public interface ClubService {

    public List<Club> getClubs();

    public void saveClub (Club theClub);

    public  Club getClub(int theId);

    public void deleteClub(int theId);


}
