package com.springmvc.model;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import java.util.Date;
import java.util.List;

public class ReserveManager {
    
    // Method สำหรับบันทึกข้อมูลการจองใหม่
    public boolean insertReservation(Reserve reservation) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            // บันทึกข้อมูลการจองลงในฐานข้อมูล
            session.save(reservation);
            session.getTransaction().commit();
            return true;
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
    
    public boolean deleteReservation(Integer reserveid) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            Reserve reservation = (Reserve) session.get(Reserve.class, reserveid);
            if (reservation != null) {
                session.delete(reservation);
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
    
    // Method สำหรับตรวจสอบว่าโต๊ะว่างในวันและเวลาที่ต้องการหรือไม่
    public boolean isTableAvailable(String tableid, Date reservedate, String reservetime) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            // ค้นหาการจองที่ตรงกับโต๊ะ วันที่ และเวลาที่ต้องการ
            String hql = "FROM Reserve WHERE tableid = :tableid AND reservedate = :reservedate " +
                        "AND reservetime = :reservetime AND status != 'Cancelled'";
            Query query = session.createQuery(hql);
            query.setParameter("tableid", tableid);
            query.setParameter("reservedate", reservedate);
            query.setParameter("reservetime", reservetime);
            
            List<Reserve> existingReservations = query.list();
            session.getTransaction().commit();
            
            // ถ้าไม่มีการจองที่ซ้ำกัน แสดงว่าโต๊ะว่าง
            return existingReservations.isEmpty();
            
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
    
    // Method สำหรับดึงข้อมูลการจองของลูกค้าคนหนึ่ง

    public List<Reserve> getReservationsByCustomerId(Integer cusid) {
        Session session = null;
        List<Reserve> reservations = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            // HQL ที่ถูกต้องตามหลักการ ORM: 
            // - FROM Reserve r : อ้างถึง Model Class ชื่อ Reserve
            // - r.customers.cusId : เข้าถึง ID ของลูกค้าผ่าน Object Customer ที่ Map ไว้ใน Reserve
            String hql = "FROM Reserve r WHERE r.customers.cusId = :cusid ORDER BY r.reservedate DESC, r.reservetime DESC";
            
            // ใช้ generic type <Reserve> เพื่อให้ถูกต้อง
            Query<Reserve> query = session.createQuery(hql, Reserve.class);
            query.setParameter("cusid", cusid);
            
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
    // Method สำหรับอัปเดตสถานะการจอง
    public boolean updateReservationStatus(Integer reserveid, String status) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            Reserve reservation = (Reserve) session.get(Reserve.class, reserveid);
            if (reservation != null) {
                reservation.setStatus(status);
                session.update(reservation);
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
    
    // Method สำหรับดึงข้อมูลการจองตาม ID
    public Reserve getReservationById(Integer reserveid) {
        Session session = null;
        Reserve reservation = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            reservation = (Reserve) session.get(Reserve.class, reserveid);
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
        return reservation;
    }
    
 // Method สำหรับดึงข้อมูลโต๊ะตาม ID
    public Tables getTableById(String tableid) {
        Session session = null;
        Tables table = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            table = (Tables) session.get(Tables.class, tableid);
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
    
    // Method สำหรับดึงข้อมูลลูกค้าตาม ID
    public Customer getCustomerById(Integer cusid) {
        Session session = null;
        Customer customer = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            customer = (Customer) session.get(Customer.class, cusid);
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
        return customer;
    }
    
    /**
     * ดึงข้อมูลการจองล่าสุดที่สถานะไม่ใช่ Cancelled หรือ Completed (Active)
     */
    public Reserve getReservationByActiveStatus(Integer cusid) {
        Session session = null;
        Reserve reservation = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            
            // HQL: ค้นหาการจองล่าสุดที่สถานะ NOT IN ('Cancelled', 'Completed')
            String hql = "FROM Reserve r WHERE r.customers.cusId = :cusid AND r.status NOT IN ('Cancelled', 'Completed') ORDER BY r.reservedate DESC, r.reservetime DESC";
            
            Query<Reserve> query = session.createQuery(hql, Reserve.class);
            query.setParameter("cusid", cusid);
            query.setMaxResults(1);
            
            reservation = query.uniqueResult();
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
        return reservation;
    }
    
    /**
     * ดึงรายการ OrderDetail ทั้งหมดที่เชื่อมโยงกับ Order ID ที่กำหนด
     */
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        Session session = null;
        List<OrderDetail> orderDetails = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            
            // HQL: ค้นหา OrderDetail โดยอ้างถึง oderId ของ Order
            Query<OrderDetail> query = session.createQuery(
                 "FROM OrderDetail WHERE orders.oderId = :orderId ORDER BY odermenuId DESC", OrderDetail.class);
            query.setParameter("orderId", orderId);
            
            orderDetails = query.list();
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return orderDetails;
    }

    
	public boolean cancelReservation(int int1) {
		// TODO Auto-generated method stub
		return false;
	}
}