package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

public class FoodITemManager {
	public List<MenuFood> getAllFoodItem() {
        List<MenuFood> list = new ArrayList<>();
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // ค้นหาเฉพาะพนักงานที่มี empUsername ขึ้นต้นด้วย "CUS"
            list = session.createQuery("FROM MenuFood", MenuFood.class).list(); 

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close(); 
            }
        }
        return list;
    }
	public FoodType findFoodTypeById(String id) {
        Session session = null;
        FoodType foodType = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            foodType = session.get(FoodType.class, id);
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close(); 
            }
        }
        return foodType;
    }
	public FoodType getFoodTypeByName(String foodtypeName) {
	    Session session = null;
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        session = sessionFactory.openSession();

	        String hql = "FROM FoodType WHERE foodtypeName = :name";
	        return session.createQuery(hql, FoodType.class)
	                      .setParameter("name", foodtypeName)
	                      .uniqueResult();

	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    } finally {
	        if (session != null) session.close();
	    }
	}
	public List<FoodType> getAllFoodTypes() {
	    List<FoodType> list = new ArrayList<>();
	    Session session = null;
	    try {
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        session = sessionFactory.openSession();
	        list = session.createQuery("FROM FoodType", FoodType.class).list();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        if (session != null) session.close();
	    }
	    return list;
	}
	
	public MenuFood getMenuFoodeById(String menufood) {
	    try {
	        int foodId = Integer.parseInt(menufood);  // 👈 แปลงก่อน
	        SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
	        Session session = sessionFactory.openSession();
	        session.beginTransaction();

	        MenuFood result = session.get(MenuFood.class, foodId);  // 👈 ใช้ session.get()
	        
	        session.getTransaction().commit();
	        session.close();
	        return result;
	    } catch (Exception ex) {
	        ex.printStackTrace();
	        return null;
	    }
	}

    
    public boolean updateMenuFood(MenuFood r) {
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
    
    public boolean deleteMenuFood(MenuFood r) {
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
    
    public MenuFood getMenuFoodById(String menu) {
        try {
            int id = Integer.parseInt(menu); // ป้องกันความผิดพลาดจาก type
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            Session session = sessionFactory.openSession();
            MenuFood result = session.get(MenuFood.class, id);
            session.close();
            return result;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public MenuFood getFoodById(int foodId) {
        SessionFactory factory = HibernateConnection.doHibernateConnection();
        try (Session session = factory.openSession()) {
            return session.get(MenuFood.class, foodId);
        }
    }
    
    

}
