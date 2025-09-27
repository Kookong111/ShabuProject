package com.springmvc.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
 
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
 
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "Reserve")

public class Reserve {

	@Id
	@GeneratedValue
	private Integer reserveid;
	
    @Column(nullable = false)
	@Temporal(TemporalType.DATE)
    private Date reservedate;
    
    @Column(nullable = false , length = 50)
    private String reservetime;
	
	@Column(nullable = false, length = 50)
	private String status;
	
    @Column(nullable = false , length = 50)
    private Integer numberOfGuests;

	@ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "tableid", nullable = false)
	private Tables tables;
	
	@ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "cusId", nullable = false)
	private Customer customers;


	public Reserve() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Reserve(Integer reserveid, Date reservedate, String reservetime ,String status ,Integer numberOfGuests, Tables tables, Customer customers) {
		super();
		this.reserveid = reserveid;
		this.reservedate = reservedate;
		this.reservetime = reservetime;
		this.numberOfGuests = numberOfGuests;
		this.status = status;
		this.tables = tables;
		this.customers = customers;
	}

	public Integer getReserveid() {
		return reserveid;
	}

	public void setReserveid(Integer reserveid) {
		this.reserveid = reserveid;
	}

	public Date getReservedate() {
		return reservedate;
	}

	public void setReservedate(Date reservedate) {
		this.reservedate = reservedate;
	}
	
	public String getReservetime() {
		return reservetime;
	}

	public void setReservetime(String reservetime) {
		this.reservetime = reservetime;
	}

	public Integer getNumberOfGuests() {
		return numberOfGuests;
	}

	public void setNumberOfGuests(Integer numberOfGuests) {
		this.numberOfGuests = numberOfGuests;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Tables getTables() {
		return tables;
	}

	public void setTables(Tables tables) {
		this.tables = tables;
	}

	public Customer getCustomers() {
		return customers;
	}

	public void setCustomers(Customer customers) {
		this.customers = customers;
	}

	
	

}
