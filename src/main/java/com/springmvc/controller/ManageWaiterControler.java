package com.springmvc.controller;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.LinkedHashMap;
import java.util.UUID; 
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

// NEW IMPORTS FOR QR CODE IMAGE RESPONSE
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
// END NEW IMPORTS

import com.springmvc.model.MenuFood;
import com.springmvc.model.MenufoodManager;
import com.springmvc.model.Order;
import com.springmvc.model.OrderManager;
import com.springmvc.model.QrCodeGenerator;
import com.springmvc.model.OrderDetail; 
import com.springmvc.model.WaiterManager;
import com.springmvc.model.Employee;
import com.springmvc.model.Reserve;
import com.springmvc.model.ReserveManager;
import com.springmvc.model.TableManager;
import com.springmvc.model.Tables;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ManageWaiterControler {
    
    // ✅ เพิ่ม Field นี้: ตัวจัดการโต๊ะ เพื่อแก้ปัญหา "tableManager cannot be resolved"
    private final TableManager tableManager = new TableManager(); 
	
    @RequestMapping(value = "/LoginWaiter", method = RequestMethod.POST)
    public ModelAndView loginWaiter(HttpServletRequest request,HttpSession session) {
    	WaiterManager rm = new WaiterManager();

        String usernames = request.getParameter("empUsername");
        String passwords = request.getParameter("empPassword");
        
        // ✅ [NEW] Validation 1: Check username starts with "WAT"
        if (usernames == null || !usernames.toUpperCase().startsWith("WAT")) {
            ModelAndView mav = new ModelAndView("loginWaiter");
            mav.addObject("error", "ชื่อผู้ใช้ต้องขึ้นต้นด้วย WAT เท่านั้น");
            return mav;
        }
        
        // ✅ [NEW] Validation 2: Check password length >= 8
        if (passwords == null || passwords.length() < 8) {
            ModelAndView mav = new ModelAndView("loginWaiter");
            mav.addObject("error", "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร");
            return mav;
        }
        
        // ✅ [NEW] Validation 3: Check password has letters
        boolean hasLetters = passwords.matches(".*[a-zA-Z].*");
        // ✅ [NEW] Validation 4: Check password has numbers
        boolean hasNumbers = passwords.matches(".*[0-9].*");
        
        if (!hasLetters || !hasNumbers) {
            ModelAndView mav = new ModelAndView("loginWaiter");
            mav.addObject("error", "รหัสผ่านต้องมีตัวอักษรและตัวเลขรวมกัน");
            return mav;
        }
        
        Employee user = rm.authenticateWaiter(usernames, passwords);
        
        if (user != null) {
            ModelAndView mav = new ModelAndView("welcomeWaiter");
            mav.addObject("users", user);
            session.setAttribute("users", user);
            return mav;
        } else {
            ModelAndView mav = new ModelAndView("loginWaiter");
            mav.addObject("error", "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
            return mav;
        }
    }

    @RequestMapping(value = "/gotoManageTable", method = RequestMethod.GET)
    public ModelAndView gotoManageTable() {
        WaiterManager manager = new WaiterManager();
        List<Tables> tableList = manager.getAllTables(); 
        
        ModelAndView mav = new ModelAndView("opentableforWaiter");
        mav.addObject("tables", tableList);
        return mav;
    }

    @RequestMapping(value = "/gotoViewReservations", method = RequestMethod.GET)
    public ModelAndView gotoViewReservations() {
        WaiterManager manager = new WaiterManager();
        List<Reserve> activeReservations = manager.getAllActiveReservations(); 
        
        ModelAndView mav = new ModelAndView("listreserveforWaiter");
        mav.addObject("reservations", activeReservations);
        return mav;
    }

    @RequestMapping(value = "/checkInCustomer", method = RequestMethod.POST)
    public String checkInCustomer(@RequestParam("tableid") String tableid) {
        WaiterManager manager = new WaiterManager();
        boolean success = manager.updateTableStatus(tableid, "Occupied");
        
        if (success) {
            return "redirect:/opentableforWaiter";
        } else {
            return "errorPage"; 
        }
    }
    
    // ----------------------------------------------------------------------------------
    // เมธอดสำหรับลูกค้า Walk-in: แสดงหน้าฟอร์ม (openTable.jsp)
    // ----------------------------------------------------------------------------------
    @RequestMapping(value = "/gotoOpenTable", method = RequestMethod.GET)
    public ModelAndView gotoOpenTable(@RequestParam("tableid") String tableid, HttpSession session) {

        WaiterManager manager = new WaiterManager();
        MenufoodManager menuManager = new MenufoodManager();
        
        Tables table = manager.getTableById(tableid); 

        if (table == null || !"Free".equals(table.getStatus())) {
            return new ModelAndView("redirect:/gotoManageTable", "error", "โต๊ะไม่ว่างแล้ว กรุณาเลือกใหม่");
        }
        
        // แก้ไขชื่อเมธอดตามที่ตกลงกัน
        List<MenuFood> menuList = menuManager.getAllMenufood(); 
        System.out.println("DEBUG: Menu List Size pulled from Manager: " + menuList.size());
        
        ModelAndView mav = new ModelAndView("openTable");
        mav.addObject("selectedTable", table);
        mav.addObject("menuList", menuList);
        return mav;
    }

    // ----------------------------------------------------------------------------------
    // เมธอดสำหรับลูกค้า Walk-in: ยืนยันการเปิดโต๊ะ (สร้าง Order, OrderDetail, คำนวณราคารวม)
    // ----------------------------------------------------------------------------------
    @RequestMapping(value = "/confirmOpenTable", method = RequestMethod.POST)
    public ModelAndView confirmOpenTable(
            @RequestParam("tableid") String tableid,
            @RequestParam("guestCount") Integer guestCount,
            @RequestParam("initialFoodId") Integer initialFoodId,
            HttpSession session) {
        
        WaiterManager waiterManager = new WaiterManager();
        MenufoodManager menuManager = new MenufoodManager(); 
        OrderManager orderManager = new OrderManager();
        
        Tables table = waiterManager.getTableById(tableid); 
        
        // --- 1. ตรวจสอบข้อมูลเบื้องต้น ---
        if (table == null || !"Free".equals(table.getStatus())) {
            return new ModelAndView("redirect:/gotoManageTable", "error", "โต๊ะไม่ว่างแล้ว กรุณาเลือกใหม่");
        }
        
        Integer intCapacity = null;
        try {
            intCapacity = Integer.parseInt(table.getCapacity()); 
        } catch (NumberFormatException e) {
            return new ModelAndView("redirect:/gotoManageTable", "error", "ข้อมูลโต๊ะไม่สมบูรณ์");
        }
        
        if (guestCount == null || guestCount <= 0 || guestCount > intCapacity) {
             ModelAndView mav = new ModelAndView("openTable");
             mav.addObject("selectedTable", table);
             mav.addObject("menuList", menuManager.getAllMenufood()); 
             mav.addObject("error", "จำนวนลูกค้าไม่ถูกต้อง");
             return mav;
        }

        // --- 2. ดำเนินการเปิดโต๊ะ/เปิดบิล ---
        
        // VVVV สร้าง QR Token ใหม่ VVVV
        String newQrToken = UUID.randomUUID().toString();
        table.setQrToken(newQrToken);
        // ^^^^ สิ้นสุดการสร้าง ^^^^

        // A. อัปเดตสถานะโต๊ะเป็น 'Occupied' และบันทึก QR Token ใหม่
        table.setStatus("Occupied"); 
        
        boolean statusUpdated = tableManager.updateTable(table); 
        if (!statusUpdated) {
             return new ModelAndView("redirect:/gotoManageTable", "error", "เกิดข้อผิดพลาดในการอัปเดตสถานะโต๊ะ/QR Token");
        }

        // B. สร้าง Order ใหม่
        Order newOrder = orderManager.createNewOrder(tableid, "Open"); 
        
        if (newOrder == null || newOrder.getOderId() == 0) { 
             return new ModelAndView("redirect:/gotoManageTable", "error", "เกิดข้อผิดพลาดในการสร้างบิล (Order ID เป็น 0)");
        }
        
        // C. สร้าง Order Detail
        MenuFood initialMenu = menuManager.getMenuFoodById(initialFoodId);
        if (initialMenu == null) {
             return new ModelAndView("redirect:/gotoManageTable", "error", "ไม่พบเมนูอาหารเริ่มต้นที่เลือก (Order ถูกสร้างแล้ว)");
        }
        
        double initialPriceAtTimeOfOrder = initialMenu.getPrice();
        double calculatedTotalPeice = initialPriceAtTimeOfOrder * guestCount; // คำนวณราคารวม
        
        boolean detailCreated = orderManager.createOrderDetail(
            newOrder, 
            initialMenu, 
            guestCount, 
            initialPriceAtTimeOfOrder, 
            "In Progress" 
        );
        
        if (!detailCreated) {
             return new ModelAndView("redirect:/gotoManageTable", "error", "สร้างบิลสำเร็จ แต่สร้างรายการอาหารเริ่มต้นไม่สำเร็จ");
        }
        
        // D. อัปเดต Total Peice ของ Order
        boolean totalUpdated = orderManager.updateOrderTotalPrice(newOrder, calculatedTotalPeice);
        
        if (!totalUpdated) {
             return new ModelAndView("redirect:/gotoManageTable", "error", "สร้างบิลสำเร็จ แต่ไม่สามารถอัปตราคารวมเริ่มต้นได้");
        }


        // 3. [MODIFIED] กลับไปหน้าจัดการโต๊ะ และส่ง ID, TableId, QrToken เพื่อให้ JavaScript เปิด Pop-up
        ModelAndView mav = new ModelAndView("redirect:/gotoManageTable");
        mav.addObject("orderIdToPrint", newOrder.getOderId()); 
        mav.addObject("tableId", tableid);
        mav.addObject("qrToken", newQrToken);
        return mav;
    }
    
    // ----------------------------------------------------------------------------------
    // เมธอดสำหรับลูกค้าจอง: แสดงหน้าฟอร์มยืนยัน Check-In (checkInReservation.jsp)
    // ----------------------------------------------------------------------------------
    @RequestMapping(value = "/waiterCheckIn", method = RequestMethod.GET)
    public ModelAndView waiterCheckIn(
            @RequestParam("reserveid") Integer reserveid,
            @RequestParam("tableid") String tableid,
            HttpSession session) {

        ReserveManager reserveManager = new ReserveManager();
        MenufoodManager menuManager = new MenufoodManager();

        Reserve reserveInfo = reserveManager.getReservationById(reserveid);
        // แก้ไขชื่อเมธอดตามที่ตกลงกัน
        List<MenuFood> menuList = menuManager.getAllMenufood(); 

        if (reserveInfo == null) {
            return new ModelAndView("redirect:/gotoViewReservations", "error", "ไม่พบข้อมูลการจอง");
        }

        // นำไปหน้ายืนยัน Check-in
        ModelAndView mav = new ModelAndView("checkInReservation"); 
        mav.addObject("reserveInfo", reserveInfo);
        mav.addObject("menuList", menuList); 
        return mav;
    }
    
    // ----------------------------------------------------------------------------------
    // เมธอดสำหรับลูกค้าจอง: ยืนยัน Check-In (สร้าง Order, OrderDetail, คำนวณราคารวม)
    // ----------------------------------------------------------------------------------
    @RequestMapping(value = "/confirmReservationCheckIn", method = RequestMethod.POST)
    public ModelAndView confirmReservationCheckIn(
            @RequestParam("reserveid") Integer reserveid,
            @RequestParam("tableid") String tableid,
            @RequestParam("guestCount") Integer guestCount, // จำนวนคนที่มาจริง
            @RequestParam("maxCapacity") String maxCapacityStr,
            @RequestParam("initialFoodId") Integer initialFoodId) {
        
        // Setup Managers
        ReserveManager reserveManager = new ReserveManager();
        WaiterManager waiterManager = new WaiterManager();
        MenufoodManager menuManager = new MenufoodManager(); 
        OrderManager orderManager = new OrderManager();
        
        Reserve reserveInfo = reserveManager.getReservationById(reserveid);

        // --- 1. ตรวจสอบข้อมูลและความจุ ---
        Integer maxCapacity = 0;
        try {
            maxCapacity = Integer.parseInt(maxCapacityStr);
        } catch(NumberFormatException ignored) {}

        if (reserveInfo == null || guestCount == null || guestCount <= 0 || guestCount > maxCapacity) {
            ModelAndView mav = new ModelAndView("redirect:/waiterCheckIn");
            mav.addObject("reserveid", reserveid); 
            mav.addObject("tableid", tableid);
            mav.addObject("error", "จำนวนลูกค้าที่มาจริงไม่ถูกต้อง หรือเกินความจุโต๊ะ");
            return mav;
        }

        // --- 2. ดำเนินการเปิดบิล ---
        
        // VVVV สร้าง QR Token ใหม่ VVVV
        Tables table = waiterManager.getTableById(tableid);
        String newQrToken = UUID.randomUUID().toString();
        table.setQrToken(newQrToken);
        // ^^^^ สิ้นสุดการสร้าง ^^^^
        
        // A. อัปเดตสถานะโต๊ะเป็น 'Occupied' และบันทึก QR Token ใหม่
        table.setStatus("Occupied");
        
        boolean tableUpdated = tableManager.updateTable(table);
        
        // B. อัปเดตสถานะ Reserve เป็น 'CheckedIn'
        boolean reserveUpdated = reserveManager.updateReservationStatus(reserveid, "CheckedIn");

        if (!tableUpdated || !reserveUpdated) {
            return new ModelAndView("redirect:/gotoViewReservations", "error", "เกิดข้อผิดพลาดในการอัปเดตสถานะโต๊ะ/การจอง");
        }

        // C. สร้าง Order ใหม่
        Order newOrder = orderManager.createNewOrder(tableid, "Open"); 
        if (newOrder == null || newOrder.getOderId() == 0) { 
             return new ModelAndView("redirect:/gotoViewReservations", "error", "Check-in สำเร็จ แต่เกิดข้อผิดพลาดในการสร้างบิล (Order)");
        }
        
        // D. สร้าง Order Detail และอัปเดต Total Peice (Logic เหมือน Walk-in)
        MenuFood initialMenu = menuManager.getMenuFoodById(initialFoodId);
        double initialPriceAtTimeOfOrder = initialMenu.getPrice();
        double calculatedTotalPeice = initialPriceAtTimeOfOrder * guestCount; 
        
        boolean detailCreated = orderManager.createOrderDetail(
            newOrder, 
            initialMenu, 
            guestCount, 
            initialPriceAtTimeOfOrder, 
            "In Progress" 
        );
        
        boolean totalUpdated = orderManager.updateOrderTotalPrice(newOrder, calculatedTotalPeice);
        
        if (!detailCreated || !totalUpdated) {
             return new ModelAndView("redirect:/gotoViewReservations", "error", "เปิดบิลสำเร็จ แต่สร้างรายการอาหารเริ่มต้น/ราคารวมไม่สำเร็จ");
        }

        // 3. [MODIFIED] กลับไปหน้าจัดการการจอง และส่ง ID, TableId, QrToken เพื่อให้ JavaScript เปิด Pop-up
        ModelAndView mav = new ModelAndView("redirect:/gotoManageTable"); // <<< แก้ไข Redirect ตรงนี้
        mav.addObject("orderIdToPrint", newOrder.getOderId()); 
        mav.addObject("tableId", tableid);
        mav.addObject("qrToken", newQrToken);
        return mav;
    }
    
    @RequestMapping(value = "/gohome", method = RequestMethod.GET)
    public String loadd() {
        return "welcomeWaiter"; 
    }
    
    // ----------------------------------------------------------------------------------
    // เมธอดสำหรับแสดงรายการคำสั่งซื้อที่ต้องจัดการ (Mapping: gotoViewOrders) - พร้อม Grouping
    // ----------------------------------------------------------------------------------
    @RequestMapping(value = "/gotoViewOrders", method = RequestMethod.GET)
    public ModelAndView gotoViewOrders(HttpSession session) {
        if (session.getAttribute("users") == null) {
            return new ModelAndView("redirect:/LoginWaiter", "error", "กรุณาเข้าสู่ระบบ");
        }
        
        WaiterManager waiterManager = new WaiterManager();
        
        // ดึงรายการอาหารที่ยังไม่เสร็จสิ้น (Pending, In Progress) เป็น List<OrderDetail>
        List<OrderDetail> activeOrderDetails = waiterManager.getActiveOrderDetails();
        
        // *** Logic: จัดกลุ่ม Order Detail ตาม Order ID ***
        // Key: Order ID, Value: List of OrderDetail
        Map<Integer, List<OrderDetail>> groupedOrders = new LinkedHashMap<>();
        
        if (activeOrderDetails != null) {
            for (OrderDetail detail : activeOrderDetails) {
                int orderId = detail.getOrders().getOderId(); // ดึง Order ID
                
                // ตรวจสอบว่ามี Order ID นี้ใน Map หรือยัง
                if (!groupedOrders.containsKey(orderId)) {
                    groupedOrders.put(orderId, new ArrayList<>());
                }
                groupedOrders.get(orderId).add(detail);
            }
        }
        // *** สิ้นสุด Logic จัดกลุ่ม ***

        ModelAndView mav = new ModelAndView("viewOrdersForWaiter"); 
        mav.addObject("groupedOrders", groupedOrders); // ส่ง Map ที่จัดกลุ่มแล้วไป JSP
        
        return mav;
    }
    
    // ----------------------------------------------------------------------------------
    // เมธอดสำหรับอัปเดตสถานะของ Order Detail (แบบธรรมดา)
    // ----------------------------------------------------------------------------------
    @RequestMapping(value = "/updateOrderDetailStatus", method = RequestMethod.POST)
    public String updateOrderDetailStatus(
            @RequestParam("odermenuId") int odermenuId, 
            @RequestParam("newStatus") String newStatus, 
            // เพิ่ม HttpSession เข้ามา
            HttpSession session) { 
        
        WaiterManager waiterManager = new WaiterManager();
        
        boolean success = waiterManager.updateOrderDetailStatus(odermenuId, newStatus);

        if (success) {
            // เปลี่ยนมาเก็บข้อความใน Session Attribute
            session.setAttribute("actionSuccess", "อัปเดตสถานะรายการอาหารสำเร็จ"); 
        } else {
            // เปลี่ยนมาเก็บข้อความใน Session Attribute
            session.setAttribute("actionError", "เกิดข้อผิดพลาดในการอัปเดตสถานะ");
        }
        // Redirect กลับไปหน้าเดิม โดยไม่มี Query Parameter ภาษาไทย
        return "redirect:/gotoViewOrders";
    }
    
    @RequestMapping(value = "/updateOrderToInProgress", method = RequestMethod.POST)
    public String updateOrderToInProgress(@RequestParam("orderId") int orderId, HttpSession session) { // เพิ่ม HttpSession
        WaiterManager waiterManager = new WaiterManager();
        int updatedCount = waiterManager.updateOrderDetailsStatusByOrderId(orderId, "Pending", "In Progress");

        if (updatedCount > 0) {
            // เปลี่ยนมาเก็บข้อความใน Session Attribute
            session.setAttribute("actionSuccess", "เริ่มจัดเตรียมรายการอาหาร " + updatedCount + " รายการในบิล ID: " + orderId + " แล้ว");
        } else {
            // เปลี่ยนมาเก็บข้อความใน Session Attribute
            session.setAttribute("actionError", "ไม่มีรายการอาหารที่สถานะ 'Pending' ในบิล ID: " + orderId);
        }
        // Redirect กลับไปหน้าเดิม โดยไม่มี Query Parameter ภาษาไทย
        return "redirect:/gotoViewOrders";
    }

    // ----------------------------------------------------------------------------------
    // เมธอดสำหรับอัปเดตสถานะทั้งหมดในบิลเป็น 'Served' (เสิร์ฟแล้ว)
    // ----------------------------------------------------------------------------------
    @RequestMapping(value = "/updateOrderToServed", method = RequestMethod.POST)
    public String updateOrderToServed(@RequestParam("orderId") int orderId, HttpSession session) { // เพิ่ม HttpSession
        WaiterManager waiterManager = new WaiterManager();
        int updatedCount = waiterManager.updateOrderDetailsStatusByOrderId(orderId, "In Progress", "Served");

        if (updatedCount > 0) {
            // เปลี่ยนมาเก็บข้อความใน Session Attribute
            session.setAttribute("actionSuccess", "เสิร์ฟรายการอาหาร " + updatedCount + " รายการในบิล ID: " + orderId + " แล้ว");
        } else {
            // เปลี่ยนมาเก็บข้อความใน Session Attribute
            session.setAttribute("actionError", "ไม่มีรายการอาหารที่สถานะ 'In Progress' ในบิล ID: " + orderId);
        }
        // Redirect กลับไปหน้าเดิม โดยไม่มี Query Parameter ภาษาไทย
        return "redirect:/gotoViewOrders";
    }
    
    @RequestMapping(value = "/printOrderInfo", method = RequestMethod.GET)
    public ModelAndView printOrderInfo(@RequestParam("orderId") Integer orderId) {
        
        OrderManager orderManager = new OrderManager();
        // เพิ่ม ReserveManager สำหรับดึง Order Details
        ReserveManager reserveManager = new ReserveManager(); // หรือใช้ Dependency Injection
        
        // 1. ดึงข้อมูล Order หลัก
        Order orderInfo = orderManager.getOrderById(orderId); 
        
        if (orderInfo == null) {
            return new ModelAndView("errorPage", "errorMessage", "ไม่พบข้อมูล Order ID: " + orderId);
        }
        
        Tables table = orderInfo.getTable();
        
        if (table == null || table.getQrToken() == null) {
             return new ModelAndView("errorPage", "errorMessage", "ไม่พบข้อมูลโต๊ะหรือ QR Token สำหรับ Order นี้");
        }
        
        // 2. สร้าง URL สำหรับ QR Code (จาก QrCodeGenerator Helper)
        String qrUrl = QrCodeGenerator.generateQrUrl(table.getQrToken());
        
        // 3. ดึงรายการ OrderDetails
        List<OrderDetail> details = reserveManager.getOrderDetailsByOrderId(orderId);
        
        // 4. ส่งข้อมูลทั้งหมดไปยัง Print JSP
        ModelAndView mav = new ModelAndView("printOrderSheet"); // ชี้ไปที่ JSP ใหม่
        mav.addObject("orderInfo", orderInfo);
        mav.addObject("table", table);
        mav.addObject("qrUrl", qrUrl); 
        mav.addObject("orderDetails", details); // <<< เพิ่ม Order Details
        
        return mav;
    }
    
    @RequestMapping(value = "/findAndPrintOrder", method = RequestMethod.GET)
    public ModelAndView findAndPrintOrder(@RequestParam("tableId") String tableId) {
        
        OrderManager orderManager = new OrderManager();
        // 1. ค้นหา Order ที่ Active ที่สุดสำหรับโต๊ะนี้ (ใช้เมธอดที่สร้างไว้)
        Order activeOrder = orderManager.getActiveOrderByTableId(tableId);

        if (activeOrder != null) {
            // 2. ถ้าพบ Order ที่ Active ให้ Redirect ไปยังเมธอด Print หลัก
            return new ModelAndView("redirect:/printOrderInfo?orderId=" + activeOrder.getOderId());
        } else {
            // 3. ถ้าไม่พบ (เป็นไปได้ว่าบิลถูกปิดไปแล้ว หรือมีปัญหา)
            return new ModelAndView("opentableforWaiter", "errorMessage", "ไม่พบบิลที่เปิดใช้งานอยู่สำหรับโต๊ะ " + tableId);
        }
    }
    
    // ----------------------------------------------------------------------------------
    // ✅ NEW METHOD: สำหรับสร้างและส่งรูปภาพ QR Code กลับไปที่ Browser
    // ----------------------------------------------------------------------------------
    @RequestMapping(value = "/generateQrForTable", method = RequestMethod.GET, produces = "image/png")
    public ResponseEntity<byte[]> generateQrCodeForTable(@RequestParam("token") String token) {
        try {
            // 1. สร้าง URL เต็มรูปแบบที่ QR Code จะชี้ไป
            String qrContent = QrCodeGenerator.generateQrUrl(token); 
            
            // 2. สร้างภาพ QR Code ในรูปแบบ byte array
            byte[] qrImageBytes = QrCodeGenerator.generateQrCodeImage(qrContent, 200, 200); 

            // 3. ตั้งค่า Header เพื่อบอก Browser ว่านี่คือรูปภาพ PNG
            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.IMAGE_PNG);
            headers.setContentLength(qrImageBytes.length);

            // 4. ส่งรูปภาพกลับไป
            return new ResponseEntity<>(qrImageBytes, headers, HttpStatus.OK);

        } catch (Exception e) {
            e.printStackTrace();
            // ถ้าเกิดข้อผิดพลาดในการสร้าง ให้ส่งสถานะ Internal Server Error
            return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR); 
        }
    }
}