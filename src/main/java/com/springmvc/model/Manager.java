package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;

import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "managers")
public class Manager {

	@Id
    @Column(nullable = false, unique = true,length = 255)
	private String username;
	
	@Column(nullable = false, length = 255)
	private String password;

	public Manager() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Manager(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	
}
