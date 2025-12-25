package com.springmvc.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class CashierManager {
    public Employee authenticateUserEmployee(String empUsername, String empPassword) {
        Session session = null;
        Employee user = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();

            user = (Employee) session
                    .createQuery("FROM Employee WHERE empUsername = :empUsername AND empPassword = :empPassword")
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

    public List<Reserve> getAllReserve() {
        List<Reserve> list = new ArrayList<>();
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            list = session.createQuery("FROM Reserve", Reserve.class).list();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public List<OrderDetail> getAllOrder() {
        List<OrderDetail> list = new ArrayList<>();
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            list = session.createQuery("FROM OrderDetail", OrderDetail.class).list();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    // เพิ่มเมธอดนี้เข้าไปในไฟล์ CashierManager.java

    public List<Order> getAllOpenOrders() {
        List<Order> list = new ArrayList<>();
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // --- นี่คือ Query ที่ถูกต้อง ---
            // เราดึงจาก Entity 'Order' ที่ status เป็น 'Open'

            list = session.createQuery("FROM Order WHERE status = 'Open'", Order.class).list();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    /**
     * ดึงรายการ OrderDetail ทั้งหมดที่เชื่อมโยงกับ Order ID ที่กำหนด
     */
    public List<OrderDetail> getOrderDetailsByOrderId(String orderId) {
        List<OrderDetail> list = new ArrayList<>();
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            // เราจะ Query จาก Entity 'OrderDetail'
            // โดยอ้างอิงไปที่ field 'orders' (ที่เป็น Object Order)
            // และเจาะจงไปที่ 'oderId' (ที่เป็น String ID ของ Order)
            list = session.createQuery("FROM OrderDetail WHERE orders.oderId = :orderId", OrderDetail.class)
                    .setParameter("orderId", Integer.parseInt(orderId)) // ควรใช้ Integer ID ตรงนี้
                    .list();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

    public Order getOrderById(String orders) {
        Session session = null;
        try {
            // 1. แปลง String orders เป็น int/Integer (ส่วนที่แก้ไข)
            int orderIdInt = Integer.parseInt(orders);

            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();

            // 2. ใช้ session.get() เพื่อดึงข้อมูลด้วย Primary Key (int)
            Order result = session.get(Order.class, orderIdInt);

            session.getTransaction().commit();

            return result; // คืนค่า Order Object

        } catch (NumberFormatException ex) {
            System.err.println("Error: orderId is not a valid integer: " + orders);
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (session != null && session.getTransaction().isActive()) {
                session.getTransaction().rollback();
            }
            return null;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    // ... (เมธอดอื่น ๆ ที่เหลือ) ...
    public boolean updateOrder(Order r) {
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            Session session = sessionFactory.openSession();
            session.beginTransaction();
            session.update(r);
            session.getTransaction().commit();
            session.close();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public boolean savePayment(Payment payment) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            session.save(payment); // บันทึก Payment
            session.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (session != null) {
                session.getTransaction().rollback();
            }
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    /**
     * อัปเดตข้อมูล Table (ในที่นี้คืออัปเดตสถานะ)
     */
    public boolean updateTable(Tables table) {
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();
            session.beginTransaction();
            session.update(table); // อัปเดต Table
            session.getTransaction().commit();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            if (session != null) {
                session.getTransaction().rollback();
            }
            return false;
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }

    /**
     * ดึงรายการ Payment ที่สำเร็จทั้งหมด (สำหรับดูบิลย้อนหลัง)
     */
    public List<Payment> getAllSuccessfulPayments() {
        List<Payment> list = new ArrayList<>();
        Session session = null;
        try {
            SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
            session = sessionFactory.openSession();

            list = session.createQuery("FROM Payment WHERE paymentStatus = 'succeed'", Payment.class).list();

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            if (session != null) {
                session.close();
            }
        }
        return list;
    }

}