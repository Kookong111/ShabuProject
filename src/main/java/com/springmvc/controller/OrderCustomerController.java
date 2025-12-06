package com.springmvc.controller;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.Date;
import java.util.stream.Collectors;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

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
@SuppressWarnings("unchecked")
public class OrderCustomerController {

    private final FoodITemManager foodManager = new FoodITemManager(); 
    private final OrderManager orderManager = new OrderManager();
    private final TableManager tableManager = new TableManager();
    private final ReserveManager reserveManager = new ReserveManager(); 

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
    
    // -----------------------------------------------------------
    // 0. GUARD LOGIC: ตรวจสอบสิทธิ์การเข้าถึงเมนูสั่งอาหาร
    // -----------------------------------------------------------
    @RequestMapping(value = "/checkAccessAndRedirectToMenu", method = RequestMethod.GET)
    public ModelAndView checkAccessAndRedirectToMenu(
            HttpSession session, 
            @RequestParam(value = "qrToken", required = false) String qrToken) {
        
        Customer user = (Customer) session.getAttribute("user");
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        // 1. ตรวจสอบการล็อกอิน
        if (user == null) {
            ModelAndView mav = new ModelAndView("loginCustomer");
            mav.addObject("error", "⚠️ กรุณาเข้าสู่ระบบก่อนจึงจะสามารถสั่งอาหารได้");
            return mav;
        }

        // --- NEW LOGIC FOR SESSION VALIDATION ---
        if (sessionOrderId != null) {
            Order currentOrder = orderManager.getOrderById(sessionOrderId); // ดึง Order ปัจจุบัน

            // 1. ถ้ามี Order ใน Session แต่ Order นั้นถูกปิดไปแล้ว (ไม่เป็น 'Open') -> ล้าง Session
            if (currentOrder == null || !currentOrder.getStatus().equals("Open")) {
                 sessionOrderId = null; // ถือว่า Order นี้ใช้ไม่ได้แล้ว
                 sessionTableId = null;
                 session.removeAttribute("tableId");
                 session.removeAttribute("orderId");
            } 
            
            // 2. ถ้า Order ID ยังอยู่: ตรวจสอบความเป็นเจ้าของผ่าน Reservation (ถ้ามี)
            if (sessionOrderId != null) {
                Reserve activeReservation = reserveManager.getReservationByActiveStatus(user.getCusId());
                
                // ถ้าลูกค้ามี Reservation Active แต่ Order ใน Session ไม่ใช่ Order ของโต๊ะที่จองไว้
                if (activeReservation != null && currentOrder != null && !activeReservation.getTables().getTableid().equals(currentOrder.getTable().getTableid())) {
                    // นี่คือ Order ของคนอื่นที่หลงเหลือใน Session
                    sessionOrderId = null; 
                    sessionTableId = null;
                    session.removeAttribute("tableId");
                    session.removeAttribute("orderId");
                } else {
                     // ผ่านการตรวจสอบ Order ยัง Open หรือเป็น Walk-in ที่ไม่มี Reservation
                     return new ModelAndView("redirect:/viewmenu");
                }
            }
        }
        // --- END NEW LOGIC ---
        

        // 2. ตรวจสอบบริบทการสั่งอาหาร (ถ้าไม่มี QR Token มาด้วย)
        // ถ้าล็อกอินแล้ว แต่ไม่มี context
        if (qrToken == null && (sessionTableId == null || sessionOrderId == null)) {
            // ให้ลูกค้าไปหน้า error
            ModelAndView mav = new ModelAndView("orderErrorPage"); 
            mav.addObject("errorMessage", "🚫 คุณยังไม่มีบิลสั่งอาหารที่เปิดใช้งานอยู่ กรุณาจองโต๊ะหรือสแกน QR Code ที่โต๊ะคุณนั่ง");
            return mav;
        }
        
        // 3. ผ่านการตรวจสอบเบื้องต้น หรือมี QR Token มาด้วย
        return new ModelAndView("redirect:/viewmenu");
    }

