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
@Table(name = "order_menu")
public class OrderDetail {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
    private String odermenuId;
	
	@Column(nullable = false, length = 255)
	private String orderNumber;
	
	@Column(nullable = false, length = 255)
	private String status;
	
	@Column(nullable = false, length = 45)
	private String quality;
	
	@ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "orderId", nullable = false)
	private Order orders;
	
	@ManyToOne(cascade = CascadeType.PERSIST)
    @JoinColumn(name = "foodId", nullable = false)
	private MenuFood menufood;

	public OrderDetail() {
		super();
		// TODO Auto-generated constructor stub
	}

	public OrderDetail(String odermenuId, String orderNumber, String status, String quality, Order orders,
			MenuFood menufood) {
		super();
		this.odermenuId = odermenuId;
		this.orderNumber = orderNumber;
		this.status = status;
		this.quality = quality;
		this.orders = orders;
		this.menufood = menufood;
	}

	public String getOdermenuId() {
		return odermenuId;
	}

	public void setOdermenuId(String odermenuId) {
		this.odermenuId = odermenuId;
	}

	public String getOrderNumber() {
		return orderNumber;
	}

	public void setOrderNumber(String orderNumber) {
		this.orderNumber = orderNumber;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getQuality() {
		return quality;
	}

	public void setQuality(String quality) {
		this.quality = quality;
	}

	public Order getOrders() {
		return orders;
	}

	public void setOrders(Order orders) {
		this.orders = orders;
	}

	public MenuFood getMenufood() {
		return menufood;
	}

	public void setMenufood(MenuFood menufood) {
		this.menufood = menufood;
	}

	
	
	
	
}
