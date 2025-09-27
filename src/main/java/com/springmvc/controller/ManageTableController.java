	package com.springmvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;


import com.springmvc.model.LoginManager;
import com.springmvc.model.Tables;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ManageTableController {
	
	 @RequestMapping(value = "/ManageTable", method = RequestMethod.GET) //*************ข้อมูลTable**********
	    public ModelAndView ManageTable(HttpSession session) {
	        LoginManager manager = new LoginManager();
	        List<Tables> table = manager.getAllTable();
	        // Change this line to point to your new manager-specific JSP
	        ModelAndView mav = new ModelAndView("listTableForManager"); // <-- Changed here

	        session.setAttribute("listTable1", table);
	        if (table.isEmpty()) {
	            mav.addObject("error_message", "โต๊ะว่างเปล่า");
	        }
	        mav.addObject("add_result2", "ทำรายการสำเร็จ");
	        return mav;
	    }

    
    @RequestMapping(value = "/gotoAddTable", method = RequestMethod.GET) //************ไปสู่หน้าAddTable*********
    public String gotoAddTable() {
        return "AddTable"; 
    }
    
    
    @RequestMapping(value = "/Add_Table", method = RequestMethod.POST)  //***********AddTableร์************
    public ModelAndView registerUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	LoginManager rm = new LoginManager();

        // ดึงข้อมูลจากฟอร์ม
        String tablenumber = request.getParameter("tablenumber");
        String capacity = request.getParameter("capacity");
        String status = request.getParameter("status");

       

        // สร้าง  Object
        Tables tables = new Tables();
        tables.setTableid(tablenumber);
        tables.setCapacity(capacity);
        tables.setStatus(status);


        // บันทึกผู้ใช้ในฐานข้อมูล
        boolean result = rm.insertTable(tables);

        if (result) {
     
            ModelAndView mav = new ModelAndView("AddTable");
            mav.addObject("add_result2", "ทำรายการสำเร็จ");
            return mav;
            
        } else {
            // หากบันทึกไม่สำเร็จ, แสดงข้อความข้อผิดพลาด
            ModelAndView mav = new ModelAndView("AddTable");
            mav.addObject("error", "ไม่สามารถบันทึกข้อมูลได้");
            return mav;
        }
        
    }
    
    @RequestMapping(value = "/geteditTable", method = RequestMethod.GET)//************ดึงข้อมูลโต๊ะพื่อไปยังหน้าedit************
    public ModelAndView geteditTable(HttpServletRequest request) {
        LoginManager rm = new LoginManager();
        Tables r = null; 
        
        try {
            String table = request.getParameter("tableid");
            r = rm.getTableById(table);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        
        ModelAndView mav = new ModelAndView("Edit_Table");
        mav.addObject("table", r != null ? r : new Tables()); // แก้ให้ไม่ส่งค่า null ไป JSP
        return mav;
    }
    
    @RequestMapping(value="/confirmEditTable", method=RequestMethod.POST)//***************ยืนยันการแก้ไขโต๊ะ*************
    public ModelAndView confirmEditTable(HttpServletRequest request) {
        LoginManager rm= new LoginManager();
        String tableid = request.getParameter("tableid");
        String capacity = request.getParameter("capacity");
        String status = request.getParameter("status");

        Tables rest = new Tables(tableid, capacity, status);
        boolean result = rm.updateTable(rest);

        ModelAndView mav = new ModelAndView("Edit_Table"); 
        mav.addObject("table", rest); // **ส่ง Table object กลับไปในชื่อ "table" เสมอ**

        if(result) {
            mav.addObject("add_result","บันทึกสำเร็จ"); // ข้อความสำเร็จ
        }else {
            mav.addObject("error_result","ไม่สามารถบันทึกได้"); // ข้อความล้มเหลว
        }
        return mav;
    }
    
    @RequestMapping(value = "/deleteTable", method = RequestMethod.POST)  //*************ลบพนักงานเสริฟ*************
    public ModelAndView deleteTable(@RequestParam("empusername") String tables) {
        LoginManager rm = new LoginManager();
        Tables reg = rm.getTableById(tables);

        if (reg != null) {
            rm.deleteTable(reg);
        }

        List<Tables> list = rm.getAllTable();
        
        ModelAndView mav = new ModelAndView("listTable");
        
        mav.addObject("deleted","ลบสำเร็จ" );

        if (list.isEmpty()) {
            mav.addObject("error_msg", "ยังไม่มีคนลงทะเบียน");
        }

        return mav;
    }
}
