package com.springmvc.controller;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.stream.Collectors;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.hibernate.query.Query; 

import com.springmvc.model.Cart;
import com.springmvc.model.CartItem;
import com.springmvc.model.Customer;
import com.springmvc.model.FoodITemManager;
import com.springmvc.model.HibernateConnection;
import com.springmvc.model.MenuFood;
import com.springmvc.model.Order;
import com.springmvc.model.OrderManager; 
import com.springmvc.model.OrderDetail;
import com.springmvc.model.Reserve;
import com.springmvc.model.ReserveManager;
import com.springmvc.model.Tables;
import com.springmvc.model.TableManager; 
import com.springmvc.model.FoodType;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderCustomerController {
    
    private FoodITemManager foodManager = new FoodITemManager();
    private ReserveManager reserveManager = new ReserveManager();
    private TableManager tableManager = new TableManager(); 
    private OrderManager orderManager = new OrderManager(); 

    /**
     * Helper Method: ดึง/สร้าง Cart Object จาก Session
     */
    private Cart getCartFromSession(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cartObject");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cartObject", cart);
        }
        return cart;
    }

    /**
     * Helper Method: อัปเดตจำนวนสินค้าทั้งหมดในตะกร้า (totalCartItems) ใน Session
     */
    private void updateCartTotalItems(HttpSession session, Cart cart) {
        int totalItems = cart.getItems().values().stream()
                             .mapToInt(CartItem::getQuantity)
                             .sum();
        session.setAttribute("totalCartItems", totalItems);
    }
    
    // 1. เพิ่มสินค้าลงตะกร้า (ใช้ Session Cart)
    @RequestMapping(value = "/addToCart", method = RequestMethod.POST)
    public ModelAndView addToCart(@RequestParam("foodId") int foodId, 
                                @RequestParam("quantity") int quantity,
                                HttpSession session) {
        
        // เราจะสมมติว่า JSP ส่ง quantity มาเป็น 1 ในการกดปุ่ม "+"
        if (quantity <= 0) quantity = 1; 
        
        // *** ตรวจสอบบริบทการสั่งอาหาร (Table/Order) แทน Customer Login ***
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
            return new ModelAndView("redirect:/viewmenu", "error", "⚠️ กรุณาสแกน QR Code โต๊ะเพื่อเริ่มสั่งอาหาร");
        }
        // *************************************************************

        MenuFood food = foodManager.getFoodById(foodId);
        if (food == null) {
            return new ModelAndView("redirect:/viewmenu", "error", "ไม่พบรายการอาหาร");
        }

        Cart cart = getCartFromSession(session);
        
        // VVVV สร้าง CartItem โดยใช้ Constructor ที่แก้ไขให้รับ priceAtTime VVVV
        CartItem newItem = new CartItem(food, quantity, food.getPrice()); 
        cart.addItem(newItem);
        
        // อัปเดต Session เพื่อให้ UI แสดงผลจำนวนรายการใหม่
        updateCartTotalItems(session, cart);
        
        session.setAttribute("orderSuccess", "เพิ่ม " + food.getFoodname() + " ลงในตะกร้าแล้ว!");
        return new ModelAndView("redirect:/viewmenu");
    }
    
    // 2. อัปเดตจำนวนสินค้า (เพิ่ม/ลด/ลบ)
    @RequestMapping(value = "/updateQuantity", method = RequestMethod.POST)
    public ModelAndView updateQuantity(HttpSession session, 
                                       @RequestParam("foodId") int foodId, 
                                       @RequestParam("action") String action) {
        // *** ตรวจสอบบริบทการสั่งอาหาร (Table/Order) ***
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
            return new ModelAndView("redirect:/viewmenu", "error", "⚠️ กรุณาสแกน QR Code โต๊ะเพื่อเริ่มสั่งอาหาร");
        }
        // *********************************************
        
        Cart cart = getCartFromSession(session);
        Map<Integer, CartItem> items = cart.getItems();
        
        CartItem item = items.get(foodId);
        if (item == null) {
            return new ModelAndView("redirect:/viewCart", "error", "ไม่พบรายการอาหารในตะกร้า"); 
        }

        int currentQty = item.getQuantity();

        if ("increase".equals(action)) {
            item.setQuantity(currentQty + 1);
        } else if ("decrease".equals(action)) {
            currentQty--;
            if (currentQty <= 0) {
                items.remove(foodId); // ลบรายการออก
            } else {
                item.setQuantity(currentQty);
            }
        }
        
        // อัปเดต Session เพื่อให้ UI แสดงผลจำนวนรายการใหม่
        updateCartTotalItems(session, cart);

        return new ModelAndView("redirect:/viewCart");
    }
    
    // 3. ดูตะกร้าสินค้า (ส่ง List<CartItem> ไป JSP)
    @RequestMapping(value = "/viewCart", method = RequestMethod.GET)
    public ModelAndView viewCart(HttpSession session) {
        ModelAndView mav = new ModelAndView("cart"); // viewCart.jsp
        
        // *** ตรวจสอบบริบทการสั่งอาหาร (Table/Order) ***
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
             return new ModelAndView("redirect:/viewmenu", "error", "⚠️ กรุณาสแกน QR Code โต๊ะเพื่อเริ่มสั่งอาหาร");
        }
        // *********************************************
        
        Cart cart = getCartFromSession(session);
        
        // ส่ง List<CartItem> ไปยัง JSP
        List<CartItem> cartItemsList = new ArrayList<>(cart.getItems().values());
        double total = cart.getTotalPrice(); 
        
        updateCartTotalItems(session, cart);
        
        mav.addObject("cartItemsList", cartItemsList);
        mav.addObject("total", total);
        
        return mav;
    }
    
    // 4. เมธอดสำหรับดูรายละเอียดรายการสั่งอาหารที่อยู่ในบิลปัจจุบัน
    @RequestMapping(value = "/viewCurrentOrder", method = RequestMethod.GET)
    public ModelAndView viewCurrentOrder(HttpSession session) {
        // *** ตรวจสอบบริบทการสั่งอาหาร (Table/Order) ***
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
            return new ModelAndView("viewCurrentOrder", "error", "⚠️ ไม่พบโต๊ะที่ใช้งานอยู่ในขณะนี้ กรุณาสแกน QR Code");
        }
        // *********************************************

        // 1. ค้นหา Order ปัจจุบันจาก Order ID ใน Session
        Order currentOrder = null;
        try (Session hibernateSession = HibernateConnection.doHibernateConnection().openSession()) {
            currentOrder = hibernateSession.get(Order.class, sessionOrderId);
            
            // ตรวจสอบความถูกต้องของ Order ที่ดึงมา
            if (currentOrder == null || !currentOrder.getTable().getTableid().equals(sessionTableId)) {
                return new ModelAndView("viewCurrentOrder", "error", "ไม่พบบิลที่เชื่อมโยงกับโต๊ะนี้");
            }

        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("viewCurrentOrder", "error", "เกิดข้อผิดพลาดในการค้นหาบิล");
        }
        
        // 2. ดึงรายการ OrderDetail ทั้งหมดของ Order นี้ โดยใช้ ReserveManager
        List<OrderDetail> orderDetails = reserveManager.getOrderDetailsByOrderId(currentOrder.getOderId());

        // VVVV Logic จัดเรียง VVVV
        if (orderDetails != null) {
            List<OrderDetail> buffetItems = orderDetails.stream()
                .filter(d -> d.getMenufood().getFoodname().toLowerCase().contains("บุฟเฟต์"))
                .collect(java.util.stream.Collectors.toList());
            
            List<OrderDetail> otherItems = orderDetails.stream()
                .filter(d -> !d.getMenufood().getFoodname().toLowerCase().contains("บุฟเฟต์"))
                .collect(java.util.stream.Collectors.toList());
                
            orderDetails = new ArrayList<>();
            orderDetails.addAll(buffetItems);
            orderDetails.addAll(otherItems);
        }
        // ^^^^ สิ้นสุด Logic จัดเรียง ^^^^


        ModelAndView mav = new ModelAndView("viewCurrentOrder"); 
        mav.addObject("currentOrder", currentOrder);
        mav.addObject("orderDetails", orderDetails);
        mav.addObject("tableId", sessionTableId);
        
        return mav;
    }


    // 5. ยืนยันคำสั่งซื้อ (Core Logic)
    @RequestMapping(value = "/confirmOrder", method = RequestMethod.POST)
    public ModelAndView confirmOrder(HttpSession session) {
        
        // *** ตรวจสอบบริบทการสั่งอาหาร (Table/Order) ***
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
            ModelAndView errorMav = viewCart(session);
            errorMav.addObject("error", "ไม่พบบิลที่ใช้งานอยู่ กรุณาสแกน QR Code โต๊ะอีกครั้ง");
            return errorMav; 
        }
        // *********************************************

        Cart cart = getCartFromSession(session);
        Map<Integer, CartItem> cartItems = cart.getItems();
        
        if (cartItems.isEmpty()) {
            return new ModelAndView("redirect:/viewCart", "error", "ไม่มีรายการในตะกร้า");
        }

        Order openOrder = null;
        Session hibernateSession = null;
        Transaction tx = null;
        
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            hibernateSession = sessionFactory.openSession();
            tx = hibernateSession.beginTransaction();
            
            // 1. ดึง Open Order โดยใช้ Order ID จาก Session
            openOrder = hibernateSession.get(Order.class, sessionOrderId);
            
            if (openOrder == null || !openOrder.getStatus().equals("Open")) {
                tx.rollback();
                ModelAndView errorMav = viewCart(session);
                errorMav.addObject("error", "ไม่พบบิล (Order) ที่เปิดไว้สำหรับโต๊ะที่สแกน - **กรุณาติดต่อพนักงานเสิร์ฟเพื่อเปิดบิลก่อน**");
                return errorMav;
            }
            
            // 2. ตรวจสอบ CartItem ในตะกร้า
            Map<Integer, CartItem> items = cart.getItems();
            double totalOrderPriceIncrease = 0.0;
            
            // 3. บันทึก CartItem แต่ละรายการเป็น OrderDetail
            for (CartItem item : items.values()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrders(openOrder);
                detail.setMenufood(item.getMenufood()); 
                detail.setQuantity(item.getQuantity()); 
                detail.setPriceAtTimeOfOrder(item.getPriceAtTime()); 
                detail.setStatus("Pending"); 
                
                hibernateSession.save(detail);
                
                totalOrderPriceIncrease += item.getTotalPrice();
            }
            
            // 4. อัปเดต Total Price ใน Order หลัก
            openOrder.setTotalPeice(openOrder.getTotalPeice() + totalOrderPriceIncrease);
            hibernateSession.update(openOrder);
            
            tx.commit();
            
            // 5. ล้างตะกร้าใน Session และอัปเดต totalItems
            session.removeAttribute("cartObject");
            session.removeAttribute("totalCartItems");
            
            session.setAttribute("orderSuccess", "สั่งอาหารเรียบร้อยแล้ว! รายการถูกเพิ่มในบิล Order ID: " + openOrder.getOderId());
            return new ModelAndView("redirect:/viewmenu");
            
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            
            ModelAndView mav = viewCart(session); 
            mav.addObject("error", "เกิดข้อผิดพลาดในการยืนยันคำสั่งซื้อ: " + e.getMessage());
            return mav;
        } finally {
            if (hibernateSession != null) hibernateSession.close();
        }
    }
    
    // *** NEW/MODIFIED VIEW METHOD ***
    @RequestMapping(value = "/viewmenu", method = RequestMethod.GET)
    public ModelAndView viewmenu(HttpSession session, 
                                 @RequestParam(value = "qrToken", required = false) String qrToken) {
        
        // 1. ตรวจสอบบริบทการสั่งอาหารใน Session ก่อน
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");

        // 2. ถ้ามี qrToken มาด้วย (การสแกนครั้งแรก) ให้ดำเนินการตรวจสอบสถานะ
        if (qrToken != null && !qrToken.isEmpty()) { 
            Tables table = tableManager.getTableByQrToken(qrToken);
            
            // 2.1. ไม่พบโต๊ะจาก QR Token
            if (table == null) {
                ModelAndView mav = new ModelAndView("Homecustomer");
                mav.addObject("error", "⚠️ QR Code ไม่ถูกต้อง ไม่พบโต๊ะในระบบ");
                return mav;
            }
            
            // 2.2. ตรวจสอบสถานะโต๊ะ ต้องถูก "Occupied" (หรือ "In Use")
            // ใช้ "Occupied" ตามข้อมูลฐานข้อมูลของคุณและรวม "In Use"
            if (!"Occupied".equals(table.getStatus()) && !"In Use".equals(table.getStatus())) { 
                ModelAndView mav = new ModelAndView("Homecustomer");
                mav.addObject("error", "🚫 โต๊ะ " + table.getTableid() + " ยังไม่เปิดให้บริการ กรุณาติดต่อพนักงาน");
                session.removeAttribute("tableId");
                session.removeAttribute("orderId");
                return mav;
            }
            
            // 2.3. โต๊ะเปิดแล้ว: ค้นหา Active Order ที่กำลังทำงานอยู่
            Order activeOrder = orderManager.getActiveOrderByTableId(table.getTableid());
            
            if (activeOrder == null) {
                // โต๊ะเป็น "Occupied" แต่ไม่พบบิลที่ Active -> บล็อก
                ModelAndView mav = new ModelAndView("Homecustomer");
                mav.addObject("error", "🚫 โต๊ะ " + table.getTableid() + " เปิดใช้งานแล้ว แต่ไม่พบบิล กรุณาติดต่อพนักงานเพื่อเปิดบิล");
                session.removeAttribute("tableId");
                session.removeAttribute("orderId");
                return mav;
            }
            
            // 2.4. ตรวจสอบผ่าน: บันทึก context ลงใน Session
            session.setAttribute("tableId", table.getTableid());
            session.setAttribute("orderId", activeOrder.getOderId());
            
            // 2.5. Redirect เพื่อตัด qrToken ออกจาก URL และใช้ Session Context ในการทำงานต่อ
            return new ModelAndView("redirect:/viewmenu");
        } 
        
        // 3. ถ้ามาถึงตรงนี้ ต้องตรวจสอบ Session Context
        if (sessionTableId == null || sessionOrderId == null) {
            // หากไม่มี context ใน session และไม่มี qrToken (เข้าตรงๆ)
            ModelAndView mav = new ModelAndView("Homecustomer");
            mav.addObject("error", "⚠️ กรุณาสแกน QR Code ที่โต๊ะเพื่อเริ่มสั่งอาหาร");
            return mav;
        }

        // 4. ถ้ามี context ใน Session ดำเนินการแสดงเมนู (ส่งข้อมูลทั้งหมดที่ JSP ต้องการ)
        List<MenuFood> menuList = foodManager.getAllFoodItem();
        List<FoodType> foodTypeList = foodManager.getAllFoodTypes(); 

        // จัดการ Cart (Logic เดิม)
        Cart cart = getCartFromSession(session);
        updateCartTotalItems(session, cart);

        // ส่งข้อมูล TableId, OrderId, Menu List, Food Type List ไปยัง JSP
        ModelAndView mav = new ModelAndView("orderfoodCuatomer"); 
        mav.addObject("menuList", menuList);
        mav.addObject("foodTypeList", foodTypeList); 
        mav.addObject("tableId", sessionTableId); 
        mav.addObject("orderId", sessionOrderId); 

        return mav;
    }
}