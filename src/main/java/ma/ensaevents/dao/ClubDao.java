package ma.ensaevents.dao;

import java.util.List;

import ma.ensaevents.entity.Club;


public interface ClubDao {

    public List<Club> getClubs();

    public void saveClub(Club theClub);

    public Club getClub(int theId);

    public void deleteClub(int theId);

    public Club findByUserName(String name);
}
