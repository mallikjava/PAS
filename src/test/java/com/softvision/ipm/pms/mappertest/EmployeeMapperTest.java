package com.softvision.ipm.pms.mappertest;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

import java.text.MessageFormat;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.softvision.ipm.pms.employee.entity.Employee;
import com.softvision.ipm.pms.employee.mapper.EmployeeMapper;
import com.softvision.ipm.pms.employee.model.EmployeeDto;
import com.softvision.ipm.pms.employee.model.SVEmployee;
import com.softvision.ipm.pms.user.model.User;

@SpringBootTest
@RunWith(SpringRunner.class)
public class EmployeeMapperTest {

	private static final String IMAGE_URL = "https://opera.softvision.com/Content/Core/img/Profile/{0}.jpg";

	@Autowired private EmployeeMapper employeeMapper;

    @Test
    public void test_EmployeeNull() {
        assertNull(employeeMapper.getEmployeeDto((Employee) null));
    }

    @Test
    public void test_SVEmployeeNull() {
        assertNull(employeeMapper.getEmployee((SVEmployee) null));
    }

    @Test
    public void test_EmployeeRoleNull() {
        assertNull(employeeMapper.getUser((Employee) null, null));
    }

    @Test
    public void test_Employee_EmployeeDto_Valid() {
    	Employee employee = newEmployee();
    	EmployeeDto employeeDto = employeeMapper.getEmployeeDto(employee);

        assertNotNull(employeeDto);
        assertEquals(employee.getBand(), employeeDto.getBand());
        assertEquals(employee.getDesignation(), employeeDto.getDesignation());
        assertEquals((Integer)employee.getEmployeeId(), (Integer)employeeDto.getEmployeeId());
        assertEquals(employee.getEmploymentType(), employeeDto.getEmploymentType());
        assertEquals(employee.getFirstName(), employeeDto.getFirstName());
        assertEquals(employee.getHiredOn(), employeeDto.getHiredOn());
        assertEquals(employee.getLastName(), employeeDto.getLastName());
        assertEquals(employee.getLocation(), employeeDto.getLocation());
        assertEquals(employee.getLoginId(), employeeDto.getLoginId());
        assertEquals(employee.getFirstName() + " " + employee.getLastName(), employeeDto.getFullName());
    }

    @Test
    public void test_SVEmployee_Employee_Valid() {
    	SVEmployee svEmployee = newSVEmployee();
    	Employee employee = employeeMapper.getEmployee(svEmployee);

        assertNotNull(employee);
        assertEquals(svEmployee.getBand(), employee.getBand());
        assertEquals(svEmployee.getDesignation(), employee.getDesignation());
        assertEquals((Integer)svEmployee.getEmployeeId(), (Integer)employee.getEmployeeId());
        assertEquals(svEmployee.getEmploymentType(), employee.getEmploymentType());
        assertEquals(svEmployee.getFirstName(), employee.getFirstName());
        assertEquals(svEmployee.getHiredOn(), employee.getHiredOn());
        assertEquals(svEmployee.getLastName(), employee.getLastName());
        assertEquals(svEmployee.getLocation(), employee.getLocation());
        assertEquals(svEmployee.getLoginId(), employee.getLoginId());
    }

    @Test
    public void test_Employee_User_nullRolesValid() {
    	Employee employee = newEmployee();
    	User user = employeeMapper.getUser(employee, null);

        assertNotNull(user);
        assertEquals(employee.getBand(), user.getBand());
        assertEquals(employee.getDesignation(), user.getDesignation());
        assertEquals((Integer)employee.getEmployeeId(), (Integer)user.getEmployeeId());
        assertEquals(employee.getFirstName(), user.getFirstName());
        assertEquals(employee.getHiredOn(), user.getJoinedDate());
        assertEquals(employee.getLastName(), user.getLastName());
        assertEquals(employee.getLocation(), user.getLocation());
        assertEquals(employee.getLoginId(), user.getUsername());
        assertEquals(employee.getLoginId(), user.getUsername());
        assertEquals(MessageFormat.format(IMAGE_URL, employee.getEmployeeId()), user.getImageUrl());
        assertNull(user.getRoles());
    }

	private Employee newEmployee() {
    	Employee employee = new Employee();
    	employee.setActive("Y");
    	employee.setBand("Band");
    	employee.setDepartment("department");
    	employee.setDesignation("designation");
    	employee.setDivision("division");
    	employee.setEmployeeId(113);
    	employee.setEmploymentType("employmentType");
    	employee.setFirstName("firstName");
    	employee.setHiredOn(new Date());
    	employee.setLastName("lastName");
    	employee.setLocation("location");
    	employee.setLoginId("loginId");
    	employee.setOrg("org");
		return employee;
	}

	private SVEmployee newSVEmployee() {
		SVEmployee employee = new SVEmployee();
    	employee.setBand("Band");
    	employee.setDepartment("department");
    	employee.setDesignation("designation");
    	employee.setDivision("division");
    	employee.setEmployeeId(113);
    	employee.setEmploymentType("employmentType");
    	employee.setFirstName("firstName");
    	employee.setHiredOn(new Date());
    	employee.setLastName("lastName");
    	employee.setLocation("location");
    	employee.setLoginId("loginId");
    	employee.setOrg("org");
		return employee;
	}

}
