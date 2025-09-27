package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
 

@Entity
@Table(name = "Customers")
public class Customer {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int cusId;
	
	@Column(nullable = false, length = 255)
	private String cususername;
	
	@Column(nullable = false, length = 255)
	private String cuspassword;
	
	@Column(nullable = false, length = 255)
	private String cusname;
	
	@Column(nullable = false, length = 11)
	private String phonenumber;
	
	@Column(nullable = false, length = 5)
	private String age;
	
	@Column(nullable = false, length = 300)
	private String gmail;

	public Customer() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Customer(int cusId, String cususername, String cuspassword, String cusname, String phonenumber, String age,
			String gmail) {
		super();
		this.cusId = cusId;
		this.cususername = cususername;
		this.cuspassword = cuspassword;
		this.cusname = cusname;
		this.phonenumber = phonenumber;
		this.age = age;
		this.gmail = gmail;
	}

	public int getCusId() {
		return cusId;
	}

	public void setCusId(int cusId) {
		this.cusId = cusId;
	}

	public String getCususername() {
		return cususername;
	}

	public void setCususername(String cususername) {
		this.cususername = cususername;
	}

	public String getCuspassword() {
		return cuspassword;
	}

	public void setCuspassword(String cuspassword) {
		this.cuspassword = cuspassword;
	}

	public String getCusname() {
		return cusname;
	}

	public void setCusname(String cusname) {
		this.cusname = cusname;
	}

	public String getPhonenumber() {
		return phonenumber;
	}

	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getGmail() {
		return gmail;
	}

	public void setGmail(String gmail) {
		this.gmail = gmail;
	}

	
	

	
}
