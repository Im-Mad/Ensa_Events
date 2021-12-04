package ma.ensaevents.service;

import java.util.List;

import ma.ensaevents.dao.RoleDao;
import ma.ensaevents.entity.Role;
import ma.ensaevents.entity.User;
import ma.ensaevents.utils.CreateClub;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ma.ensaevents.dao.ClubDao;
import ma.ensaevents.entity.Club;

@Repository
@Service
public class ClubServiceImpl  implements ClubService{

    @Autowired
    private ClubDao clubDao;

    @Autowired
    private UserService userService;

    @Autowired
    private RoleDao roleDao;


    @Override
    @Transactional
    public List<Club> getClubs() {

        return clubDao.getClubs();
    }

    @Override
    @Transactional
    public void createClub(CreateClub newClub) {

        User user = userService.findByUserName(newClub.getUsername());

        Role role=roleDao.findRoleByName("ROLE_MANAGER");
        user.setRole(role);
        userService.update(user);

        Club club = new Club();
        club.setName(newClub.getClubName());
        club.setUser(user);
        clubDao.saveClub(club);
    }

    @Override
    @Transactional
    public Club getClub(int theId) {
        return clubDao.getClub(theId);
    }

    @Override
    @Transactional
    public void deleteClub(int theId) {
        clubDao.deleteClub(theId);

    }

    @Override
    @Transactional
    public Club getClubByName(String name) {
        // check the database if the user already exists
        return clubDao.findByUserName(name);
    }
}
