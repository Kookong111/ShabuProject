package com.springmvc.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import java.util.Date;
import java.util.List;

public class OrderManager {
    
    // Method สำหรับดึงข้อมูล MenuFood ตาม ID
    public MenuFood getMenuFoodById(Integer foodId) {
        Session session = null;
        MenuFood menuFood = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            menuFood = session.get(MenuFood.class, foodId);
            session.getTransaction().commit();
            return menuFood;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return null;
    }
    
    // *** เพิ่มเมธอดนี้เพื่อแก้ไขข้อผิดพลาดในการคอมไพล์ ***
    /**
     * ดึงข้อมูล Order หลักตาม ID
     */
    public Order getOrderById(Integer orderId) {
        Session session = null;
        Order order = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            order = session.get(Order.class, orderId); // ใช้ session.get() เพื่อดึง Order
            
            session.getTransaction().commit();
            return order;
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return null;
    }
    
    // Method สำหรับสร้าง Order ใหม่ (ถูกแก้ไขเพื่อให้ได้ oderId ทันที)
    public Order createNewOrder(String tableid, String status) {
        Session session = null;
        Order newOrder = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            // 1. ดึงข้อมูล Tables
            Tables table = session.get(Tables.class, tableid);
            
            if (table != null) {
                // 2. สร้าง Order ใหม่
                newOrder = new Order();
                newOrder.setOrderDate(new Date()); // วันที่ปัจจุบัน
                newOrder.setStatus(status);        // เช่น "Open"
                newOrder.setTotalPeice(0.0);       // เริ่มต้นเป็น 0
                newOrder.setTable(table);
                
                // บันทึก Order (Hibernate จะกำหนด ID ให้โดยอัตโนมัติ)
                session.save(newOrder); 
                // newOrder ออบเจกต์ตอนนี้จะมี oderId ที่ถูกกำหนดแล้ว
                session.getTransaction().commit();
            }
            return newOrder; 
        } catch (Exception ex) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            ex.printStackTrace();
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // Method สำหรับสร้าง Order Detail (รายการอาหารเริ่มต้น)
    public boolean createOrderDetail(Order order, MenuFood menuFood, int quantity, double price, String status) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            OrderDetail detail = new OrderDetail();
            detail.setOrders(order);
            detail.setMenufood(menuFood);
            detail.setQuantity(quantity);
            detail.setPriceAtTimeOfOrder(price);
            detail.setStatus(status); // เช่น "In Progress"
            
            session.save(detail);
            session.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            ex.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
    
    // Method สำหรับอัปเดตราคารวมของ Order
    public boolean updateOrderTotalPrice(Order order, double newTotalPeice) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            // ใช้ getOderId() ที่ถูกต้องจาก Order ที่ถูกสร้างแล้ว
            Order existingOrder = session.get(Order.class, order.getOderId());
            
            if (existingOrder != null) {
                existingOrder.setTotalPeice(newTotalPeice);
                session.update(existingOrder);
                session.getTransaction().commit();
                return true;
            }
            return false;
        } catch (Exception ex) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            ex.printStackTrace();
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
    
    /**
     * ดึง Order ที่มีสถานะ 'Open' สำหรับ TableId ที่ระบุ
     */
    public Order getActiveOrderByTableId(String tableid) {
        Session session = null;
        Order activeOrder = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // HQL: ค้นหา Order โดย TableId และสถานะ 'Open'
            Query<Order> query = session.createQuery(
                 "FROM Order WHERE table.tableid = :tableId AND status = 'Open' ORDER BY oderId DESC", Order.class);
            query.setParameter("tableId", tableid);
            query.setMaxResults(1); 
            
            activeOrder = query.uniqueResult();
            
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return activeOrder;
    }
}