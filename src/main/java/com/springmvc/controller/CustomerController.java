package com.springmvc.controller;
 

import java.sql.Date;
import java.util.AbstractMap.SimpleEntry;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Customer;
import com.springmvc.model.CustomerRegisterManager;
import com.springmvc.model.FoodITemManager;
import com.springmvc.model.FoodType;
import com.springmvc.model.LoginManager;
import com.springmvc.model.MenuFood;
import com.springmvc.model.MenufoodManager;
import com.springmvc.model.Reserve;
import com.springmvc.model.ReserveManager;
import com.springmvc.model.TableManager;
import com.springmvc.model.Tables;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class CustomerController {

    @RequestMapping(value = "/regiscus", method = RequestMethod.GET)
    public String loadd() {
        return "registerCustomer"; 
    }
	// จัดการการสมัครสมาชิก
 // จัดการการสมัครสมาชิก
    @RequestMapping(value = "/registercustomer", method = RequestMethod.POST)
    public ModelAndView registerUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
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
           //response.sendRedirect("login");//
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
    
    @RequestMapping(value = "/viewmenu", method = RequestMethod.GET)
    public ModelAndView viewMenuFood() {
        FoodITemManager foodManager = new FoodITemManager();
        TableManager tables = new TableManager();
        List<MenuFood> menuList = foodManager.getAllFoodItem();
        List<FoodType> foodTypeList = foodManager.getAllFoodTypes();
        List<Tables> tablee = tables.getAllTable();

        ModelAndView mav = new ModelAndView("orderfoodCuatomer"); // ไปยังหน้า JSP ชื่อ menuCustomer.jsp
        mav.addObject("menuList", menuList);
        mav.addObject("foodTypeList", foodTypeList);
        mav.addObject("tablesList",tablee);
        return mav;
    }
    
    /**
     * เมธอดที่ถูกแก้ไขเพื่อรองรับ AJAX:
     * - ใช้ @ResponseBody เพื่อส่ง JSON กลับไป
     * - ใช้ ResponseEntity เพื่อควบคุม HTTP Status Code
     */
    @RequestMapping(value = "/updateQuantity", method = RequestMethod.POST)
    @ResponseBody 
    public ResponseEntity<Map<String, Object>> updateQuantity(
            @RequestParam("foodId") String foodId,
            @RequestParam("action") String action,
            HttpSession session) {

        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        if (cart == null) {
            cart = new HashMap<>();
        }

        try {
            int id = Integer.parseInt(foodId);
            int currentQty = cart.getOrDefault(id, 0);
            int newQty = currentQty;

            if ("increase".equals(action)) {
                newQty = currentQty + 1;
                cart.put(id, newQty);
            } else if ("decrease".equals(action) && currentQty > 0) {
                newQty = currentQty - 1;
                if (newQty == 0) {
                    cart.remove(id);
                } else {
                    cart.put(id, newQty);
                }
            } else {
                 // กรณีที่ currentQty == 0 และ action เป็น decrease
                 newQty = currentQty;
            }

            session.setAttribute("cart", cart);

            // สร้าง JSON object เพื่อส่งกลับไปให้ AJAX (HTTP 200 OK)
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("newQuantity", newQty);
            response.put("foodId", id);

            return new ResponseEntity<>(response, HttpStatus.OK);

        } catch (NumberFormatException e) {
            // กรณีแปลงตัวเลขไม่ได้ (HTTP 400 BAD REQUEST)
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "รหัสอาหารไม่ถูกต้อง (Invalid foodId format)");
            return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
        } catch (Exception e) {
            e.printStackTrace();
            // ข้อผิดพลาดอื่น ๆ (HTTP 500 INTERNAL SERVER ERROR)
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "เกิดข้อผิดพลาดภายในเซิร์ฟเวอร์ กรุณาลองใหม่อีกครั้ง");
            return new ResponseEntity<>(response, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping(value = "/viewCart", method = RequestMethod.GET)
    public ModelAndView viewCart(HttpSession session) {
        FoodITemManager foodManager = new FoodITemManager();
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        Map<Map.Entry<Integer, Integer>, MenuFood> cartItems = new HashMap<>();

        if (cart != null) {
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                MenuFood food = foodManager.getFoodById(entry.getKey());
                cartItems.put(new SimpleEntry<>(entry.getKey(), entry.getValue()), food);
            }
        }

        ModelAndView mav = new ModelAndView("cart");
        mav.addObject("cartItems", cartItems);
        return mav;
    }
    
    
    
    
    
    
    
    
    @RequestMapping(value = "/menurecomand", method = RequestMethod.GET)
    public ModelAndView showMenu() {
        MenufoodManager manager = new MenufoodManager();
        List<MenuFood> menulist = manager.getAllMenufood();
        ModelAndView mav = new ModelAndView("menu");
        mav.addObject("menuItems", menulist); // ✅ ตรงกับ ${menuItems} ใน JSP แล้ว
        return mav;
    }
    
    @RequestMapping(value = "/listTable", method = RequestMethod.GET)
    public ModelAndView showListtable() {
        MenufoodManager manager = new MenufoodManager();
        List<Tables> tablelist = manager.getAllListTable();
        ModelAndView mav = new ModelAndView("listTable");
        mav.addObject("tables", tablelist); // ✅ ตรงกับ ${menuItems} ใน JSP แล้ว
        return mav;
    }
    
    @RequestMapping(value = "/reserve&listTable", method = RequestMethod.GET)
    public ModelAndView reservelistTable() {
        MenufoodManager manager = new MenufoodManager();
        List<Tables> tablelist = manager.getAllListTable();
        ModelAndView mav = new ModelAndView("listTable");
        mav.addObject("tables", tablelist); // ✅ ตรงกับ ${menuItems} ใน JSP แล้ว
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
        mav.addObject("table", r != null ? r : new Tables()); // แก้ให้ไม่ส่งค่า null ไป JSP
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
                    System.out.println("⚠️ ไม่สามารถอัปเดตสถานะโต๊ะได้ tableId = " + tableid);
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
   
   
 // เพิ่ม methods เหล่านี้ใน CustomerController.java

    @RequestMapping(value = "/myReservess", method = RequestMethod.GET)
    public String myReservationss() {
        return "myReverve"; 
    }
    
    @RequestMapping(value = "/gotoContact", method = RequestMethod.GET)
    public String contact() {
        return "conTact"; 
    }
    @RequestMapping(value = "/logoutCustomer", method = RequestMethod.GET)
    public String logoutCustomer() {
        return "Homecustomer"; 
    }
   

    
   





    
    
}