package com.springmvc.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "foodtype")
public class FoodType {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int foodtypeId;

	@Column(nullable = false, length = 255)
	private String foodtypeName;

	@Column(nullable = true, length = 255)
	private String description;

	public FoodType() {
		super();
	}

	public FoodType(int foodtypeId, String foodtypeName) {
		super();
		this.foodtypeId = foodtypeId;
		this.foodtypeName = foodtypeName;
		this.description = "";
	}

	

    public int getFoodtypeId() {
		return foodtypeId;
	}

	public void setFoodtypeId(int foodtypeId) {
		this.foodtypeId = foodtypeId;
	}

	public String getFoodtypeName() {
		return foodtypeName;
	}

	public void setFoodtypeName(String foodtypeName) {
		this.foodtypeName = foodtypeName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
    public String toString() {
        return this.foodtypeName;
    }
}

