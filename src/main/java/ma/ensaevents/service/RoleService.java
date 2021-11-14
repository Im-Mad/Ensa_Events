package ma.ensaevents.service;

import ma.ensaevents.entity.Role;

public interface RoleService {
	
	Role findByUserName(String roleName);
}