    // -----------------------------------------------------------
    // 1. VIEW MENU (Entry Point for QR Scan)
    // -----------------------------------------------------------
    @RequestMapping(value = "/viewmenu", method = RequestMethod.GET)
    public ModelAndView viewmenu(HttpSession session, 
                                 @RequestParam(value = "qrToken", required = false) String qrToken) {
        
        // 1. ดึงบริบทปัจจุบันและข้อมูลผู้ใช้ที่ล็อกอิน
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        Customer user = (Customer) session.getAttribute("user"); 

        Tables activeTable = null;
        Order activeOrder = null;
        String errorMsg = null;
        boolean contextUpdated = false;

        // A. 🎯 ตรวจสอบจาก QR Code (Walk-in/Primary Entry Point)
        if (qrToken != null && !qrToken.isEmpty()) { 
            activeTable = tableManager.getTableByQrToken(qrToken);
            
            if (activeTable != null && ("Occupied".equals(activeTable.getStatus()) || "In Use".equals(activeTable.getStatus()))) {
                activeOrder = orderManager.getActiveOrderByTableId(activeTable.getTableid());
            }

            if (activeTable == null) {
                errorMsg = "ไม่พบข้อมูลโต๊ะที่เกี่ยวข้อง, กรุณาตรวจสอบ QR Code อีกครั้ง";
            } else if (activeOrder == null) {
                errorMsg = "โต๊ะ " + activeTable.getTableid() + " เปิดใช้งานแล้ว แต่ไม่พบบิลสั่งอาหาร, กรุณาติดต่อพนักงานเพื่อเปิดบิล";
            } else {
                // *** NEW LOGIC 1: Verify Order Ownership via Reservation ***
                Reserve reservationForCustomer = reserveManager.getReservationByActiveStatus(user.getCusId()); 
                
                // ถ้ามี Reservation Active และ Order นี้ไม่ใช่ Order ของโต๊ะที่ถูกจอง
                if (reservationForCustomer != null && !reservationForCustomer.getTables().getTableid().equals(activeOrder.getTable().getTableid())) {
                    errorMsg = "🚫 บัญชีของคุณมีการจองโต๊ะ " + reservationForCustomer.getTables().getTableid() + " ที่ยัง Active อยู่, คุณไม่สามารถสแกน Order ของโต๊ะอื่นได้";
                } else {
                     contextUpdated = true;
                }
                // *** END NEW LOGIC 1 ***
            }
            
        // B. 🎯 ตรวจสอบจาก Active Reservation (ถ้าลูกค้าล็อกอินและไม่มี Session/QR Code)
        } else if (sessionTableId == null && sessionOrderId == null && user != null) {
            Reserve activeReservation = reserveManager.getReservationByActiveStatus(user.getCusId());
            
            if (activeReservation != null && ("Occupied".equals(activeReservation.getTables().getStatus()) || "In Use".equals(activeReservation.getTables().getStatus()))) {
                activeTable = activeReservation.getTables();
                activeOrder = orderManager.getActiveOrderByTableId(activeTable.getTableid()); 
            
                if (activeOrder != null) {
                     contextUpdated = true;
                } else {
                     errorMsg = "การจองของคุณถูก Check-in แล้ว แต่ไม่พบบิลสั่งอาหาร กรุณาติดต่อพนักงาน";
                }

            } else if (user != null) {
                 errorMsg = "ไม่พบการจองที่ Active ของคุณ กรุณาจองโต๊ะก่อนสั่งอาหาร";
            }

        // C. 🎯 ตรวจสอบจาก Session Context (สั่งต่อ)
        } else if (sessionTableId != null && sessionOrderId != null) {
            
            // *** NEW LOGIC 2: Validate Existing Session Context ***
            Order sessionOrder = orderManager.getOrderById(sessionOrderId);
            
            // 1. ถ้า Order ถูกปิดแล้ว หรือไม่ตรงกับ Table ID ใน Session
            if (sessionOrder == null || !sessionOrder.getStatus().equals("Open") || !sessionOrder.getTable().getTableid().equals(sessionTableId)) {
                errorMsg = "บิล (Order ID: " + sessionOrderId + ") ถูกปิดแล้ว หรือไม่ถูกต้อง กรุณาสแกน QR ใหม่";
                session.removeAttribute("tableId");
                session.removeAttribute("orderId");
            } else {
                // 2. ถ้า Order ยัง Open, ตรวจสอบว่าเป็น Order ของลูกค้าคนนี้หรือไม่
                Reserve activeReservation = reserveManager.getReservationByActiveStatus(user.getCusId());
                
                if (activeReservation != null) {
                    // Order ที่ Active ใน Session ไม่ใช่ Order ของ Reservation ที่ Active ของลูกค้าคนนี้
                    if (!activeReservation.getTables().getTableid().equals(sessionTableId)) {
                         errorMsg = "🚫 Order ID: " + sessionOrderId + " ไม่ตรงกับการจอง Active ของคุณ (" + activeReservation.getTables().getTableid() + ")";
                         session.removeAttribute("tableId");
                         session.removeAttribute("orderId");
                    }
                }
            }
            // *** END NEW LOGIC 2 ***
            
        }


        // ----------------------------------------------------------------------
        // 3. สรุปผลและกำหนด Session Context
        // ----------------------------------------------------------------------
        if (errorMsg != null) {
            // หากเกิด Error จากการตรวจสอบ QR หรือ Reservation
            session.removeAttribute("tableId");
            session.removeAttribute("orderId");
            ModelAndView mav = new ModelAndView("orderErrorPage");
            mav.addObject("errorMessage", errorMsg);
            return mav;
            
        } else if (activeOrder != null && contextUpdated) {
             // หากตรวจสอบผ่านด้วย QR Code หรือ Reservation และมีการอัปเดตข้อมูล: บันทึก Context ใหม่
             session.setAttribute("tableId", activeOrder.getTable().getTableid());
             session.setAttribute("orderId", activeOrder.getOderId());
             
             // Redirect เพื่อล้าง qrToken หรือเพื่อโหลด UI ใหม่ (ถ้ามาจาก Reservation Check)
             if (qrToken != null || sessionTableId == null) {
                 return new ModelAndView("redirect:/viewmenu");
             }
        } 
        
        // ----------------------------------------------------------------------
        // 4. การแสดงผล (ใช้ Session Context ที่ผ่านการตรวจสอบแล้ว)
        // ----------------------------------------------------------------------
        // อัปเดตตัวแปร Session อีกครั้ง หลังการตรวจสอบ
        sessionTableId = (String) session.getAttribute("tableId");
        sessionOrderId = (Integer) session.getAttribute("orderId");

        if (sessionTableId == null || sessionOrderId == null) {
             // ถ้ายังไม่มี Context แสดงว่าเข้าถึงโดยตรง/Session หมดอายุ (ถูกบล็อกในเงื่อนไขด้านบน)
             ModelAndView mav = new ModelAndView("orderErrorPage");
             mav.addObject("errorMessage", "⚠️ คุณไม่ได้สแกน QR Code โต๊ะหรือบริบทการสั่งอาหารหมดอายุ, กรุณาจองโต๊ะหรือสแกน QR Code เพื่อเริ่มสั่งอาหาร");
             return mav;
        }

        // ดึงข้อมูลเมนู (Logic เดิม)
        List<MenuFood> menuList = foodManager.getAllFoodItem();
        List<FoodType> foodTypeList = foodManager.getAllFoodTypes(); 

        // จัดการ Cart (Logic เดิม)
        Cart cart = getCartFromSession(session);
        updateCartTotalItems(session, cart);

        // สร้าง ModelAndView และส่งข้อมูล
        ModelAndView mav = new ModelAndView("orderfoodCuatomer"); 
        mav.addObject("menuList", menuList);
        mav.addObject("foodTypeList", foodTypeList); 
        mav.addObject("tableId", sessionTableId); 
        mav.addObject("orderId", sessionOrderId); 

        return mav;
    }
    
