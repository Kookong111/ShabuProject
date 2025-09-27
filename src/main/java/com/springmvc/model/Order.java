package com.springmvc.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "orders")
public class Order {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private String oderId;
	
	@Column(nullable = false, length = 255)
	private String orderName;
	
	@Column(nullable = false, length = 255)
	private String status;
	
	

	@ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "tableid", nullable = false)
	private Tables table;
 
	
	public Order() {
		super();

	}

	

 
	
}