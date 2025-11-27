package com.springmvc.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class WaiterManager {
    public Employee authenticateWaiter(String empUsername, String empPassword) {
        Session session = null;
        Employee user = null; 
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();

            // ค้นหาผู้ใช้จากฐานข้อมูล
            user = (Employee) session.createQuery(
                    "FROM Employee WHERE empUsername = :empUsername AND empPassword = :empPassword AND empUsername LIKE 'WAT%'")
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
        return user;
    }

    // 1. ดึงข้อมูลโต๊ะทั้งหมด
    public List<Tables> getAllTables() {
        Session session = null;
        List<Tables> tableList = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            String hql = "FROM Tables";
            Query<Tables> query = session.createQuery(hql, Tables.class);
            tableList = query.list();
            
            session.getTransaction().commit();
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
        return tableList;
    }

    // 2. ดึงรายการจองที่ยัง Active (Reserved)
    public List<Reserve> getAllActiveReservations() {
        Session session = null;
        List<Reserve> reservations = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            // ใช้ FETCH JOIN เพื่อดึงข้อมูลลูกค้าและโต๊ะมาพร้อมกัน
            String hql = "FROM Reserve r JOIN FETCH r.customers JOIN FETCH r.tables WHERE r.status = 'Reserved' OR r.status = 'CheckedIn' ORDER BY r.reservedate ASC, r.reservetime ASC";
            
            Query<Reserve> query = session.createQuery(hql, Reserve.class);
            reservations = query.list();
            
            session.getTransaction().commit();
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
        return reservations;
    }

    // 3. อัปเดตสถานะโต๊ะ
    public boolean updateTableStatus(String tableid, String newStatus) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            Tables table = session.get(Tables.class, tableid);
            if (table != null) {
                table.setStatus(newStatus);
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
    
    // 4. ดึงข้อมูลโต๊ะเดียว
    public Tables getTableById(String tableid) {
        Session session = null;
        Tables table = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            table = session.get(Tables.class, tableid);
            
            session.getTransaction().commit();
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
        return table;
    }

    // 5. ดึงรายการ Order Detail ที่สถานะยังไม่เสร็จสิ้น (Pending หรือ In Progress)
    /**
     * ดึงรายการ OrderDetail ทั้งหมดที่สถานะเป็น 'Pending' หรือ 'In Progress' 
     * สำหรับการจัดการและจัดกลุ่มใน Controller
     * @return List<OrderDetail> รายการอาหารที่ต้องจัดการ
     */
    public List<OrderDetail> getActiveOrderDetails() {
        Session session = null;
        List<OrderDetail> details = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
           
            String hql = "FROM OrderDetail od JOIN FETCH od.orders o JOIN FETCH o.table t JOIN FETCH od.menufood mf JOIN FETCH mf.foodtype " +
                         "WHERE o.status = 'Open' " + // 
                         "ORDER BY o.oderId ASC, od.odermenuId ASC"; 
            
            Query<OrderDetail> query = session.createQuery(hql, OrderDetail.class);
            details = query.list();
            
            session.getTransaction().commit();
            return details;

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
        return null;
    }

    // 6. อัปเดตสถานะของ OrderDetail (แบบธรรมดา, ไม่มี Concurrency Check)
    /**
     * อัปเดตสถานะของ OrderDetail ตาม ID
     * @param odermenuId ID ของรายการอาหารในบิล
     * @param newStatus สถานะใหม่ (เช่น 'In Progress', 'Served')
     * @return true หากอัปเดตสำเร็จ
     */
    public boolean updateOrderDetailStatus(int odermenuId, String newStatus) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            OrderDetail detail = session.get(OrderDetail.class, odermenuId);
            
            if (detail != null) {
                detail.setStatus(newStatus);
                session.update(detail);
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
 // ใน WaiterManager.java

    /**
     * อัปเดตสถานะของ OrderDetail ทั้งหมดใน Order ID ที่กำหนด
     * จะข้ามรายการที่มีชื่อเมนู 'บุฟเฟต์'
     * @param orderId ID ของ Order หลัก
     * @param oldStatus สถานะปัจจุบันที่จะถูกเปลี่ยน
     * @param newStatus สถานะใหม่
     * @return จำนวนรายการที่ถูกอัปเดต
     */
    public int updateOrderDetailsStatusByOrderId(int orderId, String oldStatus, String newStatus) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();

            @SuppressWarnings("unchecked")
            List<Integer> detailIdsToUpdate = session.createQuery(
                "SELECT od.odermenuId FROM OrderDetail od JOIN od.menufood mf " +
                "WHERE od.orders.oderId = :orderId AND od.status = :oldStatus " +
                "AND LOWER(mf.foodname) NOT LIKE '%บุฟเฟต์%'", Integer.class) // เพิ่มเงื่อนไขยกเว้น 'บุฟเฟต์'
                .setParameter("orderId", orderId)
                .setParameter("oldStatus", oldStatus)
                .list();

            int updatedCount = 0;
            if (!detailIdsToUpdate.isEmpty()) {
                // ทำการอัปเดตเฉพาะรายการ ID ที่ถูกกรองแล้ว
                updatedCount = session.createQuery(
                    "UPDATE OrderDetail SET status = :newStatus WHERE odermenuId IN (:ids)")
                    .setParameter("newStatus", newStatus)
                    .setParameter("ids", detailIdsToUpdate)
                    .executeUpdate();
            }

            session.getTransaction().commit();
            return updatedCount;
        } catch (Exception ex) {
            if (session != null && session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            ex.printStackTrace();
            return 0;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}