    // -----------------------------------------------------------
    // 2. ADD TO CART
    // -----------------------------------------------------------
    @RequestMapping(value = "/addToCart", method = RequestMethod.POST)
    public ModelAndView addToCart(@RequestParam("foodId") int foodId, 
                                @RequestParam("quantity") int quantity,
                                HttpSession session) {
        
        if (quantity <= 0) quantity = 1; 
        
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
            return new ModelAndView("redirect:/viewmenu", "error", "⚠️ กรุณาสแกน QR Code โต๊ะเพื่อเริ่มสั่งอาหาร");
        }

        MenuFood food = foodManager.getFoodById(foodId);
        if (food == null) {
            return new ModelAndView("redirect:/viewmenu", "error", "ไม่พบรายการอาหาร");
        }

        Cart cart = getCartFromSession(session);
        
        CartItem newItem = new CartItem(food, quantity, food.getPrice()); 
        cart.addItem(newItem);
        
        updateCartTotalItems(session, cart);
        
        session.setAttribute("orderSuccess", "เพิ่ม " + food.getFoodname() + " ลงในตะกร้าแล้ว!");
        return new ModelAndView("redirect:/viewmenu");
    }

    // -----------------------------------------------------------
    // 3. UPDATE QUANTITY (Increase/Decrease)
    // -----------------------------------------------------------
    @RequestMapping(value = "/updateQuantity", method = RequestMethod.POST)
    public ModelAndView updateQuantity(HttpSession session, 
                                       @RequestParam("foodId") int foodId, 
                                       @RequestParam("action") String action) {
        
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
            return new ModelAndView("redirect:/viewmenu", "error", "⚠️ กรุณาสแกน QR Code โต๊ะเพื่อเริ่มสั่งอาหาร");
        }
        
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
                items.remove(foodId); 
            } else {
                item.setQuantity(currentQty);
            }
        }
        
        updateCartTotalItems(session, cart);

        return new ModelAndView("redirect:/viewCart");
    }
    
    // -----------------------------------------------------------
    // 4. REMOVE FROM CART
    // -----------------------------------------------------------
    @RequestMapping(value = "/removeFromCart", method = RequestMethod.POST)
    public ModelAndView removeFromCart(@RequestParam("foodId") int foodId, HttpSession session) {
        
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        // ควรตรวจสอบ Session Context ก่อนดำเนินการ
        if (sessionTableId == null || sessionOrderId == null) {
            return new ModelAndView("redirect:/viewmenu", "error", "⚠️ กรุณาสแกน QR Code โต๊ะเพื่อเริ่มสั่งอาหาร");
        }
        
        Cart cart = getCartFromSession(session);
        
        if (cart.getItems().containsKey(foodId)) {
            cart.getItems().remove(foodId); // ลบ CartItem ออกจาก Map
            
            // อัปเดตจำนวนสินค้าทั้งหมดใน Session
            updateCartTotalItems(session, cart); 
            
            session.setAttribute("orderSuccess", "✅ ลบรายการสินค้าออกจากตะกร้าแล้ว");
        } else {
             session.setAttribute("error", "ไม่พบรายการอาหารที่ต้องการลบในตะกร้า");
        }

        // Redirect กลับไปหน้าตะกร้า
        return new ModelAndView("redirect:/viewCart");
    }
    
    // -----------------------------------------------------------
    // 5. VIEW CART
    // -----------------------------------------------------------
    @RequestMapping(value = "/viewCart", method = RequestMethod.GET)
    public ModelAndView viewCart(HttpSession session) {
        // *** แก้ไขชื่อ View จาก "viewCart" เป็น "cart" ***
        ModelAndView mav = new ModelAndView("cart"); 
        
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
             return new ModelAndView("redirect:/viewmenu", "error", "⚠️ กรุณาสแกน QR Code โต๊ะเพื่อเริ่มสั่งอาหาร");
        }
        
        Cart cart = getCartFromSession(session);
        
        List<CartItem> cartItemsList = new ArrayList<>(cart.getItems().values());
        double total = cart.getTotalPrice(); 
        
        updateCartTotalItems(session, cart);
        
        mav.addObject("cartItemsList", cartItemsList);
        mav.addObject("total", total);
        
        return mav;
    }
    
    // -----------------------------------------------------------
    // 6. VIEW CURRENT ORDER
    // -----------------------------------------------------------
    @RequestMapping(value = "/viewCurrentOrder", method = RequestMethod.GET)
    public ModelAndView viewCurrentOrder(HttpSession session) {
        
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
            return new ModelAndView("viewCurrentOrder", "error", "⚠️ ไม่พบโต๊ะที่ใช้งานอยู่ในขณะนี้ กรุณาสแกน QR Code");
        }

        // 1. ค้นหา Order ปัจจุบันจาก Order ID ใน Session
        Order currentOrder = orderManager.getOrderById(sessionOrderId);
        
        if (currentOrder == null || !currentOrder.getTable().getTableid().equals(sessionTableId)) {
            return new ModelAndView("viewCurrentOrder", "error", "ไม่พบบิลที่เชื่อมโยงกับโต๊ะนี้");
        }

        // 2. ดึงรายการ OrderDetail ทั้งหมด
        List<OrderDetail> orderDetails = reserveManager.getOrderDetailsByOrderId(currentOrder.getOderId());

        // 3. Logic จัดเรียง (Buffet items first)
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

        ModelAndView mav = new ModelAndView("viewCurrentOrder"); 
        mav.addObject("currentOrder", currentOrder);
        mav.addObject("orderDetails", orderDetails);
        mav.addObject("tableId", sessionTableId);
        
        return mav;
    }

    // -----------------------------------------------------------
    // 7. CONFIRM ORDER (Save Cart to OrderDetails)
    // -----------------------------------------------------------
    @RequestMapping(value = "/confirmOrder", method = RequestMethod.POST)
    public ModelAndView confirmOrder(HttpSession session) {
        
        String sessionTableId = (String) session.getAttribute("tableId");
        Integer sessionOrderId = (Integer) session.getAttribute("orderId");
        
        if (sessionTableId == null || sessionOrderId == null) {
            ModelAndView errorMav = viewCart(session);
            errorMav.addObject("error", "ไม่พบบิลที่ใช้งานอยู่ กรุณาสแกน QR Code โต๊ะอีกครั้ง");
            return errorMav; 
        }

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
            
            // 2. บันทึก CartItem แต่ละรายการเป็น OrderDetail
            Map<Integer, CartItem> items = cart.getItems();
            double totalOrderPriceIncrease = 0.0;
            
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
            
            // 3. อัปเดต Total Price ใน Order หลัก
            openOrder.setTotalPeice(openOrder.getTotalPeice() + totalOrderPriceIncrease);
            hibernateSession.update(openOrder);
            
            tx.commit();
            
            // 4. ล้างตะกร้าใน Session และอัปเดต totalItems
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