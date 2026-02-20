
package com.springmvc.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.FoodITemManager;
import com.springmvc.model.FoodType;
import com.springmvc.model.LoginManager;
import com.springmvc.model.MenuFood;
import com.springmvc.model.Tables;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class ManageMenuFoodController {
    @RequestMapping(value = "/ListAllMenuFood", method = RequestMethod.GET) // *************ข้อมูลFood**********
    public ModelAndView ListAllMenuFood(HttpSession session) {
        FoodITemManager manager = new FoodITemManager();
        List<MenuFood> menufood = manager.getAllFoodItem();
        List<FoodType> foodTypes = manager.getAllFoodTypes();
        ModelAndView mav = new ModelAndView("listMenuFood");

        session.setAttribute("listmenuFood", menufood);
        if (menufood.isEmpty()) {
            mav.addObject("error_message", "รายการว่างเปล่า");
        }
        mav.addObject("add_result2", "ทำรายการสำเร็จ");
        mav.addObject("foodTypes", foodTypes); // ส่งประเภทอาหารไป JSP
        return mav;
    }

    @RequestMapping(value = "/gotoAddMenu", method = RequestMethod.GET)
    public ModelAndView gotoAddMenu() {
        FoodITemManager foodManager = new FoodITemManager();
        List<FoodType> foodTypes = foodManager.getAllFoodTypes(); // ดึงจาก DB

        ModelAndView mav = new ModelAndView("AddMenuFood");
        mav.addObject("foodTypes", foodTypes); // ส่งให้ JSP
        return mav;
    }

    @RequestMapping(value = "/Add_MenuFood", method = RequestMethod.POST)
public ModelAndView registerUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
    
    FoodITemManager foodManager = new FoodITemManager();

   
    String url = request.getParameter("url");
    String foodname = request.getParameter("foodname");
    String prices = request.getParameter("price");
    String type = request.getParameter("type");
    String status = request.getParameter("status"); 

   
    FoodType foodType = foodManager.getFoodTypeByName(type);
    
    
    ModelAndView mav = new ModelAndView("AddMenuFood");

    // ตรวจสอบว่าพบประเภทอาหารหรือไม่
    if (foodType == null) {
        mav.addObject("error", "ไม่พบประเภทอาหารที่เลือกในระบบ");
       
        mav.addObject("foodTypes", foodManager.getAllFoodTypes()); 
        return mav;
    }

    try {
      
        MenuFood menus = new MenuFood();
        menus.setFoodImage(url);
        menus.setFoodname(foodname);
        menus.setPrice(Double.parseDouble(prices));
        menus.setFoodtype(foodType); 
        
        // กำหนดสถานะอาหารที่รับมาจากหน้าจอ
        if (status != null && !status.isEmpty()) {
            menus.setStatus(status);
        } else {
            menus.setStatus("พร้อมเสิร์ฟ"); // ค่า Default กรณีไม่ได้ส่งค่ามา
        }

      
        boolean result = foodManager.insertMenuFood(menus);

        if (result) {
            mav.addObject("add_result", "เพิ่มเมนูอาหารเรียบร้อยแล้ว");
        } else {
            mav.addObject("error", "เกิดข้อผิดพลาดในการบันทึกข้อมูล");
        }
        
    } catch (NumberFormatException e) {
        mav.addObject("error", "กรุณาระบุราคาเป็นตัวเลขที่ถูกต้อง");
        e.printStackTrace();
    } catch (Exception e) {
        mav.addObject("error", "เกิดข้อผิดพลาด: " + e.getMessage());
        e.printStackTrace();
    }

   
    List<FoodType> foodTypes = foodManager.getAllFoodTypes();
    mav.addObject("foodTypes", foodTypes);

    return mav;
}

    @RequestMapping(value = "/geteditMenufood", method = RequestMethod.GET)
    public ModelAndView geteditTable(HttpServletRequest request) {
        FoodITemManager rm = new FoodITemManager();
        MenuFood r = null;

        try {
            String menus = request.getParameter("foodId");
            if (menus != null && !menus.isEmpty()) {
                r = rm.getMenuFoodeById(menus);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        List<FoodType> foodTypes = rm.getAllFoodTypes();

        ModelAndView mav = new ModelAndView("Edit_MenuFood");
        mav.addObject("menu", r != null ? r : new MenuFood());
        mav.addObject("foodTypes", foodTypes); // ✅ ส่ง foodTypes ไป JSP
        return mav;
    }

   @RequestMapping(value = "/confirmEditMenuFood", method = RequestMethod.POST)
public ModelAndView confirmEditMenuFood(HttpServletRequest request) {
    FoodITemManager rm = new FoodITemManager();
    List<FoodType> foodTypes = rm.getAllFoodTypes(); 

    // 1. รับค่าพารามิเตอร์ (รวม Status ที่เพิ่มเข้ามา)
    String foodIdStr = request.getParameter("foodId");
    String url = request.getParameter("foodImage");
    String foodname = request.getParameter("foodname");
    String prices = request.getParameter("price");
    String type = request.getParameter("type");
    String status = request.getParameter("status"); // 👈 รับค่า Status จากฟอร์มแก้ไข

    ModelAndView mav = new ModelAndView("Edit_MenuFood");
    mav.addObject("foodTypes", foodTypes); 

    MenuFood menuToDisplay = null; 

    try {
        int foodId = Integer.parseInt(foodIdStr);
        double price = Double.parseDouble(prices);

        // หา foodType จากชื่อ
        FoodType foodType = rm.getFoodTypeByName(type);
        if (foodType == null) {
            menuToDisplay = rm.getMenuFoodeById(foodIdStr);
            mav.addObject("menu", menuToDisplay != null ? menuToDisplay : new MenuFood());
            mav.addObject("error_result", "ประเภทอาหารไม่ถูกต้อง");
            return mav;
        }

        // 2. สร้างวัตถุใหม่เพื่อทำการ update และกำหนดค่า Status
        MenuFood rest = new MenuFood();
        rest.setFoodId(foodId);
        rest.setFoodImage(url);
        rest.setFoodname(foodname);
        rest.setPrice(price);
        rest.setFoodtype(foodType);
        rest.setStatus(status); // 👈 นำ Status ที่รับมาใส่ใน Object
        
        menuToDisplay = rest; 

        // 3. ทำการ Update ลงฐานข้อมูล
        boolean result = rm.updateMenuFood(rest);
        
        if (result) {
            mav.addObject("add_result", "บันทึกสำเร็จ");
        } else {
            mav.addObject("error_result", "ไม่สามารถบันทึกได้");
        }
    } catch (Exception e) {
        mav.addObject("error_result", "เกิดข้อผิดพลาด: " + e.getMessage());
        e.printStackTrace();
        if (menuToDisplay == null) {
             menuToDisplay = rm.getMenuFoodeById(foodIdStr);
        }
    }
    
    // ส่ง MenuFood object กลับไปเสมอ เพื่อให้หน้า JSP แสดงข้อมูลล่าสุดที่แก้ไข
    mav.addObject("menu", menuToDisplay != null ? menuToDisplay : new MenuFood());
    
    return mav;
}

    @RequestMapping(value = "/deleteMenuFood", method = RequestMethod.POST)
    public ModelAndView deleteMenuFood(@RequestParam("deleteMenuFood") String menu) {
        FoodITemManager rm = new FoodITemManager();
        MenuFood reg = rm.getMenuFoodById(menu);

        if (reg != null) {
            rm.deleteMenuFood(reg);
        }

        List<MenuFood> list = rm.getAllFoodItem();

        ModelAndView mav = new ModelAndView("listMenuFood");

        mav.addObject("deleted", "ลบสำเร็จ");

        if (list.isEmpty()) {
            mav.addObject("error_msg", "ยังไม่มีคนลงทะเบียน");
        }

        return mav;

    }

    @RequestMapping(value = "/addFoodType", method = RequestMethod.POST)
    public ModelAndView addFoodType(@RequestParam("foodtypeName") String name) {
    
    FoodITemManager manager = new FoodITemManager();
    FoodType newType = new FoodType();
    newType.setFoodtypeName(name);
    

    // บันทึกลงฐานข้อมูล
    boolean result = manager.insertFoodType(newType); 

    // เมื่อเสร็จแล้วให้กลับไปหน้า ListAllMenuFood
    ModelAndView mav = new ModelAndView("redirect:/ListAllMenuFood");
    
    if (result) {
        mav.addObject("add_result2", "เพิ่มประเภทอาหารสำเร็จ");
    } else {
        mav.addObject("error_message", "ไม่สามารถเพิ่มประเภทอาหารได้");
    }
    return mav;
}
    @RequestMapping(value = "/deleteFoodType", method = RequestMethod.POST)
    public ModelAndView deleteFoodType(@RequestParam("foodtypeId") String foodtypeId) {
        FoodITemManager manager = new FoodITemManager();
        FoodType type = manager.findFoodTypeById(foodtypeId);
        if (type != null) {
            manager.deleteFoodType(type);
        }
        return new ModelAndView("redirect:/ListAllMenuFood");
    }
}