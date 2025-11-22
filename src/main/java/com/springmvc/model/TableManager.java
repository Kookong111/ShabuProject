package com.springmvc.model;

import java.sql.SQLException;
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
    
    public boolean updateStatusToReserved(String tableId) {
        SessionFactory sessionFactory = null;
        Session session = null;
        try {
            sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            // ดึงข้อมูลโต๊ะที่ต้องการอัปเดต
            Tables table = (Tables) session.get(Tables.class, tableId);
            if (table != null) {
                table.setStatus("Already reserved"); // เปลี่ยนสถานะโต๊ะ
                session.update(table);       // อัปเดตลงฐานข้อมูล
                session.getTransaction().commit();
                return true;
            } else {
                System.out.println("ไม่พบข้อมูลโต๊ะที่ต้องการอัปเดต: " + tableId);
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            if (session != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback(); // ย้อนกลับถ้ามี error
            }
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
    public boolean updateStatusToFree(String tableid) {
        Session session = null;
        try {
            // ดึง SessionFactory ตามวิธีที่คุณใช้ในคลาส TableManager
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection(); 
            session = sessionFactory.openSession();
            session.beginTransaction();

            Tables table = (Tables) session.get(Tables.class, tableid);
            if (table != null) {
                table.setStatus("Free"); // ตั้งสถานะเป็น Free
                session.update(table);
                session.getTransaction().commit();
                return true;
            }
        } catch (Exception ex) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return false;
    }
    
    public boolean updateTableStatus(String tableid, String newStatus) {
 		Session session = null;
 		try {
 			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();	
 			session = sessionFactory.openSession();
 			session.beginTransaction();

 			Tables table = (Tables) session.get(Tables.class, tableid);
 			if (table != null) {
 				table.setStatus(newStatus); // ตั้งสถานะตามที่ส่งมา
 				session.update(table);
 				session.getTransaction().commit();
 				return true;
 			}
 		} catch (Exception ex) {
 			if (session != null && session.getTransaction() != null) {
 				session.getTransaction().rollback();
 			}
 			ex.printStackTrace();
 		} finally {
 			if (session != null) {
 				session.close();
 			}
 		}
 		return false;
 	}

}
