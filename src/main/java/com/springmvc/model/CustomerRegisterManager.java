package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import com.springmvc.model.RegistrationException;

public class CustomerRegisterManager {

    // Method สำหรับบันทึกข้อมูลผู้ใช้ใหม่ลงในตาราง Register
    public void insertRegister(Customer user) throws RegistrationException {
        if (user == null) {
            throw new RegistrationException("ข้อมูลผู้ใช้ไม่ถูกต้อง");
        }
        // basic validation
        if (user.getCususername() == null || user.getCususername().trim().isEmpty()) {
            throw new RegistrationException("กรุณาระบุชื่อผู้ใช้");
        }
        if (user.getCuspassword() == null || user.getCuspassword().trim().isEmpty()) {
            throw new RegistrationException("กรุณาระบุรหัสผ่าน");
        }
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // check duplicate username
            Customer existing = session.createQuery(
                    "FROM Customer WHERE cususername = :u", Customer.class)
                    .setParameter("u", user.getCususername())
                    .uniqueResult();
            if (existing != null) {
                throw new RegistrationException("ชื่อนี้มีผู้ใช้แล้ว โปรดเลือกชื่ออื่น");
            }

            Transaction tx = session.beginTransaction();
            session.save(user); // use save (or saveOrUpdate) depending on your flow
            tx.commit();
        } catch (RegistrationException re) {
            if (session != null && session.getTransaction() != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            throw re;
        } catch (Exception ex) {
            if (session != null && session.getTransaction() != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            // log ex
            ex.printStackTrace();
            throw new RegistrationException("เกิดข้อผิดพลาดขณะบันทึกข้อมูล กรุณาติดต่อผู้ดูแลระบบ");
        } finally {
            if (session != null)
                session.close();
        }
    }

    public Customer authenticateUsers(String username, String password) {
        Session session = null;
        Customer user = null; // เพิ่มการ return user object ถ้าเจอข้อมูลที่ตรงกัน
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();

            // ค้นหาผู้ใช้จากฐานข้อมูล
            user = (Customer) session
                    .createQuery("FROM Customer WHERE cususername = :cususername AND cuspassword = :cuspassword")
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
        return user; // คืนค่า user object ถ้าพบผู้ใช้
    }

    public Customer authenticateUsersOrThrow(String username, String password) throws AuthenticationException {
        if (username == null || username.trim().isEmpty() || password == null) {
            throw new AuthenticationException("กรุณากรอกชื่อผู้ใช้และรหัสผ่าน");
        }
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();

            Customer user = (Customer) session.createQuery(
                    "FROM Customer WHERE cususername = :cususername AND cuspassword = :cuspassword")
                    .setParameter("cususername", username)
                    .setParameter("cuspassword", password)
                    .uniqueResult();

            session.getTransaction().commit();

            if (user == null) {
                throw new AuthenticationException("ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
            }
            return user;
        } catch (AuthenticationException ae) {
            if (session != null && session.getTransaction() != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            throw ae;
        } catch (Exception ex) {
            if (session != null && session.getTransaction() != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            ex.printStackTrace();
            throw new AuthenticationException("ระบบมีปัญหาในการยืนยันตัวตน กรุณาลองใหม่อีกครั้ง");
        } finally {
            if (session != null)
                session.close();
        }
    }

}
