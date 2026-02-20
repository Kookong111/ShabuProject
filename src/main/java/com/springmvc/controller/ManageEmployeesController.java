package com.springmvc.controller;

import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import com.springmvc.model.Employee;
import com.springmvc.model.LoginManager;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
@Controller
public class ManageEmployeesController {
	@RequestMapping(value = "/deleteEmployeeCashier", method = RequestMethod.POST) //************ลบแคชเชียร์***************
public ModelAndView delUserCashier(@RequestParam("empusername") String username) {
    LoginManager rm = new LoginManager();
    Employee reg = rm.getEmployeeByUsername(username);
    ModelAndView mav = new ModelAndView("listCashier");
    String errorMsg = null;
    if (reg != null) {
        try {
            rm.deleteEmployee(reg);
        } catch (Exception ex) {
            ex.printStackTrace();
            errorMsg = "ไม่สามารถลบได้ เนื่องจากข้อมูลพนักงานคนนี้ถูกใช้งานอยู่ในส่วนอื่นของระบบ";
        }
    } else {
        errorMsg = "ไม่พบข้อมูลพนักงานที่ต้องการลบ";
    }
    List<Employee> list = rm.getAllCashier();
    mav.addObject("listl2", list);
    if (errorMsg != null) {
        mav.addObject("error_message", errorMsg);
    } else if (list.isEmpty()) {
        mav.addObject("error_message", "ยังไม่มีคนลงทะเบียน");
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
    
    @RequestMapping(value="/confirmEditCashier", method=RequestMethod.POST)
public ModelAndView confirmEditCashier(
        @RequestParam("empUsername") String empUsername,
        @RequestParam("password") String password,
        @RequestParam("empname") String empname,
        @RequestParam("age") String age,
        @RequestParam("position") String position,
        @RequestParam("url") MultipartFile file, // รับไฟล์จาก input type="file"
        @RequestParam("oldImageUrl") String oldImageUrl, // รับชื่อรูปเดิม
        HttpServletRequest request) {
    
    LoginManager rm = new LoginManager();
    String fileName = oldImageUrl; // ใช้ชื่อเดิมไว้ก่อน

    // ถ้ามีการเลือกไฟล์ใหม่มาให้ทำการอัปโหลด
    if (file != null && !file.isEmpty()) {
        try {
            fileName = file.getOriginalFilename();
            String uploadPath = request.getServletContext().getRealPath("/") + "resources" + File.separator + "images" + File.separator;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            file.transferTo(new File(uploadPath + fileName));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    Employee rest = new Employee(empUsername, password, empname, age, position, fileName);
    boolean result = rm.updateEmployee(rest);

    ModelAndView mav = new ModelAndView("Edit_cashier");
    mav.addObject("cashier", rest);

    if(result) {
        mav.addObject("add_result", "บันทึกสำเร็จ");
    } else {
        mav.addObject("error_result", "ไม่สามารถบันทึกได้");
    }
    return mav;
}

    
    
    
    @RequestMapping(value = "/deleteEmployeeWaiter", method = RequestMethod.POST)
@ResponseBody // เพิ่มเพื่อให้ส่ง text กลับไปหา JavaScript ตรงๆ
public String delUserWaiter(@RequestParam("empusername") String username) {
    LoginManager rm = new LoginManager();
    Employee reg = rm.getEmployeeByUsername(username);

    if (reg != null) {
        rm.deleteEmployee(reg);
        return "success"; // ส่งข้อความยืนยัน
    }
    return "fail";
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
    
    @RequestMapping(value="/confirmWaiter", method=RequestMethod.POST)
public ModelAndView confirmEdit(
        @RequestParam("empUsername") String empUsername,
        @RequestParam("password") String password,
        @RequestParam("empname") String empname,
        @RequestParam("age") String age,
        @RequestParam("position") String position,
        @RequestParam("url") MultipartFile file,
        @RequestParam("oldImageUrl") String oldImageUrl,
        HttpServletRequest request) {
    
    LoginManager rm = new LoginManager();
    String fileName = oldImageUrl; // ใช้ชื่อไฟล์เดิมเป็นค่าเริ่มต้น

    // จัดการไฟล์รูปภาพใหม่หากมีการอัปโหลด
    if (file != null && !file.isEmpty()) {
        try {
            fileName = file.getOriginalFilename();
            String uploadPath = request.getServletContext().getRealPath("/") + "resources" + File.separator + "images" + File.separator;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            file.transferTo(new File(uploadPath + fileName));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    Employee rest = new Employee(empUsername, password, empname, age, position, fileName);
    boolean result = rm.updateEmployee(rest);

    ModelAndView mav = new ModelAndView("Edit_waiter");
    mav.addObject("waiter", rest);

    if(result) {
        mav.addObject("add_result", "บันทึกสำเร็จ");
    } else {
        mav.addObject("error_result", "ไม่สามารถบันทึกได้");
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
   @RequestMapping(value = "/Add_Cashier", method = RequestMethod.POST)
public ModelAndView registerUser(
        @RequestParam("empusername") String username,
        @RequestParam("password") String password,
        @RequestParam("empname") String fullname,
        @RequestParam("age") String age,
        @RequestParam("position") String position,
        @RequestParam("url") MultipartFile file, // รับไฟล์รูปภาพ
        HttpServletRequest request) {

    LoginManager rm = new LoginManager();

    // 1. เช็ค ID ซ้ำ
    Employee exist = rm.getEmployeeByUsername(username);
    if (exist != null) {
        ModelAndView mav = new ModelAndView("AddCashier");
        mav.addObject("error", "เพิ่มข้อมูลไม่ได้ เนื่องจากมีข้อมูลของพนักงานคนนี้อยู่แล้ว"); // แจ้งเตือนตามที่ต้องการ
        return mav;
    }

    // 2. จัดการบันทึกไฟล์รูปภาพ
    String fileName = file.getOriginalFilename();
    try {
        if (!file.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("/") + "resources" + File.separator + "images" + File.separator;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs(); // สร้าง folder resources/images
            file.transferTo(new File(uploadPath + fileName));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 3. บันทึกลงฐานข้อมูล
    Employee user = new Employee(username, password, fullname, age, position, fileName);
    boolean result = rm.insertEmployee(user);

    ModelAndView mav = new ModelAndView("AddCashier");
    if (result) {
        mav.addObject("add_result2", "ทำรายการสำเร็จ");
    } else {
        mav.addObject("error", "ไม่สามารถบันทึกข้อมูลได้");
    }
    return mav;
}
    
    @RequestMapping(value = "/Add_Waiter", method = RequestMethod.POST)
public ModelAndView registerUsers(
        @RequestParam("empusername") String username,
        @RequestParam("password") String password,
        @RequestParam("empname") String fullname,
        @RequestParam("age") String age,
        @RequestParam("position") String position,
        @RequestParam("url") MultipartFile file, // เปลี่ยนเป็นรับไฟล์รูปภาพ
        HttpServletRequest request) {

    LoginManager rm = new LoginManager();

    // 1. เช็ค ID พนักงานซ้ำ
    Employee exist = rm.getEmployeeByUsername(username);
    if (exist != null) {
        ModelAndView mav = new ModelAndView("AddWaiter");
        mav.addObject("error", "เพิ่มข้อมูลไม่ได้ เนื่องจากมีข้อมูลของพนักงานคนนี้อยู่แล้ว");
        return mav;
    }

    // 2. จัดการบันทึกไฟล์รูปภาพลง Folder resources/images
    String fileName = file.getOriginalFilename();
    try {
        if (!file.isEmpty()) {
            String uploadPath = request.getServletContext().getRealPath("/") + "resources" + File.separator + "images" + File.separator;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            file.transferTo(new File(uploadPath + fileName));
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    // 3. บันทึกลงฐานข้อมูล
    Employee user = new Employee(username, password, fullname, age, position, fileName);
    boolean result = rm.insertEmployee(user);

    ModelAndView mav = new ModelAndView("AddWaiter");
    if (result) {
        mav.addObject("add_result", "ทำรายการสำเร็จ");
    } else {
        mav.addObject("error", "ไม่สามารถบันทึกข้อมูลได้");
    }
    return mav;
}
}
