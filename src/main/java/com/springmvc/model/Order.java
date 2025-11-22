package com.springmvc.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "orders")
public class Order {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int oderId;
	
	@Column(nullable = false)
	@Temporal(TemporalType.DATE)
    private Date orderDate;
	
	@Column(nullable = false, length = 255)
	private double totalPeice;
	
	@Column(nullable = false, length = 255)
	private String status;
	
	

	@ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "tableid", nullable = false)
	private Tables table;
 
	
	public Order() {
		super();

	}


	public Order(int oderId, Date orderDate, double totalPeice, String status, Tables table) {
		super();
		this.oderId = oderId;
		this.orderDate = orderDate;
		this.totalPeice = totalPeice;
		this.status = status;
		this.table = table;
	}


	public int getOderId() {
		return oderId;
	}


	public void setOderId(int oderId) {
		this.oderId = oderId;
	}


	public Date getOrderDate() {
		return orderDate;
	}


	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}


	public double getTotalPeice() {
		return totalPeice;
	}


	public void setTotalPeice(double totalPeice) {
		this.totalPeice = totalPeice;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public Tables getTable() {
		return table;
	}


	public void setTable(Tables table) {
		this.table = table;
	}

	
	

 
	
}