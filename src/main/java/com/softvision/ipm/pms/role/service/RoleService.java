package com.softvision.ipm.pms.role.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.softvision.ipm.pms.common.util.CollectionUtil;
import com.softvision.ipm.pms.employee.entity.Employee;
import com.softvision.ipm.pms.role.entity.Role;
import com.softvision.ipm.pms.role.repo.RoleDataRepository;
import com.softvision.ipm.pms.role.repo.RoleRepository;

@Service
public class RoleService {

	@Autowired private RoleDataRepository roleDataRepository;
	
	@Autowired private RoleRepository roleRepository;

	public List<Role> getRoles() {
		return CollectionUtil.toList(roleDataRepository.findAll());
	}

	public List<Role> getRole(int roleId) {
		return roleDataRepository.findById(roleId);
	}

	public List<Role> getRolesbyEmployeeId(Long employeeId) {
		return roleDataRepository.findByEmployeeId(employeeId);
	}

	public List<Employee> getEmployeesbyRoleId(int roleId) {
		return roleDataRepository.findEmployeesbyRoleId(roleId);
	}

	public int assignRole(Long employeeId,int roleId){
		 return roleRepository.assign(employeeId,roleId);
	}
	
	public int removeRole(Long employeeId,int roleId){
		return roleRepository.remove(employeeId,roleId);
	}

}
