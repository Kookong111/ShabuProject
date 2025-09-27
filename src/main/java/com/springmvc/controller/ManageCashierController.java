package com.springmvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.CashierManager;
import com.springmvc.model.Employee;

import com.springmvc.model.Reserve;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ManageCashierController {

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
    
    @RequestMapping(value = "/listTableReserveForCashier", method = RequestMethod.GET) //*************ข้อมูลการจองโต๊ะ**********
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
}
