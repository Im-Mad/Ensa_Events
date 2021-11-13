package ma.ensaevents.dao;

import java.util.List;

import ma.ensaevents.entity.Role;

public interface RoleDao {

	public Role findRoleByName(String theRoleName);
	
	public List<Role> getRoles();
	
}
