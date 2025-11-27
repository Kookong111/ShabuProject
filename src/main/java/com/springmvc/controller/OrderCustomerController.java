package com.springmvc.controller;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;

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
import com.springmvc.model.OrderDetail;
import com.springmvc.model.Reserve;
import com.springmvc.model.ReserveManager;
import com.springmvc.model.Tables;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class OrderCustomerController {
    
    private FoodITemManager foodManager = new FoodITemManager();
    private ReserveManager reserveManager = new ReserveManager();

    /**
     * Helper Method: ดึง/สร้าง Cart Object จาก Session
     */
    private Cart getOrCreateCart(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cartObject");
        if (cart == null) {
            cart = new Cart();
            session.setAttribute("cartObject", cart);
        }
        return cart;
    }
    
    /**
     * Helper Method: คำนวณจำนวนรายการทั้งหมดในตะกร้าจาก Cart Object
     */
    private int getCartTotalItems(Cart cart) {
        int total = 0;
        for (CartItem item : cart.getItems().values()) {
            total += item.getQuantity();
        }
        return total;
    }
    
    // 1. เพิ่มสินค้าลงตะกร้า (ใช้ Session Cart)
    @RequestMapping(value = "/addToCart", method = RequestMethod.POST)
    public ModelAndView addToCart(HttpSession session, @RequestParam("foodId") int foodId) {
        Customer user = (Customer) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/LoginCustomer", "error", "กรุณาเข้าสู่ระบบก่อนทำการสั่งอาหาร");
        }
        
        MenuFood food = foodManager.getFoodById(foodId);
        if (food == null) {
            return new ModelAndView("redirect:/viewmenu", "error", "ไม่พบรายการอาหาร");
        }

        Cart cart = getOrCreateCart(session);
        
        // VVVV สร้าง CartItem โดยใช้ Constructor ที่แก้ไขให้รับ priceAtTime VVVV
        CartItem newItem = new CartItem(food, 1, food.getPrice()); 
        cart.addItem(newItem);
        
        // อัปเดต Session เพื่อให้ UI แสดงผลจำนวนรายการใหม่
        session.setAttribute("totalCartItems", getCartTotalItems(cart));
        
        session.setAttribute("orderSuccess", "เพิ่ม " + food.getFoodname() + " ลงในตะกร้าแล้ว!");
        return new ModelAndView("redirect:/viewmenu");
    }

    // 2. อัปเดตจำนวนสินค้า (เพิ่ม/ลด/ลบ)
    @RequestMapping(value = "/updateQuantity", method = RequestMethod.POST)
    public ModelAndView updateQuantity(HttpSession session, 
                                       @RequestParam("foodId") int foodId, 
                                       @RequestParam("action") String action) {
        Customer user = (Customer) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("redirect:/LoginCustomer", "error", "กรุณาเข้าสู่ระบบก่อนดำเนินการ");
        }
        
        Cart cart = getOrCreateCart(session);
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
        session.setAttribute("totalCartItems", getCartTotalItems(cart));

        return new ModelAndView("redirect:/viewCart");
    }
    
    // 3. ดูตะกร้าสินค้า (ส่ง List<CartItem> ไป JSP)
    @RequestMapping(value = "/viewCart", method = RequestMethod.GET)
    public ModelAndView viewCart(HttpSession session) {
        ModelAndView mav = new ModelAndView("cart");
        Customer user = (Customer) session.getAttribute("user");
        
        if (user == null) {
             return new ModelAndView("loginCustomer", "error", "กรุณาเข้าสู่ระบบก่อนเข้าสู่หน้าตะกร้า");
        }
        
        Cart cart = getOrCreateCart(session);
        
        // ส่ง List<CartItem> ไปยัง JSP
        List<CartItem> cartItemsList = new ArrayList<>(cart.getItems().values());
        double total = cart.getTotalPrice(); 
        
        session.setAttribute("totalCartItems", getCartTotalItems(cart));
        
        mav.addObject("cartItemsList", cartItemsList);
        mav.addObject("total", total);
        
        return mav;
    }

    // 4. เมธอดสำหรับดูรายละเอียดรายการสั่งอาหารที่อยู่ในบิลปัจจุบัน
    @RequestMapping(value = "/viewCurrentOrder", method = RequestMethod.GET)
    public ModelAndView viewCurrentOrder(HttpSession session) {
        Customer user = (Customer) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("loginCustomer", "error", "กรุณาเข้าสู่ระบบก่อนดูรายการสั่งอาหาร");
        }

        ReserveManager reserveManager = new ReserveManager();
        
        // 1. ค้นหา Active Reservation
        Reserve activeReservation = reserveManager.getReservationByActiveStatus(user.getCusId()); 
        
        if (activeReservation == null || activeReservation.getTables() == null) {
            return new ModelAndView("viewCurrentOrder", "error", "ไม่พบการจองหรือโต๊ะที่ใช้งานอยู่ในขณะนี้");
        }

        // 2. ค้นหา Order ที่ "Open" สำหรับโต๊ะนี้
        Order currentOrder = null;
        try (Session hibernateSession = HibernateConnection.doHibernateConnection().openSession()) {
            Query<Order> query = hibernateSession.createQuery(
                "FROM Order WHERE table.tableid = :tableId AND status = :status", Order.class);
            query.setParameter("tableId", activeReservation.getTables().getTableid());
            query.setParameter("status", "Open");
            currentOrder = query.uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
            return new ModelAndView("viewCurrentOrder", "error", "เกิดข้อผิดพลาดในการค้นหาบิล");
        }
        
        if (currentOrder == null) {
            return new ModelAndView("viewCurrentOrder", "error", "ไม่พบบิล (Order) ที่เปิดไว้สำหรับโต๊ะนี้");
        }
        
        // 3. ดึงรายการ OrderDetail ทั้งหมดของ Order นี้ โดยใช้ ReserveManager
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
        mav.addObject("tableId", activeReservation.getTables().getTableid());
        
        return mav;
    }


    // 5. ยืนยันคำสั่งซื้อ (Core Logic)
    @RequestMapping(value = "/confirmOrder", method = RequestMethod.POST)
    public ModelAndView confirmOrder(HttpSession session) {
        
        Customer user = (Customer) session.getAttribute("user");
        if (user == null) {
            return new ModelAndView("loginCustomer", "error", "กรุณาเข้าสู่ระบบก่อนยืนยันคำสั่งซื้อ");
        }

        Cart cart = getOrCreateCart(session);
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
            
            ReserveManager reserveManager = new ReserveManager();
            
            // 1. ค้นหา Active Reservation
            Reserve activeReservation = reserveManager.getReservationByActiveStatus(user.getCusId()); 

            if (activeReservation == null || activeReservation.getTables() == null) {
                 tx.rollback();
                 ModelAndView errorMav = viewCart(session);
                 errorMav.addObject("error", "ไม่พบการจองหรือโต๊ะที่ใช้งานอยู่, กรุณาจองโต๊ะหรือติดต่อพนักงาน");
                 return errorMav; 
            }

            // 2. ค้นหา Open Order
            Tables table = activeReservation.getTables();
            
            openOrder = (Order) hibernateSession.createQuery(
                    "FROM Order WHERE table.tableid = :tableId AND status = :status", Order.class)
                    .setParameter("tableId", table.getTableid())
                    .setParameter("status", "Open")
                    .uniqueResult();
            
            if (openOrder == null) {
                tx.rollback();
                ModelAndView errorMav = viewCart(session);
                errorMav.addObject("error", "ไม่พบบิล (Order) ที่เปิดไว้สำหรับโต๊ะที่จอง (" + table.getTableid() + ") - **กรุณาติดต่อพนักงานเสิร์ฟเพื่อเปิดบิลก่อน**");
                return errorMav;
            }
            
            // --- 3. ย้ายรายการจาก Cart Object ไป OrderDetail ---
            
            double totalOrderPriceIncrease = 0.0;
            
            for (CartItem item : cartItems.values()) {
                // *** สร้าง OrderDetail โดยใช้ข้อมูลจาก CartItem Object ***
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
}