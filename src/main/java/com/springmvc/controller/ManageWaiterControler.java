package com.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.WaiterManager;
import com.springmvc.model.Employee;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ManageWaiterControler {
	
    @RequestMapping(value = "/LoginWaiter", method = RequestMethod.POST)
    public ModelAndView loginWaiter(HttpServletRequest request,HttpSession session) {
    	WaiterManager rm = new WaiterManager();

        // ดึงข้อมูลจากฟอร์ม
        String usernames = request.getParameter("empUsername");
        String passwords = request.getParameter("empPassword");
        
        // ตรวจสอบผู้ใช้จากฐานข้อมูล
        Employee user = rm.authenticateWaiter(usernames, passwords);
        
        if (user != null) {
            ModelAndView mav = new ModelAndView("welcomeWaiter");
            mav.addObject("users", user);
            // เพิ่ม user ลงใน session
            session.setAttribute("users", user);
            return mav;
        } else {
            // หากเข้าสู่ระบบไม่สำเร็จ กลับไปหน้า login พร้อมข้อความแสดงข้อผิดพลาด
            ModelAndView mav = new ModelAndView("loginWaiter");
            mav.addObject("error", "Email หรือรหัสผ่านไม่ถูกต้อง");
            return mav;
        }
    }
}
