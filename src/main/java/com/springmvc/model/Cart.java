package com.springmvc.model;
import java.util.Map;
import java.util.HashMap;

// Class นี้ใช้แทน "ตะกร้าสินค้า" (ที่เก็บ CartItem หลายๆ อัน)
public class Cart {

	// เราใช้ Map<Integer, CartItem> โดย Key คือ foodId
	private Map<Integer, CartItem> items = new HashMap<>();
	
	/**
	 * เมธอดสำหรับเพิ่มสินค้าลงตะกร้า
	 */
	public void addItem(CartItem item) {
		// VVVV แก้ไข: ใช้ getMenufood() แทน getMenuFood() VVVV
		int foodId = item.getMenufood().getFoodId(); 
		
		if (items.containsKey(foodId)) {
			// ถ้ามีสินค้านี้อยู่แล้ว -> ให้บวกจำนวนเพิ่ม
			CartItem existingItem = items.get(foodId);
			existingItem.setQuantity(existingItem.getQuantity() + item.getQuantity());
		} else {
			// ถ้าเป็นสินค้าใหม่ -> เพิ่มเข้าไปใน Map
			items.put(foodId, item);
		}
	}
	
	// เมธอดสำหรับดึงรายการสินค้าทั้งหมด
	public Map<Integer, CartItem> getItems() {
		return items;
	}
	
	// เมธอดสำหรับคำนวณราคารวมทั้งตะกร้า
	public double getTotalPrice() {
		return items.values().stream()
					.mapToDouble(CartItem::getTotalPrice)
					.sum();
	}
	
	// เมธอดเช็คว่าตะกร้าว่างหรือไม่
	public boolean isEmpty() {
		return items.isEmpty();
	}
}