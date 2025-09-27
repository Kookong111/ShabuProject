package com.springmvc.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class CashierManager {
    public Employee authenticateUserEmployee(String empUsername, String empPassword) {
        Session session = null;
        Employee user = null; // เพิ่มการ return user object ถ้าเจอข้อมูลที่ตรงกัน
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();

            // ค้นหาผู้ใช้จากฐานข้อมูล
            user = (Employee) session.createQuery("FROM Employee WHERE empUsername = :empUsername AND empPassword = :empPassword")
                    .setParameter("empUsername", empUsername)
                    .setParameter("empPassword", empPassword)
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
