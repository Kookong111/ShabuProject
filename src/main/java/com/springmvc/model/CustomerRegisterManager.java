package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class CustomerRegisterManager {

	// Method สำหรับบันทึกข้อมูลผู้ใช้ใหม่ลงในตาราง Register
    public boolean insertRegister(Customer user) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            // บันทึกผู้ใช้ลงในฐานข้อมูล
            session.saveOrUpdate(user);
            session.getTransaction().commit();
            return true;  // ถ้าบันทึกสำเร็จ return true
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return false;  // ถ้าบันทึกไม่สำเร็จ return false
}
    
    public Customer authenticateUsers(String username, String password) {
        Session session = null;
        Customer user = null; // เพิ่มการ return user object ถ้าเจอข้อมูลที่ตรงกัน
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();

            // ค้นหาผู้ใช้จากฐานข้อมูล
            user = (Customer) session.createQuery("FROM Customer WHERE cususername = :cususername AND cuspassword = :cuspassword")
                    .setParameter("cususername", username)
                    .setParameter("cuspassword", password)
                    .uniqueResult();

            session.getTransaction().commit();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return user;  // คืนค่า user object ถ้าพบผู้ใช้
    }
    
   
}
