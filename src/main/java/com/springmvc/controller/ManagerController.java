package com.springmvc.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import com.springmvc.model.Manager; 
import com.springmvc.model.LoginManager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
@Controller
public class ManagerController {

    @RequestMapping(value = "/LoginManager", method = RequestMethod.POST)
    public ModelAndView loginUser(HttpServletRequest request,HttpSession session) {
    	LoginManager rm = new LoginManager();

        // ดึงข้อมูลจากฟอร์ม
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // ตรวจสอบผู้ใช้จากฐานข้อมูล
        Manager user = rm.authenticateUser(username, password);
        
        if (user != null) {
            ModelAndView mav = new ModelAndView("welcomemanager");
            mav.addObject("user", user);
            // เพิ่ม user ลงใน session
            session.setAttribute("user", user);
            return mav;
        } else {
            // หากเข้าสู่ระบบไม่สำเร็จ กลับไปหน้า login พร้อมข้อความแสดงข้อผิดพลาด
            ModelAndView mav = new ModelAndView("loginManager");
            mav.addObject("error", "Email หรือรหัสผ่านไม่ถูกต้อง");
            return mav;
        }
    }
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String rolelogin() {
        return "loginManager"; 
    }
    
    @RequestMapping(value = "/RoleManager", method = RequestMethod.POST)
    public String loginManager() {
        return "loginManager"; 
    }
    
    @RequestMapping(value = "/RoleCustomer", method = RequestMethod.POST)
    public String loginCustomer() {
        return "Homecustomer"; 
    }
    
    @RequestMapping(value = "/RoleCashier", method = RequestMethod.POST)
    public String loginCashier() {
        return "loginCashier"; 
    }
    
    @RequestMapping(value = "/RoleWaiter", method = RequestMethod.POST)
    public String loginWaiter() {
        return "loginWaiter"; 
    }

    @RequestMapping(value = "/ManagerEmployee", method = RequestMethod.GET)
    public String manageremp() {
        return "EmployeeInformation"; 
    }
    
    
    
    @RequestMapping(value = "/logoutmanager", method = RequestMethod.GET) //**********ออกจากระบบ************
    public String logoutmanager() {
        return "loginManager"; 
    }
    
    @RequestMapping(value = "/backmain", method = RequestMethod.GET)//************กลับสู่หน้าจัดการพนักงาน************
    public String back() {
        return "EmployeeInformation"; 
    }
    
    @RequestMapping(value = "/home", method = RequestMethod.GET)//***********กลับหน้าhome***************
    public String homemanager() {
        return "welcomemanager"; 
    }
    
    







}
