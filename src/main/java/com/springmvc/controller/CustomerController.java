package com.springmvc.controller;
 
import java.sql.Date;
import java.util.List;
import java.util.Map; 

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Cart; 
import com.springmvc.model.CartItem; 
import com.springmvc.model.Customer;
import com.springmvc.model.CustomerRegisterManager;
import com.springmvc.model.FoodITemManager;
import com.springmvc.model.FoodType;
import com.springmvc.model.MenuFood;
import com.springmvc.model.MenufoodManager;
import com.springmvc.model.Reserve;
import com.springmvc.model.ReserveManager;
import com.springmvc.model.TableManager;
import com.springmvc.model.Tables;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class CustomerController {

    @RequestMapping(value = "/regiscus", method = RequestMethod.GET)
    public String loadd() {
        return "registerCustomer"; 
    }
	// จัดการการสมัครสมาชิก
    @RequestMapping(value = "/registercustomer", method = RequestMethod.POST)
    public ModelAndView registerUser(HttpServletRequest request) throws Exception {
    	CustomerRegisterManager rm = new CustomerRegisterManager();

        // ดึงข้อมูลจากฟอร์ม
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String age = request.getParameter("age");
        String phonenumber = request.getParameter("phonenumber");
       

        // สร้าง Register Object
        Customer user = new Customer();

          user.setCususername(username);
          user.setCuspassword(password);
          user.setGmail(email);
          user.setCusname(name);
          user.setPhonenumber(phonenumber);
          user.setAge(age);
          user.setGmail(email);

        // บันทึกผู้ใช้ในฐานข้อมูล
        boolean result = rm.insertRegister(user);

        if (result) {
            // หากบันทึกสำเร็จ, ส่งไปยัง login.jsp
            ModelAndView mav = new ModelAndView("loginCustomer");
            return mav;
            
        } else {
            // หากบันทึกไม่สำเร็จ, แสดงข้อความข้อผิดพลาด
            ModelAndView mav = new ModelAndView("registerCustomer");
            mav.addObject("error", "ไม่สามารถบันทึกข้อมูลได้");
            return mav;
        }
        
    }

    
    @RequestMapping(value = "/loginCustomer", method = RequestMethod.POST)
    public ModelAndView loginUser(HttpServletRequest request,HttpSession session) {
    	CustomerRegisterManager rm = new CustomerRegisterManager();

        // ดึงข้อมูลจากฟอร์ม
        String username = request.getParameter("cususername");
        String password = request.getParameter("cuspassword");
        
        // ตรวจสอบผู้ใช้จากฐานข้อมูล
        Customer user = rm.authenticateUsers(username, password);
        
        if (user != null) {
            ModelAndView mav = new ModelAndView("welcomeCustomer");
            mav.addObject("user", user);
            // เพิ่ม user ลงใน session
            session.setAttribute("user", user);
            return mav;
        } else {
            // หากเข้าสู่ระบบไม่สำเร็จ กลับไปหน้า login พร้อมข้อความแสดงข้อผิดพลาด
            ModelAndView mav = new ModelAndView("loginCustomer");
            mav.addObject("error", "รหัสผ่านไม่ถูกต้อง");
            return mav;
        }
    }
    @RequestMapping(value = "/gotologin", method = RequestMethod.GET) //************ไปสู่หน้าloginCustomer*********
    public String gotologin() {
        return "loginCustomer"; 
    }
    
    @RequestMapping(value = "/gotoregister", method = RequestMethod.GET) //************ไปสู่หน้าregisterCustomer*********
    public String gotoregister() {
        return "registerCustomer"; 
    }
    
    // VVVV เมธอดจัดการการสแกน QR Code (แบบเดิม) ถูกลบแล้ว VVVV
    /*
    @RequestMapping(value = "/orderScan", method = RequestMethod.GET)
    public String handleQrCodeScan(
            @RequestParam("tableId") String tableId,
            @RequestParam("orderId") Integer orderId,
            HttpSession session) {
        // Logic นี้ถูกย้ายไปที่ OrderCustomerController.viewmenu โดยตรง
        return "redirect:/viewmenu";
    }
    */
    // ^^^^ สิ้นสุดการลบเมธอด ^^^^
    
    /**
     * Helper Method: คำนวณจำนวนรายการทั้งหมดในตะกร้าจาก Cart Object ใน Session
     */
    private int getCartTotalItems(HttpSession session) {
        Cart cart = (Cart) session.getAttribute("cartObject");
        if (cart == null) {
            return 0;
        }
        // ใช้ logic ใน Cart.java เพื่อคำนวณจำนวนรายการ (quantity รวม)
        int total = 0;
        for (CartItem item : cart.getItems().values()) {
            total += item.getQuantity();
        }
        return total;
    }
    
    // VVVV เมธอด viewMenuFood ถูกลบเนื่องจากย้าย Logic ไป OrderCustomerController VVVV
    /*
    @RequestMapping(value = "/viewmenu", method = RequestMethod.GET)
    public ModelAndView viewMenuFood(HttpSession session) { 
        // ... (Logic เก่า) ...
        return mav;
    }
    */
    // ^^^^ สิ้นสุดการลบเมธอด ^^^^
    
    // ... (โค้ดส่วนที่เหลือของคุณเหมือนเดิม) ...
    
    @RequestMapping(value = "/menurecomand", method = RequestMethod.GET)
    public ModelAndView showMenu() {
        MenufoodManager manager = new MenufoodManager();
        List<MenuFood> menulist = manager.getAllMenufood();
        ModelAndView mav = new ModelAndView("menu");
        mav.addObject("menuItems", menulist); 
        return mav;
    }
    
    @RequestMapping(value = "/listTable", method = RequestMethod.GET)
    public ModelAndView showListtable() {
        MenufoodManager manager = new MenufoodManager();
        List<Tables> tablelist = manager.getAllListTable();
        ModelAndView mav = new ModelAndView("listTable");
        mav.addObject("tables", tablelist); 
        return mav;
    }
    
    @RequestMapping(value = "/reserve&listTable", method = RequestMethod.GET)
    public ModelAndView reservelistTable() {
        MenufoodManager manager = new MenufoodManager();
        List<Tables> tablelist = manager.getAllListTable();
        ModelAndView mav = new ModelAndView("listTable");
        mav.addObject("tables", tablelist); 
        return mav;
    }
    
    @RequestMapping(value = "/getdetailTable", method = RequestMethod.GET)
    public ModelAndView geteditTable(HttpServletRequest request) {
    	TableManager rm = new TableManager();
        Tables r = null; 
        
        try {
            String table = request.getParameter("tableid");
            r = rm.getTableById(table);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        ModelAndView mav = new ModelAndView("Detailtable");
        mav.addObject("table", r != null ? r : new Tables()); 
        return mav;
    }

    @RequestMapping(value = "/reserveTable", method = RequestMethod.GET)
    public ModelAndView reserveTable(HttpServletRequest request, HttpSession session) {
    	TableManager rm = new TableManager();
        Tables selectedTable = null;
        
        try {
            String tableId = request.getParameter("tableid");
            selectedTable = rm.getTableById(tableId);
            
            // ตรวจสอบว่าโต๊ะสามารถจองได้หรือไม่
            if (selectedTable != null && !"Free".equals(selectedTable.getStatus())) {
                // ถ้าโต๊ะไม่ว่าง ส่งกลับไปหน้ารายการโต๊ะพร้อมข้อความแจ้งเตือน
                MenufoodManager manager = new MenufoodManager();
                List<Tables> tablelist = manager.getAllListTable();
                ModelAndView mav = new ModelAndView("listTable");
                mav.addObject("tables", tablelist);
                mav.addObject("error", "โต๊ะนี้ไม่สามารถจองได้ เนื่องจากมีสถานะ: " + selectedTable.getStatus());
                return mav;
            }
            
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        // ตรวจสอบว่าผู้ใช้ล็อกอินแล้วหรือไม่
        Customer user = (Customer) session.getAttribute("user");
        if (user == null) {
            // ถ้ายังไม่ล็อกอิน ส่งไปหน้าล็อกอิน
            ModelAndView mav = new ModelAndView("loginCustomer");
            mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนทำการจองโต๊ะ");
            return mav;
        }
        
        ModelAndView mav = new ModelAndView("reservetable");
        mav.addObject("selectedTable", selectedTable != null ? selectedTable : new Tables());
        mav.addObject("user", user);
        return mav;
    }
    @RequestMapping(value = "/confirmReservation", method = RequestMethod.POST)
    public ModelAndView confirmReservation(HttpServletRequest request, HttpSession session) {
        ReserveManager reserveManager = new ReserveManager();

        try {
            // ✅ ตรวจสอบว่าผู้ใช้ล็อกอินแล้วหรือยัง
            Customer user = (Customer) session.getAttribute("user");
            if (user == null) {
                ModelAndView mav = new ModelAndView("loginCustomer");
                mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนทำการจองโต๊ะ");
                return mav;
            }

            // ✅ ดึงค่าจากฟอร์ม
            String tableid = request.getParameter("tableid");
            String reservationDateStr = request.getParameter("reservationDate");
            String reservationTime = request.getParameter("reservationTime");
            String numberOfGuestsStr = request.getParameter("numberOfGuests");

            // ✅ ตรวจสอบค่าว่าง
            if (tableid == null || reservationDateStr == null || reservationTime == null || numberOfGuestsStr == null ||
                tableid.trim().isEmpty() || reservationDateStr.trim().isEmpty() ||
                reservationTime.trim().isEmpty() || numberOfGuestsStr.trim().isEmpty()) {

                Tables selectedTable = reserveManager.getTableById(tableid);
                ModelAndView mav = new ModelAndView("reservetable");
                mav.addObject("selectedTable", selectedTable != null ? selectedTable : new Tables());
                mav.addObject("user", user);
                mav.addObject("error", "กรุณากรอกข้อมูลให้ครบถ้วน");
                return mav;
            }

            // ✅ แปลงข้อมูล
            Date reservationDate = java.sql.Date.valueOf(reservationDateStr);
            Integer numberOfGuests = Integer.parseInt(numberOfGuestsStr);

            // ✅ ดึงข้อมูลโต๊ะและลูกค้าจากฐานข้อมูล
            Tables table = reserveManager.getTableById(tableid);
            Customer customer = reserveManager.getCustomerById(user.getCusId());

            if (table == null || customer == null) {
                ModelAndView mav = new ModelAndView("reservetable");
                mav.addObject("error", "ไม่พบข้อมูลโต๊ะหรือลูกค้า");
                return mav;
            }

            // ✅ สร้างอ็อบเจ็กต์ Reserve
            Reserve reservation = new Reserve();
            reservation.setNumberOfGuests(numberOfGuests);
            reservation.setReservedate(reservationDate);
            reservation.setReservetime(reservationTime);
            reservation.setStatus("Reserved");
            reservation.setCustomers(customer);
            reservation.setTables(table);

            // ✅ บันทึกข้อมูลการจอง
            boolean reserveId = reserveManager.insertReservation(reservation);

            if (reserveId) {
                // ✅ เพิ่มส่วนนี้: อัปเดตสถานะโต๊ะให้เป็น "Reserved"
                TableManager tableManager = new TableManager();
                boolean updated = tableManager.updateStatusToReserved(tableid);
                if (!updated) {
                    System.out.println("⚠️ ไม่สามารถอัปเดตสถานะโต๊ะได้ tableid = " + tableid);
                }

                // ✅ หากบันทึกสำเร็จ ไปหน้าแสดงผลการจองสำเร็จ
                ModelAndView mav = new ModelAndView("ReserveSucces");
                mav.addObject("reservation", reservation);
                mav.addObject("user", user);

                // ดึงข้อมูลโต๊ะเพื่อแสดงผล
                TableManager lm = new TableManager();
                Tables table1 = lm.getTableById(tableid);
                mav.addObject("table", table1);

                return mav;
            } else {
                // ❌ หากบันทึกไม่สำเร็จ
                TableManager lm = new TableManager();
                Tables selectedTable = lm.getTableById(tableid);

                ModelAndView mav = new ModelAndView("reservetable");
                mav.addObject("selectedTable", selectedTable != null ? selectedTable : new Tables());
                mav.addObject("user", user);
                mav.addObject("error", "เกิดข้อผิดพลาดในการบันทึกข้อมูล กรุณาลองใหม่อีกครั้ง");
                return mav;
            }

        } catch (NumberFormatException e) {
            // ❌ แปลงตัวเลขไม่ได้
            String tableid = request.getParameter("tableid");
            Customer user = (Customer) session.getAttribute("user");
            Tables selectedTable = reserveManager.getTableById(tableid);

            ModelAndView mav = new ModelAndView("reservetable");
            mav.addObject("selectedTable", selectedTable != null ? selectedTable : new Tables());
            mav.addObject("user", user);
            mav.addObject("error", "ข้อมูลจำนวนผู้ใช้บริการไม่ถูกต้อง");
            return mav;

        } catch (IllegalArgumentException e) {
            // ❌ รูปแบบวันที่ผิด
            String tableid = request.getParameter("tableid");
            Customer user = (Customer) session.getAttribute("user");
            Tables selectedTable = reserveManager.getTableById(tableid);

            ModelAndView mav = new ModelAndView("reservetable");
            mav.addObject("selectedTable", selectedTable != null ? selectedTable : new Tables());
            mav.addObject("user", user);
            mav.addObject("error", "รูปแบบวันที่ไม่ถูกต้อง");
            return mav;

        } catch (Exception e) {
            // ❌ ข้อผิดพลาดทั่วไป
            e.printStackTrace();
            String tableid = request.getParameter("tableid");
            Customer user = (Customer) session.getAttribute("user");
            Tables selectedTable = reserveManager.getTableById(tableid);

            ModelAndView mav = new ModelAndView("reservetable");
            mav.addObject("selectedTable", selectedTable != null ? selectedTable : new Tables());
            mav.addObject("user", user);
            mav.addObject("error", "เกิดข้อผิดพลาดในระบบ กรุณาลองใหม่อีกครั้ง");
            return mav;
        }
    }
   
   
 	@RequestMapping(value = "/myReservess", method = RequestMethod.GET)
 	public ModelAndView myReservations(HttpSession session) {
 	    Customer user = (Customer) session.getAttribute("user");

 	    // 1. ตรวจสอบว่าผู้ใช้เข้าสู่ระบบหรือไม่
 	    if (user == null) {
 	        ModelAndView mav = new ModelAndView("loginCustomer");
 	        mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนดูรายการจอง");
 	        return mav;
 	    }

 	    // 2. สร้าง ReserveManager เพื่อดึงข้อมูล
 	    ReserveManager reserveManager = new ReserveManager();
 	    
 	    // 3. เรียกใช้เมธอด getReservationsByCustomerId
 	    List<Reserve> reservations = null;
         try {
             // ดึงรายการจองทั้งหมดโดยใช้ CusId ของลูกค้าที่เข้าสู่ระบบ
             reservations = reserveManager.getReservationsByCustomerId(user.getCusId());
         } catch (Exception e) {
             e.printStackTrace();
             // หากเกิดข้อผิดพลาดในการดึงข้อมูล ให้ส่งรายการว่างไปแทน
             ModelAndView mav = new ModelAndView("myReverve");
             mav.addObject("user", user);
             mav.addObject("error", "เกิดข้อผิดพลาดในการดึงรายการจอง");
             return mav;
         }

 	    // 4. ส่งข้อมูลไปยังหน้า myReverve.jsp
 	    ModelAndView mav = new ModelAndView("myReverve");
 	    mav.addObject("user", user); 
 	    // ส่งรายการจองไปยัง JSP โดยใช้ชื่อ "reservations"
 	    mav.addObject("reservations", reservations);
 	    
 	    return mav;
 	}
    
 	@RequestMapping(value = "/viewReservationDetail", method = RequestMethod.GET)
 	public ModelAndView viewReservationDetail(
 	        @RequestParam("reserveid") Integer reserveid, 
 	        HttpSession session) {
 	    
 	    Customer user = (Customer) session.getAttribute("user");
 	    if (user == null) {
 	        return new ModelAndView("loginCustomer", "error", "กรุณาเข้าสู่ระบบก่อนดำเนินการ");
 	    }

 	    ReserveManager reserveManager = new ReserveManager();
 	    Reserve reservation = reserveManager.getReservationById(reserveid);

 	    // 🚩 แก้ไข: สลับเงื่อนไข!
 	    // เงื่อนไขนี้จะเป็นจริงเมื่อ:
 	    // 1. ไม่พบข้อมูลการจอง (reservation == null)
 	    // 2. ไม่พบข้อมูลลูกค้าที่เชื่อมโยง (reservation.getCustomers() == null)
 	    // 3. ID ลูกค้าที่ล็อกอิน (user.getCusId()) ไม่เท่ากับ ID เจ้าของการจอง (!=)
 	    if (reservation == null || reservation.getCustomers() == null || user.getCusId() != reservation.getCustomers().getCusId()) {
 	        
 	        // ถ้าเงื่อนไขใดเป็นจริง แสดงว่าไม่ผ่านการตรวจสอบสิทธิ์ ให้กลับไปที่ myReverve
 	        return new ModelAndView("myReverve", "error", "ไม่พบข้อมูลการจองที่คุณต้องการ หรือคุณไม่มีสิทธิ์เข้าถึงหน้านี้");
 	    }

 	    // ✅ ถ้าเงื่อนไขข้างบนเป็นเท็จ (คือพบการจอง, พบลูกค้า, และ ID ตรงกัน) 
 	    //    ให้ดำเนินการต่อไปเพื่อแสดงหน้า ReservationDetail
 	    ModelAndView mav = new ModelAndView("ReservationDetail");
 	    mav.addObject("reservation", reservation);
 	    mav.addObject("user", user);
 	    return mav;
 	}
 	@RequestMapping(value = "/cancelReservationConfirm", method = RequestMethod.GET)
 	public ModelAndView cancelReservationConfirm(
 	        @RequestParam("reserveid") Integer reserveid,
 	        @RequestParam("tableid") String tableid,
 	        HttpSession session) {

 	    Customer user = (Customer) session.getAttribute("user");
 	    ReserveManager reserveManager = new ReserveManager();
 	    TableManager tableManager = new TableManager(); 

 	    if (user == null) {
 	        return new ModelAndView("loginCustomer", "error", "กรุณาเข้าสู่ระบบก่อนดำเนินการ");
 	    }

 	    Reserve reservation = reserveManager.getReservationById(reserveid);

 	    // 1. ตรวจสอบสิทธิ์และการจอง (ใช้ != และ == เพื่อเปรียบเทียบ int)
 	    // เงื่อนไขนี้จะส่งกลับไปหน้า error ถ้า: การจองเป็น null, ข้อมูลลูกค้าเป็น null, ID ไม่ตรงกัน, หรือสถานะไม่ใช่ "Reserved"
 	    if (reservation == null || reservation.getCustomers() == null || user.getCusId() != reservation.getCustomers().getCusId() || !reservation.getStatus().equals("Reserved")) {
 	        return new ModelAndView("myReverve", "error", "ไม่สามารถยกเลิกได้: ไม่พบการจอง, ไม่มีสิทธิ์, หรือสถานะไม่เป็น 'Reserved'");
 	    }

 	    // --- ส่วนที่ขาดหายไป: ดำเนินการยกเลิก ---

 	    // 2. ดำเนินการยกเลิก (ลบข้อมูลการจองออกจากฐานข้อมูล)
 	    // *เมธอด deleteReservation ต้องถูกเพิ่มใน ReserveManager.java
 	    boolean cancelled = reserveManager.deleteReservation(reserveid); 

 	    if (cancelled) {
 	        // 3. อัปเดตสถานะโต๊ะให้เป็น 'Free' ในฐานข้อมูล
 	        // *เมธอด updateStatusToFree ต้องถูกเพิ่มใน TableManager.java
 	        boolean tableUpdated = tableManager.updateStatusToFree(tableid); 
 	        
 	        if (!tableUpdated) {
 	            System.err.println("❌ ERROR: ยกเลิกการจองสำเร็จ แต่ไม่สามารถอัปเดตสถานะโต๊ะ " + tableid + " เป็น Free ได้");
 	            // อาจจะเพิ่ม error message เข้าไปใน mav ด้วย แต่หลักการคือดำเนินการต่อเพราะการจองถูกลบไปแล้ว
 	        }
 	        
 	        // 4. ส่งกลับไปยังหน้ารายการพร้อมข้อความสำเร็จ
 	        // **ต้องแน่ใจว่าเมธอด myReservations(session) มีการทำงานที่ถูกต้อง**
 	        ModelAndView mav = myReservations(session); 
 	        mav.addObject("success", "✅ การจองหมายเลข " + reserveid + " ถูกยกเลิกเรียบร้อยแล้ว");
 	        return mav;

 	    } else {
 	        // 5. หากลบไม่สำเร็จ (เช่น มีปัญหา DB)
 	        return new ModelAndView("myReverve", "error", "⚠️ เกิดข้อผิดพลาดในการยกเลิกการจอง กรุณาลองใหม่");
 	    }
 	}
    @RequestMapping(value = "/gotoContact", method = RequestMethod.GET)

    public String contact() {
        return "conTact"; 
    }
    @RequestMapping(value = "/logoutCustomer", method = RequestMethod.GET)
public String logoutCustomer(HttpSession session) {
    // *** การแก้ไขที่สำคัญที่สุด: ทำลาย Session ทั้งหมด ***
    if (session != null) {
        session.invalidate(); // คำสั่งนี้จะลบทุกอย่างออกจาก Session และสร้าง Session ใหม่
    }
    
    // Redirect ไปยังหน้าหลักหรือหน้า Login
    return "Homecustomer"; // หรือหน้า WelcomeCustomer ที่ไม่มี Session
}
    
}