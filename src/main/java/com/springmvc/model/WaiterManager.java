package com.springmvc.model;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

public class WaiterManager {
    public Employee authenticateWaiter(String empUsername, String empPassword) {
        Session session = null;
        Employee user = null; // เพิ่มการ return user object ถ้าเจอข้อมูลที่ตรงกัน
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
        return user;  // คืนค่า user object ถ้าพบผู้ใช้
    }

    // 1. ดึงข้อมูลโต๊ะทั้งหมด (สำหรับหน้าจอจัดการโต๊ะ)
        /**
         * ดึงข้อมูลโต๊ะทั้งหมดในร้าน
         * @return List<Tables> รายการโต๊ะทั้งหมด
         */
        public List<Tables> getAllTables() {
            Session session = null;
            List<Tables> tableList = null;
            try {
                SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
                session = sessionFactory.openSession();
                session.beginTransaction();
                
                // HQL: ดึงข้อมูลจากคลาส Tables
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
        /**
         * ดึงรายการจองที่สถานะเป็น 'Reserved' สำหรับพนักงานเสิร์ฟ
         * @return List<Reserve> รายการจองที่ยัง Active
         */
        public List<Reserve> getAllActiveReservations() {
            Session session = null;
            List<Reserve> reservations = null;
            try {
                SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
                session = sessionFactory.openSession();
                session.beginTransaction();
                
                // ใช้ FETCH JOIN เพื่อดึงข้อมูลลูกค้าและโต๊ะมาพร้อมกัน (แก้ปัญหา Lazy Loading ใน JSP)
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
    
        // 3. อัปเดตสถานะโต๊ะ (เช่น เปิดโต๊ะ/ทำความสะอาด/ย้ายสถานะจองเป็นใช้งาน)
        /**
         * อัปเดตสถานะของโต๊ะที่ระบุ
         * @param tableid รหัสโต๊ะ
         * @param newStatus สถานะใหม่ (เช่น 'Occupied', 'Free', 'Cleaning')
         * @return true หากอัปเดตสำเร็จ
         */
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
        
     // 4. ดึงข้อมูลโต๊ะเดียว (สำหรับหน้าจอเปิดโต๊ะ) (เมธอดที่เพิ่มเข้ามา)
        /**
         * ดึงข้อมูลโต๊ะตาม ID
         * @param tableid รหัสโต๊ะ
         * @return Tables object หรือ null ถ้าไม่พบ
         */
        public Tables getTableById(String tableid) {
            Session session = null;
            Tables table = null;
            try {
                SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
                session = sessionFactory.openSession();
                session.beginTransaction();
                
                // ใช้ session.get() เพื่อดึงข้อมูลด้วย Primary Key
                table = session.get(Tables.class, tableid);
                
                session.getTransaction().commit();
            } catch (Exception ex) {
                if (session != null && session.getTransaction() != null) {
                    session.getTransaction().rollback();
                }
                ex.printStackTrace();
                    session.close();
                }
            
            return table;
        }
}
