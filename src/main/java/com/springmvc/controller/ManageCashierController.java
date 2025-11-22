package com.springmvc.controller;

import java.util.ArrayList; 
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam; 
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.CashierManager;
import com.springmvc.model.Employee;
import com.springmvc.model.LoginManager;
import com.springmvc.model.Order;
import com.springmvc.model.OrderDetail; 
import com.springmvc.model.Payment;
import com.springmvc.model.Reserve;
import com.springmvc.model.Tables;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ManageCashierController {
    @RequestMapping(value = "/homecashier", method = RequestMethod.GET)//***********กลับหน้าhome***************
    public String homecer() {
        return "welcomeCashier"; 
    }
    
    @RequestMapping(value = "/backToListOrder", method = RequestMethod.GET)//***********กลับหน้าhome***************
    public String backToListOrder() {
        return "listTableForCashier"; // เปลี่ยนเป็น redirect เพื่อโหลดรายการใหม่
    }
    @RequestMapping(value = "/LoginCashier", method = RequestMethod.POST)
    public ModelAndView loginCashier(HttpServletRequest request,HttpSession session) {
    	CashierManager rm = new CashierManager();

        // ดึงข้อมูลจากฟอร์ม
        String username = request.getParameter("empUsername");
        String password = request.getParameter("empPassword");
        
        // ตรวจสอบผู้ใช้จากฐานข้อมูล
        Employee user = rm.authenticateUserEmployee(username, password);
        
        if (user != null) {
            ModelAndView mav = new ModelAndView("welcomeCashier");
            mav.addObject("user", user);
            // เพิ่ม user ลงใน session
            session.setAttribute("user", user);
            return mav;
        } else {
            // หากเข้าสู่ระบบไม่สำเร็จ กลับไปหน้า login พร้อมข้อความแสดงข้อผิดพลาด
            ModelAndView mav = new ModelAndView("loginCashier");
            mav.addObject("error", "Email หรือรหัสผ่านไม่ถูกต้อง");
            return mav;
        }
    }
    
    @RequestMapping(value = "/listTableReserveForCashier", method = RequestMethod.POST) //*************ข้อมูลการจองโต๊ะ**********
    public ModelAndView listTableForCashier(HttpSession session) {
    	CashierManager manager = new CashierManager();
        List<Reserve> cashier = manager.getAllReserve();
        ModelAndView mav = new ModelAndView("listTableForCashier");

        session.setAttribute("listable", cashier);
        if (cashier.isEmpty()) {
            mav.addObject("error_message", "ยังไม่มีการจอง");
        }
        mav.addObject("add_result2", "ทำรายการสำเร็จ");
        return mav;
    }
    
 // ในไฟล์ ManageCashierController.java
 // แก้ไขเมธอดนี้

 @RequestMapping(value = "/listTableReserveForCashierv2", method = RequestMethod.POST)
 public ModelAndView listTableVtwo(HttpSession session) {
     CashierManager manager = new CashierManager();
     
     List<Order> allOpenOrders = manager.getAllOpenOrders();
     ModelAndView mav = new ModelAndView("listTableForCashier");
     session.setAttribute("ordersList", allOpenOrders); 
     
     if(allOpenOrders.isEmpty()) { // เช็คจากลิสต์ใหม่
         mav.addObject("error_message","ไม่พบรายการOrder");
     }
     mav.addObject("add_result3","ทำรายการสำเร็จ");
     return mav;
 }
 
    
    
 @RequestMapping(value = "/geteditOrderStatus", method = RequestMethod.GET)
 public ModelAndView geteditCashier(HttpServletRequest request) {
	 CashierManager rm = new CashierManager();
	 Order r = null; 
     
     try {
         // --- นี่คือส่วนที่แก้ไข ---
         String orderIdFromRequest = request.getParameter("oderId"); // 1. พยายามดึง "oderId" (o-d-e-r) 
         
         if (orderIdFromRequest == null || orderIdFromRequest.isEmpty()) {
             // 2. ถ้าไม่มี ให้ลองดึง "orderId" (o-r-d-e-r)
             orderIdFromRequest = request.getParameter("orderId");
         }
         // --- สิ้นสุดส่วนที่แก้ไข ---
 
         // 3. ส่งค่าที่ได้ไปค้นหา (ซึ่งอาจจะเป็น null ถ้ามันไม่มีทั้งสองชื่อ)
         r = rm.getOrderById(orderIdFromRequest); // 
 
     } catch (Exception ex) {
         ex.printStackTrace();
     }
     
     ModelAndView mav = new ModelAndView("Edit_order");
     mav.addObject("editorder", r != null ? r : new Order());
     return mav;
 }
//ในไฟล์ ManageCashierController.java
//...
@RequestMapping(value="/confirmEditOrder", method=RequestMethod.POST)
public ModelAndView confirmEditCashier(HttpServletRequest request) {
   CashierManager rm = new CashierManager();

   String oderIdStr = request.getParameter("oderId"); // รับมาเป็น String
   String tableId = request.getParameter("tableid");
   String orderDateStr = request.getParameter("orderDate");
   String totalPeiceStr = request.getParameter("totalPeice");
   String status = request.getParameter("status");

   // แปลง oderId เป็น int และจัดการ Exception
   int oderId = 0;
   try {
       oderId = Integer.parseInt(oderIdStr); // 👈 แก้ไข: แปลง String เป็น int
   } catch (NumberFormatException e) {
       // หากแปลงไม่ได้ ให้จัดการ Error เช่น ส่งกลับไปหน้าเดิมพร้อมข้อความ
       System.err.println("Error parsing oderId: " + oderIdStr);
       // หากเกิดข้อผิดพลาดในการแปลงรหัสออเดอร์ จะไม่สามารถดำเนินการต่อได้
       ModelAndView errorMav = new ModelAndView("Edit_order");
       errorMav.addObject("edit_result", "รหัสออเดอร์ไม่ถูกต้อง");
       return errorMav;
   }

   // แปลง totalPeice เป็น double
   double totalPeice = 0.0;
   try {
       totalPeice = Double.parseDouble(totalPeiceStr);
   } catch (Exception e) {
       e.printStackTrace();
   }

   java.sql.Date orderDate = null;
   try {
       orderDate = java.sql.Date.valueOf(orderDateStr);
   } catch (Exception e) {
       e.printStackTrace();
   }

   // ดึงข้อมูล table จาก CashierManager (หรือสร้าง object เปล่าไว้ก่อน)
   Tables table = new Tables();
   table.setTableid(tableId);

   // ✅ สร้าง object แบบใช้ set() ทีละตัว
   Order rest = new Order();
   rest.setOderId(oderId); // 👈 แก้ไข: ใช้ oderId ที่ถูกแปลงเป็น int แล้ว
   rest.setTable(table);
   rest.setOrderDate(orderDate);
   rest.setTotalPeice(totalPeice);
   rest.setStatus(status);

   boolean result = rm.updateOrder(rest);

   ModelAndView mav = new ModelAndView("Edit_order");
   mav.addObject("order", rest);

   if(result) {
       mav.addObject("add_result","บันทึกสำเร็จ"); 
   } else {
       mav.addObject("edit_result","ไม่สามารถบันทึกได้"); 
   }
   return mav;
}
//...
//▼▼▼ เมธอดใหม่สำหรับหน้าเช็คบิล ▼▼▼
 
 /**
  * เมธอดสำหรับหน้าเช็คบิล (แสดงใบเสร็จ)
  * 1. ดึงข้อมูล Order หลักตาม ID ที่ส่งมา
  * 2. ดึงข้อมูล OrderDetail (รายการอาหาร) ทั้งหมดที่อยู่ใน Order นั้น
  * 3. ส่งข้อมูลทั้งสองส่วน (และราคารวม) ไปยังหน้า paymentReceipt.jsp
  */
 @RequestMapping(value = "/checkbill-page", method = RequestMethod.GET)
 public ModelAndView showPaymentReceipt(@RequestParam("orderId") String orderId) {
     
     ModelAndView mav = new ModelAndView("paymentReceipt"); // 1. กำหนดหน้าปลายทางคือ paymentReceipt.jsp
     CashierManager manager = new CashierManager();

     try {
         // 2. ดึงข้อมูล Order หลัก (ตาม Id)
         Order orderInfo = manager.getOrderById(orderId);
         
         // 3. ดึงข้อมูล OrderDetail (รายการอาหาร)
         List<OrderDetail> orderDetails = manager.getOrderDetailsByOrderId(orderId);

         if (orderInfo != null) {
             // 4. ส่งข้อมูลไปยัง JSP
             mav.addObject("orderInfo", orderInfo); // ข้อมูล Order (Id, วันที่, โต๊ะ)
             mav.addObject("orderDetails", orderDetails); // รายการอาหาร (จำนวน, ราคา, ชื่ออาหาร)
             mav.addObject("totalPrice", orderInfo.getTotalPeice()); // ราคารวมจาก Order
         } else {
             // กรณีไม่พบ Order
             mav.addObject("orderInfo", null);
             mav.addObject("orderDetails", new ArrayList<OrderDetail>());
             mav.addObject("totalPrice", 0.0);
         }

     } catch (Exception e) {
         e.printStackTrace();
         mav.addObject("error_message", "เกิดข้อผิดพลาดในการดึงข้อมูล");
     }
     
     return mav;
 }
 
 // ▲▲▲ สิ้นสุดเมธอดใหม่ ▲▲▲
 
 @RequestMapping(value = "/processFinalPayment", method = RequestMethod.POST)
 public ModelAndView processFinalPayment(@RequestParam("orderId") String orderId, HttpSession session) {
     
     CashierManager manager = new CashierManager();
     ModelAndView mav;

     try {
         // 1. ดึง Cashier (Employee) ที่ล็อกอินอยู่
         Employee cashier = (Employee) session.getAttribute("user");
         
         // 2. ดึง Order ที่กำลังจะจ่ายเงิน
         Order orderToPay = manager.getOrderById(orderId);

         // --- ตรวจสอบข้อมูลก่อน ---
         if (cashier == null) {
             // ถ้าหลุดล็อกอิน ให้กลับไปหน้า Login
             mav = new ModelAndView("loginCashier");
             mav.addObject("error", "เซสชั่นหมดอายุ, กรุณาเข้าสู่ระบบใหม่");
             return mav;
         }
         if (orderToPay == null) {
             // ถ้าไม่พบ Order
             mav = new ModelAndView("paymentReceipt");
             mav.addObject("error_message", "ไม่พบข้อมูลออเดอร์");
             return mav;
         }
         // --- สิ้นสุดการตรวจสอบ ---


         // 3. สร้างและตั้งค่า Payment Object
         Payment payment = new Payment();
         payment.setPaymentStatus("succeed");
         payment.setPaymentDate(new Date()); // ใช้วันที่และเวลาปัจจุบันที่กด
         payment.setTotalPrice(orderToPay.getTotalPeice()); // ดึงราคารวมจาก Order
         payment.setEmployees(cashier);  // อ้างอิงถึงพนักงานที่กด
         payment.setOrders(orderToPay);    // อ้างอิงถึง Order ที่จ่าย

         // 4. บันทึก Payment ลงฐานข้อมูล
         boolean paymentSaved = manager.savePayment(payment);

         if (paymentSaved) {
             // 5. อัปเดตสถานะ Order เป็น "เสร็จสิ้น"
             orderToPay.setStatus("เสร็จสิ้น");
             manager.updateOrder(orderToPay);

             // 6. อัปเดตสถานะโต๊ะให้เป็น "ว่าง"
             Tables table = orderToPay.getTable();
             table.setStatus("Free"); 
             manager.updateTable(table); 

             // 7. ไปยังหน้า "ชำระเงินสำเร็จ"
             mav = new ModelAndView("paymentSuccess"); // ไปที่ paymentSuccess.jsp
             mav.addObject("paymentInfo", payment); // ส่งข้อมูล Payment ที่เพิ่งบันทึกไปแสดงผล
         } else {
             // หากบันทึก Payment ไม่สำเร็จ
             mav = new ModelAndView("paymentReceipt");
             mav.addObject("error_message", "เกิดข้อผิดพลาดในการบันทึกการชำระเงิน");
             mav.addObject("orderInfo", orderToPay);
             mav.addObject("orderDetails", manager.getOrderDetailsByOrderId(orderId));
             mav.addObject("totalPrice", orderToPay.getTotalPeice());
         }

     } catch (Exception e) {
         e.printStackTrace();
         mav = new ModelAndView("paymentReceipt");
         mav.addObject("error_message", "เกิดข้อผิดพลาดร้ายแรงในระบบ: " + e.getMessage());
     }

     return mav;
 }
 
}