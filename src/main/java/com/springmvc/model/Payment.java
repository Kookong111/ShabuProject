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
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "payment")
public class Payment {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private int PaymentId;

	@Column(nullable = false, length = 255)
	private String paymentStatus;

	@Column(nullable = false)
	@Temporal(TemporalType.TIMESTAMP)
	private Date paymentDate;

	@Column(nullable = false, length = 255)
	private Double totalPrice;

	@ManyToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "empUsername", nullable = false)
	private Employee employees;

	@OneToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "oderId", nullable = false)
	private Order orders;

	public Payment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Payment(int paymentId, String paymentStatus, Date paymentDate, Double totalPrice, Employee employees,
			Order orders) {
		super();
		PaymentId = paymentId;
		this.paymentStatus = paymentStatus;
		this.paymentDate = paymentDate;
		this.totalPrice = totalPrice;
		this.employees = employees;
		this.orders = orders;
	}

	public int getPaymentId() {
		return PaymentId;
	}

	public void setPaymentId(int paymentId) {
		PaymentId = paymentId;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	public Double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(Double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Employee getEmployees() {
		return employees;
	}

	public void setEmployees(Employee employees) {
		this.employees = employees;
	}

	public Order getOrders() {
		return orders;
	}

	public void setOrders(Order orders) {
		this.orders = orders;
	}

}