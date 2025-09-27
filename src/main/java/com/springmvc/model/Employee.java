package com.springmvc.model;

 
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
 
import javax.persistence.Table;

@Entity
@Table(name ="employees")
public class Employee {

	@Id
	@Column(nullable = false, length = 255)
	private String empUsername;
	
	@Column(nullable = false, length = 255)
	private String empPassword;
	
	@Column(nullable = false, length = 255)
	private String empname;
	
	@Column(nullable = false, length = 10)
	private String age;
	
	@Column(nullable = false, length = 255)
	private String position;
	
	@Column(nullable = true, length = 255)
	private String image;
	

	
	public Employee() {
		super();
		// TODO Auto-generated constructor stub
	}



	public Employee(String empUsername, String empPassword, String empname, String age, String position, String image) {
		super();
		this.empUsername = empUsername;
		this.empPassword = empPassword;
		this.empname = empname;
		this.age = age;
		this.position = position;
		this.image = image;
	}



	public String getEmpUsername() {
		return empUsername;
	}



	public void setEmpUsername(String empUsername) {
		this.empUsername = empUsername;
	}



	public String getEmpPassword() {
		return empPassword;
	}



	public void setEmpPassword(String empPassword) {
		this.empPassword = empPassword;
	}



	public String getEmpname() {
		return empname;
	}



	public void setEmpname(String empname) {
		this.empname = empname;
	}



	public String getAge() {
		return age;
	}



	public void setAge(String age) {
		this.age = age;
	}



	public String getPosition() {
		return position;
	}



	public void setPosition(String position) {
		this.position = position;
	}



	public String getImage() {
		return image;
	}



	public void setImage(String image) {
		this.image = image;
	}




	
}
