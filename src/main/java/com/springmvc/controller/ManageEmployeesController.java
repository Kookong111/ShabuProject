package com.springmvc.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import com.springmvc.model.Employee;
import com.springmvc.model.LoginManager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ManageEmployeesController {
	@RequestMapping(value = "/deleteEmployeeCashier", method = RequestMethod.POST) //************ลบแคชเชียร์***************
    public ModelAndView delUserCashier(@RequestParam("empusername") String username) {
        LoginManager rm = new LoginManager();
        Employee reg = rm.getEmployeeByUsername(username);

        if (reg != null) {
            rm.deleteEmployee(reg);
        }

        List<Employee> list = rm.getAllCashier();
        ModelAndView mav = new ModelAndView("listCashier");
        mav.addObject("list", list);

        if (list.isEmpty()) {
            mav.addObject("error_msg", "ยังไม่มีคนลงทะเบียน");
        }

        return mav;
    }
    
    @RequestMapping(value = "/geteditcashier", method = RequestMethod.GET)//************ดึงข้อมูลแคชเชียร์เพื่อไปยังหน้าedit************
    public ModelAndView geteditCashier(HttpServletRequest request) {
        LoginManager rm = new LoginManager();
        Employee r = null; 
        
        try {
            String username = request.getParameter("empUsername");
            r = rm.getEmployeeById(username);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        ModelAndView mav = new ModelAndView("Edit_cashier");
        mav.addObject("cashier", r != null ? r : new Employee()); // แก้ให้ไม่ส่งค่า null ไป JSP
        return mav;
    }
    
    @RequestMapping(value="/confirmEditCashier", method=RequestMethod.POST)//*********ยืนยันการแก้ไขแคชเชียร์***************
    public ModelAndView confirmEditCashier(HttpServletRequest request) {
        LoginManager rm= new LoginManager();
        String empUsername = request.getParameter("empUsername");
        String password = request.getParameter("password");
        String empname = request.getParameter("empname");
        String age = request.getParameter("age");
        String position = request.getParameter("position");
        String imgurl = request.getParameter("position");

        Employee rest = new Employee(empUsername, password, empname, age,position,imgurl);
        boolean result = rm.updateEmployee(rest);

        ModelAndView mav = new ModelAndView("Edit_cashier"); // View ยังคงเป็น Edit_cashier
        mav.addObject("cashier", rest); // **ส่ง Employee object กลับไปในชื่อ "cashier" เสมอ**

        if(result) {
            mav.addObject("add_result","บันทึกสำเร็จ"); 
        }else {
            mav.addObject("edit_result","ไม่สามารถบันทึกได้"); 
        }
        return mav;
    }

    
    
    
    @RequestMapping(value = "/deleteEmployeeWaiter", method = RequestMethod.POST)  //*************ลบพนักงานเสริฟ*************
    public ModelAndView delUserWaiter(@RequestParam("empusername") String username) {
        LoginManager rm = new LoginManager();
        Employee reg = rm.getEmployeeByUsername(username);

        if (reg != null) {
            rm.deleteEmployee(reg);
        }

        List<Employee> list = rm.getAllWaiter();
        
        ModelAndView mav = new ModelAndView("listWaiter");
        
        mav.addObject("deleted","ลบสำเร็จ" );

        if (list.isEmpty()) {
            mav.addObject("error_msg", "ยังไม่มีคนลงทะเบียน");
        }

        return mav;
    }
    
    @RequestMapping(value = "/geteditWaiter", method = RequestMethod.GET)//**************ดึงข้อมูลพนักงานเสริฟเพื่อแก้ไข*****************
    public ModelAndView getedit(HttpServletRequest request) {
        LoginManager rm = new LoginManager();
        Employee r = null; // แก้จาก new Employee() เป็น null
        
        try {
            String username = request.getParameter("empUsername");
            r = rm.getEmployeeById(username);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        ModelAndView mav = new ModelAndView("Edit_waiter");
        mav.addObject("waiter", r != null ? r : new Employee()); // แก้ให้ไม่ส่งค่า null ไป JSP
        return mav;
    }
    
    @RequestMapping(value="/confirmWaiter", method=RequestMethod.POST)//***************ยืนยันการแก้ไขพนักงานเสริฟ*************
    public ModelAndView confirmEdit(HttpServletRequest request) {
        LoginManager rm= new LoginManager();
        String empUsername = request.getParameter("empUsername");
        String password = request.getParameter("password");
        String empname = request.getParameter("empname");
        String age = request.getParameter("age");
        String position = request.getParameter("position");
        String imgurl = request.getParameter("position");

        Employee rest = new Employee(empUsername, password, empname, age,position,imgurl);
        boolean result = rm.updateEmployee(rest);

        ModelAndView mav = new ModelAndView("Edit_waiter"); // View ยังคงเป็น Edit_cashier
        mav.addObject("waiter", rest); // **ส่ง Employee object กลับไปในชื่อ "cashier" เสมอ**

        if(result) {
            mav.addObject("add_result","บันทึกสำเร็จ"); // ข้อความสำเร็จ
        }else {
            mav.addObject("error_result","ไม่สามารถบันทึกได้"); // ข้อความล้มเหลว
        }
        return mav;
    }
    
    @RequestMapping(value = "/listwaiter", method = RequestMethod.GET)//************ข้อมูลพนักงานเสริฟ**************
    public ModelAndView listwaiter(HttpSession session) {
    	LoginManager manager = new LoginManager();
        List<Employee> waiter = manager.getAllWaiter();
        ModelAndView mav = new ModelAndView("listWaiter");
        
        
        session.setAttribute("listl", waiter);
        if (waiter.isEmpty()) {
            mav.addObject("error_message", "ยังไม่มีพนักงานเสริฟ์");
            
        }
        
        return mav;
    }
    
    @RequestMapping(value = "/listcashier", method = RequestMethod.GET) //*************ข้อมูลCashier**********
    public ModelAndView listcaiter(HttpSession session) {
    	LoginManager manager = new LoginManager();
        List<Employee> cashier = manager.getAllCashier();
        ModelAndView mav = new ModelAndView("listCashier");

        session.setAttribute("listl2", cashier);
        if (cashier.isEmpty()) {
            mav.addObject("error_message", "ยังไม่มีพนักงานแคชเชียร์");
        }
        mav.addObject("add_result2", "ทำรายการสำเร็จ");
        return mav;
    }
    
    @RequestMapping(value = "/gotoAddwaiter", method = RequestMethod.GET) //************ไปสู่หน้าAddWaiter*********
    public String gotoAddwaiter() {
        return "AddWaiter"; 
    }
    
    @RequestMapping(value = "/gotoAddcashier", method = RequestMethod.GET)  //**********ไปสู่หน้าAddCashire *********
    public String gotoAddcashier() {
        return "AddCashier"; 
    }

 // จัดการการสมัครสมาชิก
    @RequestMapping(value = "/Add_Cashier", method = RequestMethod.POST)  //***********เพิ่มแคชเชียร์************
    public ModelAndView registerUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	LoginManager rm = new LoginManager();

        // ดึงข้อมูลจากฟอร์ม
        String username = request.getParameter("empusername");
        String password = request.getParameter("password");
        String fullname = request.getParameter("empname");
        String age = request.getParameter("age");
        String position = request.getParameter("position");
        String url = request.getParameter("url");


        // สร้าง Register Object
        Employee user = new Employee();
        user.setEmpUsername(username);
        user.setEmpPassword(password);
        user.setEmpname(fullname);
        user.setAge(age);
        user.setPosition(position);
        user.setImage(url);


        // บันทึกผู้ใช้ในฐานข้อมูล
        boolean result = rm.insertEmployee(user);

        if (result) {
     
            ModelAndView mav = new ModelAndView("AddCashier");
            mav.addObject("add_result2", "ทำรายการสำเร็จ");
            return mav;
            
        } else {
            // หากบันทึกไม่สำเร็จ, แสดงข้อความข้อผิดพลาด
            ModelAndView mav = new ModelAndView("AddCashier");
            mav.addObject("error", "ไม่สามารถบันทึกข้อมูลได้");
            return mav;
        }
        
    }
    
    @RequestMapping(value = "/Add_Waiter", method = RequestMethod.POST)  //*********เพิ่มพนักงานเสริฟ**********
    public ModelAndView registerUsers(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	LoginManager rm = new LoginManager();

        // ดึงข้อมูลจากฟอร์ม
        String username = request.getParameter("empusername");
        String password = request.getParameter("password");
        String fullname = request.getParameter("empname");
        String age = request.getParameter("age");
        String position = request.getParameter("position");
        String url = request.getParameter("url");


        // สร้าง Register Object
        Employee user = new Employee();
        user.setEmpUsername(username);
        user.setEmpPassword(password);
        user.setEmpname(fullname);
        user.setAge(age);
        user.setPosition(position);
        user.setImage(url);


        // บันทึกผู้ใช้ในฐานข้อมูล
        boolean result = rm.insertEmployee(user);

        if (result) {
            // หากบันทึกสำเร็จ, ส่งไปยัง login.jsp
           //response.sendRedirect("login");//
            ModelAndView mav = new ModelAndView("AddWaiter");
            mav.addObject("add_result", "ทำรายการสำเร็จ");
            return mav;
            
        } else {
            // หากบันทึกไม่สำเร็จ, แสดงข้อความข้อผิดพลาด
            ModelAndView mav = new ModelAndView("AddWaiter");
            mav.addObject("error", "ไม่สามารถบันทึกข้อมูลได้");
            return mav;
        }
        
    }
}
