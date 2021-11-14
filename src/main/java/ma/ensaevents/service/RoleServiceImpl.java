package ma.ensaevents.service;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ma.ensaevents.dao.RoleDao;
import ma.ensaevents.entity.Role;


@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleDao roleDao;

	@Override
	@Transactional
	public Role findByUserName(String roleName) {
		return roleDao.findRoleByName(roleName);
	}
	

}
