package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;

import javax.persistence.Id;

import javax.persistence.Table;

@Entity
@Table(name = "tables")
public class Tables {

	@Id
	private String tableid;
	
	@Column(nullable = true,length = 50)
	private String status;
	
	@Column(nullable = false, length = 55)
	private String capacity;
	
    
	public Tables() {
		super();
	}



	public Tables(String tableid, String capacity, String status) {
		super();
		this.tableid = tableid;
		this.status = status;
		this.capacity = capacity;
	}



	public String getTableid() {
		return tableid;
	}



	public void setTableid(String tableid) {
		this.tableid = tableid;
	}



	public String getStatus() {
		return status;
	}



	public void setStatus(String status) {
		this.status = status;
	}



	public String getCapacity() {
		return capacity;
	}



	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}

	


	
	
	



    
	
}
