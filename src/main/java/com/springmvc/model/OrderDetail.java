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
    private int odermenuId;
	
	
	
	@Column(nullable = false, length = 255)
	private String status;
	
	@Column(nullable = false)
	private int quantity;
	
	@Column(nullable = false)
	private double priceAtTimeOfOrder; 
	
	
	
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

	public OrderDetail(int odermenuId, String status, int quantity, double priceAtTimeOfOrder, Order orders,
			MenuFood menufood) {
		super();
		this.odermenuId = odermenuId;
		this.status = status;
		this.quantity = quantity;
		this.priceAtTimeOfOrder = priceAtTimeOfOrder;
		this.orders = orders;
		this.menufood = menufood;
	}

	public int getOdermenuId() {
		return odermenuId;
	}

	public void setOdermenuId(int odermenuId) {
		this.odermenuId = odermenuId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPriceAtTimeOfOrder() {
		return priceAtTimeOfOrder;
	}

	public void setPriceAtTimeOfOrder(double priceAtTimeOfOrder) {
		this.priceAtTimeOfOrder = priceAtTimeOfOrder;
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
