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
    @RequestMapping(value = "/homecashier", method = RequestMethod.GET) // ***********กลับหน้าhome***************
    public String homecer() {
        return "welcomeCashier";
    }

    @RequestMapping(value = "/backToListOrder", method = RequestMethod.GET)
    public ModelAndView backToListOrder(HttpSession session) {
        CashierManager manager = new CashierManager();
        // ดึงข้อมูลออเดอร์ล่าสุดทุกครั้ง
        List<Order> allOpenOrders = manager.getAllOpenOrders();
        ModelAndView mav = new ModelAndView("listTableForCashier");
        mav.addObject("ordersList", allOpenOrders);
        if (allOpenOrders.isEmpty()) {
            mav.addObject("error_message", "ไม่พบรายการOrder");
        }
        return mav;
    }

    @RequestMapping(value = "/LoginCashier", method = RequestMethod.POST)
    public ModelAndView loginCashier(HttpServletRequest request, HttpSession session) {
        CashierManager rm = new CashierManager();

        // ดึงข้อมูลจากฟอร์ม
        String username = request.getParameter("empUsername");
        String password = request.getParameter("empPassword");

        // ✅ [NEW] ตรวจสอบว่า username ขึ้นต้นด้วย "CUS" หรือไม่
        if (username == null || !username.toUpperCase().startsWith("CUS")) {
            ModelAndView mav = new ModelAndView("loginCashier");
            mav.addObject("error", "ชื่อผู้ใช้ต้องขึ้นต้นด้วย CUS เท่านั้น");
            return mav;
        }

        // ✅ [NEW] ตรวจสอบว่า password มีตัวอักษร + ตัวเลข 8 ตัวขึ้นไป
        if (password == null || password.length() < 8) {
            ModelAndView mav = new ModelAndView("loginCashier");
            mav.addObject("error", "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร");
            return mav;
        }

        boolean hasLetters = password.matches(".*[a-zA-Z].*");
        boolean hasNumbers = password.matches(".*[0-9].*");

        if (!hasLetters || !hasNumbers) {
            ModelAndView mav = new ModelAndView("loginCashier");
            mav.addObject("error", "รหัสผ่านต้องมีตัวอักษรและตัวเลขรวมกัน");
            return mav;
        }

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
            mav.addObject("error", "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
            return mav;
        }
    }

    @RequestMapping(value = "/listTableReserveForCashier", method = RequestMethod.POST) // *************ข้อมูลการจองโต๊ะ**********
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

        if (allOpenOrders.isEmpty()) { // เช็คจากลิสต์ใหม่
            mav.addObject("error_message", "ไม่พบรายการOrder");
        }
        mav.addObject("add_result3", "ทำรายการสำเร็จ");
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

    @RequestMapping(value = "/confirmEditOrder", method = RequestMethod.POST)
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
            oderId = Integer.parseInt(oderIdStr);
        } catch (NumberFormatException e) {
            System.err.println("Error parsing oderId: " + oderIdStr);
            ModelAndView errorMav = new ModelAndView("Edit_order");
            // ควรส่งข้อมูลเดิมกลับไปเพื่อให้หน้าไม่ว่างเปล่า
            Order tempOrder = new Order(); // ต้องสร้าง Object สำหรับส่งกลับ
            tempOrder.setOderId(0);
            // ... ตั้งค่า field อื่นๆ ที่จำเป็น
            errorMav.addObject("editorder", tempOrder);
            errorMav.addObject("edit_result", "รหัสออเดอร์ไม่ถูกต้อง");
            return errorMav;
        }

        // ... (โค้ดแปลงข้อมูลที่เหลือ) ...
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
        rest.setOderId(oderId);
        rest.setTable(table);
        rest.setOrderDate(orderDate);
        rest.setTotalPeice(totalPeice);
        rest.setStatus(status);

        boolean result = rm.updateOrder(rest);

        if (result) {
            // ✅ 1. ถ้าบันทึกสำเร็จ ให้ Redirect กลับไปที่เมธอด GET (geteditOrderStatus)
            // พร้อมส่ง ID เพื่อให้เมธอดนั้นดึงข้อมูลที่อัปเดตล่าสุดจาก DB มาแสดง
            ModelAndView mav = new ModelAndView("redirect:/geteditOrderStatus");
            mav.addObject("oderId", oderIdStr); // ส่ง ID กลับไปเป็น Query Parameter
            mav.addObject("add_result", "บันทึกสำเร็จ"); // ส่งข้อความสำเร็จ
            return mav;

        } else {
            // ✅ 2. ถ้าบันทึกไม่สำเร็จ ให้อยู่หน้าเดิมและส่ง Object
            // ที่ผู้ใช้พยายามบันทึกกลับไป
            ModelAndView mav = new ModelAndView("Edit_order");
            mav.addObject("editorder", rest); // ใช้ชื่อ editorder เพื่อให้ JSP แสดงผล
            mav.addObject("edit_result", "ไม่สามารถบันทึกได้");
            return mav;
        }
    }
    // ...
    // ...
    // ▼▼▼ เมธอดใหม่สำหรับหน้าเช็คบิล ▼▼▼

    /**
     * เมธอดสำหรับหน้าเช็คบิล (แสดงใบเสร็จ)
     * 1. ดึงข้อมูล Order หลักตาม ID ที่ส่งมา
     * 2. ดึงข้อมูล OrderDetail (รายการอาหาร) ทั้งหมดที่อยู่ใน Order นั้น
     * 3. ส่งข้อมูลทั้งสองส่วน (และราคารวม) ไปยังหน้า paymentReceipt.jsp
     */
    @RequestMapping(value = "/checkbill-page", method = RequestMethod.GET)
    public ModelAndView showPaymentReceipt(@RequestParam("orderId") String orderId,
            @RequestParam(value = "from", required = false) String from) {

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

                // 5. ตรวจสอบว่าออเดอร์นี้ชำระแล้วหรือยัง
                if ("เสร็จสิ้น".equals(orderInfo.getStatus())) {
                    mav.addObject("isPaid", true);
                } else {
                    mav.addObject("isPaid", false);
                }
            } else {
                // กรณีไม่พบ Order
                mav.addObject("orderInfo", null);
                mav.addObject("orderDetails", new ArrayList<OrderDetail>());
                mav.addObject("totalPrice", 0.0);
            }

            // กำหนดปลายทางสำหรับปุ่ม "กลับไปหน้ารายการบิล"
            String returnTo = "backToPastBills"; // default for cashier
            if ("manager".equalsIgnoreCase(from)) {
                returnTo = "backToPastBillsManager";
            }
            mav.addObject("returnTo", returnTo);

        } catch (Exception e) {
            e.printStackTrace();
            mav.addObject("error_message", "เกิดข้อผิดพลาดในการดึงข้อมูล");
        }

        return mav;
    }

    // ▲▲▲ สิ้นสุดเมธอดใหม่ ▲▲▲

    // ... (imports) ...

    @RequestMapping(value = "/processFinalPayment", method = RequestMethod.POST)
    public ModelAndView processFinalPayment(@RequestParam("orderId") String orderId,
            HttpServletRequest request,
            HttpSession session) {
        CashierManager manager = new CashierManager();

        try {
            // 1. ดึงข้อมูลพนักงานจาก Session
            Employee cashier = (Employee) session.getAttribute("user");

            // 2. ดึงข้อมูล Order และรายการอาหารเดิมมาวนลูป
            Order orderToPay = manager.getOrderById(orderId);
            List<OrderDetail> orderDetails = manager.getOrderDetailsByOrderId(orderId);
            double finalPrice = 0.0;

            for (OrderDetail detail : orderDetails) {
                // ดึงค่าจำนวน (Quantity) ที่ส่งมาจากฟอร์ม
                String qtyStr = request.getParameter("quantity_" + detail.getOdermenuId());
                if (qtyStr != null) {
                    int newQty = Integer.parseInt(qtyStr);

                    if (newQty > 0) {
                        detail.setQuantity(newQty);
                        manager.updateOrderDetail(detail); // อัปเดตจำนวนใหม่ลง DB
                        finalPrice += (newQty * detail.getPriceAtTimeOfOrder());
                    } else {
                        // ถ้าถูกลบ (Quantity = 0) ให้เซตสถานะยกเลิก
                        detail.setQuantity(0);
                        detail.setStatus("cancelled");
                        manager.updateOrderDetail(detail);
                    }
                }
            }

            // 3. อัปเดตยอดเงินรวมสุดท้ายใน Order
            orderToPay.setTotalPeice(finalPrice);
            orderToPay.setStatus("เสร็จสิ้น");
            manager.updateOrder(orderToPay);

            // 4. บันทึกข้อมูลการชำระเงิน
            Payment payment = new Payment();
            payment.setPaymentStatus("succeed");
            payment.setPaymentDate(new java.util.Date());
            payment.setTotalPrice(finalPrice);
            payment.setEmployees(cashier);
            payment.setOrders(orderToPay);

            if (manager.savePayment(payment)) {
                // 5. คืนสถานะโต๊ะให้เป็นว่าง
                Tables table = orderToPay.getTable();
                table.setStatus("Free");
                manager.updateTable(table);

                ModelAndView mav = new ModelAndView("paymentSuccess");
                mav.addObject("paymentInfo", payment);
                mav.addObject("orderDetails", orderDetails);
                return mav;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new ModelAndView("redirect:/backToListOrder");
    }

    /**
     * เมธอดสำหรับดูรายการบิลย้อนหลัง (ดูรายการ Payment ที่สำเร็จแล้ว)
     */
    @RequestMapping(value = "/viewPastBills", method = { RequestMethod.GET, RequestMethod.POST })
    public ModelAndView viewPastBills(HttpSession session) {
        CashierManager manager = new CashierManager();
        List<Payment> pastBills = manager.getAllSuccessfulPayments();
        ModelAndView mav = new ModelAndView("pastBills");
        mav.addObject("pastBills", pastBills);
        if (pastBills.isEmpty()) {
            mav.addObject("error_message", "ไม่พบรายการบิลย้อนหลัง");
        }
        return mav;
    }

    /**
     * Method สำหรับกลับไปหน้ารายการบิล (redirect)
     */
    @RequestMapping(value = "/backToPastBills", method = RequestMethod.GET)
    public String backToPastBills() {
        return "redirect:/viewPastBills";
    }

}