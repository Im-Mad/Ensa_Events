package ma.ensaevents.service;

import java.util.List;

import ma.ensaevents.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ma.ensaevents.dao.ClubDao;
import ma.ensaevents.entity.Club;

@Repository
@Service
public class ClubServiceImpl  implements ClubService{

    @Autowired
    private ClubDao clubDAO;

    @Autowired
    private UserService userService;


    @Override
    @Transactional
    public List<Club> getClubs() {

        return clubDAO.getClubs();
    }

    @Override
    @Transactional
    public void saveClub(Club theClub) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username  =((org.springframework.security.core.userdetails.User) principal).getUsername();

        User user = userService.findByUserName(username);

        theClub.setUser(user);

        clubDAO.saveClub(theClub);
    }

    @Override
    @Transactional
    public Club getClub(int theId) {

        return clubDAO.getClub(theId);
    }

    @Override
    @Transactional
    public void deleteClub(int theId) {

        clubDAO.deleteClub(theId);


    }


}
