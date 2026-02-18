package com.springmvc.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;

import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name = "menufood")
public class MenuFood {

	@Id
    private int foodId;
	
	@Column(nullable = false, length = 255)
	private String foodname;
	
	@Column(nullable = false, length = 255)
	private double price;
	
	@Column(nullable = false, length = 255)
	private String foodImage;
	
	@ManyToOne(cascade = CascadeType.PERSIST)
	@JoinColumn(name = "foodtypeId", nullable = false)
	private FoodType foodtype;

	@Column(nullable = false, length = 50)
	private String status; // สถานะอาหาร เช่น "พร้อมเสิร์ฟ", "หมด"
	
	public MenuFood() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MenuFood(int foodId, String foodname, double price, String foodImage, FoodType foodtype) {
		super();
		this.foodId = foodId;
		this.foodname = foodname;
		this.price = price;
		this.foodImage = foodImage;
		this.foodtype = foodtype;
		this.status = "พร้อมเสิร์ฟ"; // default
	}

	public MenuFood(int foodId, String foodname, double price, String foodImage, FoodType foodtype, String status) {
		super();
		this.foodId = foodId;
		this.foodname = foodname;
		this.price = price;
		this.foodImage = foodImage;
		this.foodtype = foodtype;
		this.status = status;
	}

	public int getFoodId() {
		return foodId;
	}

	public void setFoodId(int foodId) {
		this.foodId = foodId;
	}

	public String getFoodname() {
		return foodname;
	}

	public void setFoodname(String foodname) {
		this.foodname = foodname;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getFoodImage() {
		return foodImage;
	}

	public void setFoodImage(String foodImage) {
		this.foodImage = foodImage;
	}

	public FoodType getFoodtype() {
		return foodtype;
	}

	public void setFoodtype(FoodType foodtype) {
		this.foodtype = foodtype;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	
	
}
