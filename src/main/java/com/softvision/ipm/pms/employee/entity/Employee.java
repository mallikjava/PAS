package com.softvision.ipm.pms.employee.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity
public class Employee implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(unique=true)
	private Integer employeeId;

	private String firstName;

	private String lastName;

	private String employmentType;

	private String designation;

	private String band;

	private Date hiredOn;

	private String location;

	@Column(unique=true)
	private String loginId;

	private String department;

    private String division;

    private String org;

    private String active;

	@Override
	public String toString() {
		return "Employee [employeeId=" + employeeId + ", firstName=" + firstName + ", lastName=" + lastName
				+ ", employmentType=" + employmentType + ", designation=" + designation + ", band=" + band
				+ ", hiredOn=" + hiredOn + ", location=" + location + ", loginId=" + loginId + ", department="
				+ department + ", division=" + division + ", org=" + org + ", active=" + active + "]";
	}

}
