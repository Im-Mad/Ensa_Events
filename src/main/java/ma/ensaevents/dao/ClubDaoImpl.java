package ma.ensaevents.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import ma.ensaevents.entity.Club;



@Repository
public class ClubDaoImpl implements ClubDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    public List<Club> getClubs() {
        Session currentSession = sessionFactory.getCurrentSession();

        Query<Club> theQuery = currentSession.createQuery("from Club order by name",Club.class);

        return theQuery.getResultList();

    }

    @Override
    public  void  saveClub(Club theClub) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(theClub);
    }

    @Override
    public Club getClub(int theId) {

        Session currentSession = sessionFactory.getCurrentSession();

        Club theClub = currentSession.get(Club.class, theId);

        return theClub;
    }

    @Override
    public void deleteClub(int theId) {
        // get the current hibernate session
        Session currentSession = sessionFactory.getCurrentSession();

        // delete object with primary key
        Query<Club> theQuery =
                currentSession.createQuery("delete from Club where id=:clubId",Club.class);
        theQuery.setParameter("clubId", theId);

        theQuery.executeUpdate();

    }

    @Override
    public Club findByName(String name) {
        // get the current hibernate session
        Session currentSession = sessionFactory.getCurrentSession();

        // now retrieve/read from database using username
        Query<Club> theQuery = currentSession.createQuery("FROM Club where name=:cName", Club.class);
        theQuery.setParameter("cName", name);
        Club club = null;
        try {
            club = theQuery.getSingleResult();
            club.getMembers().size();
        } catch (Exception ignored) {
        }

        return club;
    }


}
