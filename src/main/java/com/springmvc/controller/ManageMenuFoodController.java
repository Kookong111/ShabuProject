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
        ModelAndView mav = new ModelAndView("listMenuFood");

        session.setAttribute("listmenuFood", menufood);
        if (menufood.isEmpty()) {
            mav.addObject("error_message", "รายการว่างเปล่า");
        }
        mav.addObject("add_result2", "ทำรายการสำเร็จ");
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
        LoginManager rm = new LoginManager();

        // รับค่าจาก form
        String url = request.getParameter("url");
        String foodname = request.getParameter("foodname");
        String prices = request.getParameter("price");
        String type = request.getParameter("type"); // ชื่อประเภท เช่น "อาหาร", "เครื่องดื่ม" เป็นต้น

        // ค้นหา FoodType จากชื่อ
        FoodType foodType = foodManager.getFoodTypeByName(type);
        if (foodType == null) {
            ModelAndView mav = new ModelAndView("AddMenuFood");
            mav.addObject("error", "ไม่พบประเภทอาหารที่เลือก");
            return mav;
        }

        // สร้าง MenuFood
        MenuFood menus = new MenuFood();
        menus.setFoodImage(url);
        menus.setFoodname(foodname);
        menus.setPrice(Double.parseDouble(prices));
        menus.setFoodtype(foodType); // เชื่อม FoodType ที่ดึงมา

        // บันทึก
        boolean result = rm.insertMenuFood(menus);

        ModelAndView mav = new ModelAndView("AddMenuFood");
        if (result) {
            mav.addObject("add_result", "ทำรายการสำเร็จ");
        } else {
            mav.addObject("error", "ไม่สามารถบันทึกข้อมูลได้");
        }

        List<FoodType> foodTypes = foodManager.getAllFoodTypes(); // ดึงจาก DB
        mav.addObject("foodTypes", foodTypes); // ส่งให้ JSP

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

        String foodIdStr = request.getParameter("foodId");
        String url = request.getParameter("foodImage");
        String foodname = request.getParameter("foodname");
        String prices = request.getParameter("price");
        String type = request.getParameter("type");

        ModelAndView mav = new ModelAndView("Edit_MenuFood");

        try {
            int foodId = Integer.parseInt(foodIdStr);
            double price = Double.parseDouble(prices);

            // หา foodType จากชื่อ
            FoodType foodType = rm.getFoodTypeByName(type);
            if (foodType == null) {
                mav.addObject("error_result", "ประเภทอาหารไม่ถูกต้อง");
                return mav;
            }

            // สร้างวัตถุใหม่
            MenuFood rest = new MenuFood();
            rest.setFoodId(foodId);
            rest.setFoodImage(url);
            rest.setFoodname(foodname);
            rest.setPrice(price);
            rest.setFoodtype(foodType);

            boolean result = rm.updateMenuFood(rest);
            mav.addObject("menu", rest); // ส่งกลับไปให้แสดงในฟอร์ม

            if (result) {
                mav.addObject("add_result", "บันทึกสำเร็จ");
            } else {
                mav.addObject("error_result", "ไม่สามารถบันทึกได้");
            }
        } catch (Exception e) {
            mav.addObject("error_result", "เกิดข้อผิดพลาด: " + e.getMessage());
            e.printStackTrace();
        }

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

}
