package ma.ensaevents.service;


import java.util.List;

import ma.ensaevents.entity.Club;
import ma.ensaevents.entity.User;
import ma.ensaevents.utils.CreateClub;

public interface ClubService {

     List<Club> getClubs();

     void createClub (CreateClub newClub);

      Club getClub(int theId);

     void deleteClub(int theId);

     Club getClubByName(String name);

    void update(Club club);

    void addMember(String clubName, User user);

    void removeMember(String clubName, User user);
}
