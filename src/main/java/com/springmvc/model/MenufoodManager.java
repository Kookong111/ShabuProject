package com.springmvc.model;

import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class MenufoodManager {
	// Method สำหรับดึงข้อมูลผู้ใช้ทั้งหมดจากตาราง Register
	public List<MenuFood> getAllMenufood() {
		List<MenuFood> menulist = new ArrayList<>();
		Session session = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			session = sessionFactory.openSession();

			menulist = session.createQuery("FROM MenuFood", MenuFood.class).list();
			System.out.println("Number of menu foods retrieved: " + menulist.size());

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (session != null) {
				session.close(); // Ensure the session is closed even on exception
			}
		}
		return menulist;
	}

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

	// (เมธอด getAllListTable เดิม)
	public List<Tables> getAllListTable() {
		List<Tables> tablelist = new ArrayList<>();
		Session session = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			session = sessionFactory.openSession();

			tablelist = session.createQuery("FROM Tables", Tables.class).list();
			System.out.println("Number of tables retrieved: " + tablelist.size());

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (session != null) {
				session.close(); // Ensure the session is closed even on exception
			}
		}
		return tablelist;
	}

	public String getTableStatusWithTimeCheck(String tableId) {
		Session session = null;
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			session = sessionFactory.openSession();

			// 1. ถ้าโต๊ะมีลูกค้าเดินเข้าไปนั่งแล้ว (Occupied) ให้เป็นสีแดงทันที
			Tables table = session.get(Tables.class, tableId);
			if ("Occupied".equals(table.getStatus()))
				return "Occupied";

			// 2. เช็คการจอง: ถ้ามีการจองวันนี้ และ "เวลาปัจจุบัน" อยู่ก่อนเวลาจองไม่เกิน 60
			// นาที
			// ให้แสดงเป็นสถานะ "Reserved" (สีเหลือง)
			LocalTime now = LocalTime.now(ZoneId.of("Asia/Bangkok"));
			String currentTime = now.format(DateTimeFormatter.ofPattern("HH:mm"));
			String bufferTime = now.plusMinutes(60).format(DateTimeFormatter.ofPattern("HH:mm"));

			String hql = "FROM Reserve WHERE tables.tableid = :tableId " +
					"AND reservedate = CURRENT_DATE " +
					"AND reservetime BETWEEN :now AND :buffer " +
					"AND status = 'Reserved'";

			List<Reserve> list = session.createQuery(hql, Reserve.class)
					.setParameter("tableId", tableId)
					.setParameter("now", currentTime)
					.setParameter("buffer", bufferTime)
					.list();

			if (!list.isEmpty())
				return "Reserved"; // พบการจองในอีก 1 ชม. ข้างหน้า

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return "Free"; // ถ้าไม่มีเงื่อนไขข้างบน ให้เป็นสีเขียว
	}
}