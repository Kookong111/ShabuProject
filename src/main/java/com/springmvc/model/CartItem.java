package com.springmvc.model;
import com.springmvc.model.MenuFood;

//Class นี้ใช้แทน "รายการอาหาร 1 อย่างในตะกร้า"
public class CartItem {
	
	private MenuFood menufood; // อาหาร (แก้ไขชื่อเป็นตัวเล็กตามที่ตกลง)
	private int quantity; // จำนวน
    
    // VVVV NEW: เพิ่ม Field ราคาต่อหน่วย (เพื่อให้ JSP เข้าถึงได้) VVVV
    private double priceAtTime; 
    
    // Note: ควรมีการปรับปรุงชื่อ Field/Getter/Setter ให้เป็น menufood (ตัวเล็ก)
	
    // Constructor ใหม่ที่รับ priceAtTime มาด้วย
	public CartItem(MenuFood menufood, int quantity, double priceAtTime) {
		this.menufood = menufood;
		this.quantity = quantity;
        this.priceAtTime = priceAtTime; 
	}
	
	// เมธอดสำหรับคำนวณราคารวมของแถวนี้
	public double getTotalPrice() {
		return priceAtTime * quantity; // ใช้ priceAtTime ที่เก็บไว้
	}

	// --- Getters and Setters ---
	public MenuFood getMenufood() { 
		return menufood; 
	}
	public void setMenufood(MenuFood menufood) { 
		this.menufood = menufood; 
	}
	public int getQuantity() { 
		return quantity; 
	}
	public void setQuantity(int quantity) { 
		this.quantity = quantity; 
	}
    
    // VVVV NEW: Getter สำหรับ priceAtTime VVVV
    public double getPriceAtTime() { 
        return priceAtTime; 
    }
    public void setPriceAtTime(double priceAtTime) {
        this.priceAtTime = priceAtTime;
    }
}