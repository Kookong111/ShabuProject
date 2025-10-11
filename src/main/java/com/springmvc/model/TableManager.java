package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class TableManager {
	public List<Tables> getAllTable() {
        List<Tables> lists = new ArrayList<>();
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ค้นหาเฉพาะพนักงานที่มี empUsername ขึ้นต้นด้วย "CUS"
            lists = session.createQuery("FROM Tables", Tables.class).list(); 

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close(); 
            }
        }
        return lists;
    }
    
    public boolean insertTable(Tables tables) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            // บันทึกผู้ใช้ลงในฐานข้อมูล
            session.saveOrUpdate(tables);
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
    
    public Tables getTableById(String tables) {
        List<Tables> list = new ArrayList<>();
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            Session session = sessionFactory.openSession();
            session.beginTransaction();
            
            // ใช้ Parameterized Query เพื่อป้องกัน SQL Injection
            list = session.createQuery("FROM Tables WHERE tableid = :table", Tables.class)
                          .setParameter("table", tables)
                          .list();
            session.getTransaction().commit();
            session.close();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        // เช็คก่อนว่า list มีข้อมูลหรือไม่
        return list.isEmpty() ? null : list.get(0);
    }
    
    public boolean updateTable(Tables r) {
    	try {
    		SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
    		Session session = sessionFactory.openSession();
    		session.beginTransaction();
    		session.update(r);
    		session.getTransaction().commit();
    		session.close();
    		return true;
    		}catch(Exception ex) {
    			ex.printStackTrace();
    		}
    	return false;
    }
    
    public boolean deleteTable(Tables r) {
        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
            Transaction tx = session.beginTransaction();
            session.delete(r);
            tx.commit();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
}
