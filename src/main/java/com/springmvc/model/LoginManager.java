package com.springmvc.model;

import java.sql.Connection;
import java.sql.ConnectionBuilder;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import com.mysql.cj.xdevapi.Table;

public class LoginManager {

	// Method สำหรับดึงข้อมูลผู้ใช้ทั้งหมดจากตาราง Register
		public List<Manager> getAllmanager() {
			List<Manager> list = new ArrayList<>();
			Session session = null;
			try {
				SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
				session = sessionFactory.openSession();

				list = session.createQuery("FROM Manager", Manager.class).list(); 
			} catch (Exception ex) {
				ex.printStackTrace();
			} finally {
				if (session != null) {
					session.close(); // Ensure the session is closed even on exception
				}
			}
			return list;
		}
		
	    public Manager authenticateUser(String username, String password) {
	        Session session = null;
	        Manager user = null; // เพิ่มการ return user object ถ้าเจอข้อมูลที่ตรงกัน
	        try {
	            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	            session = sessionFactory.openSession();
	            session.beginTransaction();

	            // ค้นหาผู้ใช้จากฐานข้อมูล
	            user = (Manager) session.createQuery("FROM Manager WHERE username = :username AND password = :password")
	                    .setParameter("username", username)
	                    .setParameter("password", password)
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
	    
	    public List<Employee> getAllCashier() {
	        List<Employee> list = new ArrayList<>();
	        Session session = null;
	        try {
	            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	            session = sessionFactory.openSession();

	            // ค้นหาเฉพาะพนักงานที่มี empUsername ขึ้นต้นด้วย "CUS"
	            list = session.createQuery("FROM Employee WHERE empUsername LIKE 'CUS%'", Employee.class).list(); 

	        } catch (Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (session != null) {
	                session.close(); 
	            }
	        }
	        return list;
	    }
	    
	    public List<Employee> getAllWaiter() {
	        List<Employee> list = new ArrayList<>();
	        Session session = null;
	        try {
	            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	            session = sessionFactory.openSession();

	            // ค้นหาเฉพาะพนักงานที่มี empUsername ขึ้นต้นด้วย "WAT"
	            list = session.createQuery("FROM Employee WHERE empUsername LIKE 'WAT%'", Employee.class).list(); 

	        } catch (Exception ex) {
	            ex.printStackTrace();
	        } finally {
	            if (session != null) {
	                session.close(); 
	            }
	        }
	        return list;
	    }

	    
		// Method สำหรับบันทึกข้อมูลผู้ใช้ใหม่ลงในตาราง Register
	    public boolean insertEmployee(Employee user) {
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
	    
	    public boolean deleteEmployee(Employee r) {
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

	    
	    public Employee getEmployeeByUsername(String username) {
	        Employee reg = null;
	        try (Session session = HibernateConnection.doHibernateConnection().openSession()) {
	            reg = session.createQuery("FROM Employee WHERE empUsername = :empUsername", Employee.class)
	                         .setParameter("empUsername", username)
	                         .uniqueResult();
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }
	        return reg;
	    }


	    public Employee getEmployeeById(String username) {
	        List<Employee> list = new ArrayList<>();
	        try {
	            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	            Session session = sessionFactory.openSession();
	            session.beginTransaction();
	            
	            // ใช้ Parameterized Query เพื่อป้องกัน SQL Injection
	            list = session.createQuery("FROM Employee WHERE empUsername = :username", Employee.class)
	                          .setParameter("username", username)
	                          .list();
	            session.getTransaction().commit();
	            session.close();
	        } catch (Exception ex) {
	            ex.printStackTrace();
	        }

	        // เช็คก่อนว่า list มีข้อมูลหรือไม่
	        return list.isEmpty() ? null : list.get(0);
	    }
	    public boolean updateEmployee(Employee r) {
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
	    
	    
	    
	   
	    
	 
}
