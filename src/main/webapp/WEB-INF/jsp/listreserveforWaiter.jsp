<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายการจองโต๊ะลูกค้า</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        /* Style จะคล้ายกับ manageTables.jsp แต่เน้นตาราง */
        * { font-family: 'Kanit', sans-serif; box-sizing: border-box; }
        body { background-color: #f0f4f8; color: #333; padding: 20px; }
        .container { max-width: 1000px; margin: auto; }
        h2 { color: #1a237e; text-align: center; margin-bottom: 30px; font-weight: 600; }
        
        /* เพิ่มสไตล์สำหรับปุ่มกลับหน้าหลัก */
        .btn-gohome {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 18px;
            background-color: #1a237e; /* สีน้ำเงินเข้ม */
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: background-color 0.2s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .btn-gohome:hover {
            background-color: #3949ab;
        }
        
        .reservation-table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            overflow: hidden;
        }
        .reservation-table th, .reservation-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .reservation-table th {
            background-color: #e3f2fd;
            color: #1a237e;
            font-weight: 600;
            font-size: 0.95rem;
        }
        .reservation-table tr:hover { background-color: #f5f5f5; }
        
        .btn-check-in-small {
            background-color: #4caf50;
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: background-color 0.2s;
        }
        .btn-check-in-small:hover { background-color: #388e3c; }
    </style>
</head>
<body>
    <div class="container">
    
        <a href="gohome" class="btn-gohome">
            <i class="fas fa-arrow-left"></i> 🏠 กลับหน้าหลัก
        </a>
        
        <h2><i class="fas fa-calendar-alt"></i> รายการจองโต๊ะที่กำลังใช้งาน</h2>
        
        <c:choose>
            <c:when test="${not empty reservations}">
                <table class="reservation-table">
                    <thead>
                        <tr>
                            <th>รหัสจอง</th>
                            <th>ลูกค้า</th>
                            <th>โต๊ะ</th>
                            <th>จำนวนคน</th>
                            <th>วันที่จอง</th>
                            <th>เวลา</th>
                            <th>สถานะ</th>
                            <th>จัดการ</th>
                        </tr>
                    </thead>
                    <tbody>
	                    <c:forEach var="res" items="${reservations}">
                            <tr>
                                <td>${res.reserveid}</td>
                                <td>${res.customers.cusname}</td>
                                <td>${res.tables.tableid}</td>
                                <td>${res.numberOfGuests}</td>
                                <td><fmt:formatDate value="${res.reservedate}" pattern="d MMM" /></td>
                                <td>${res.reservetime}</td>
                                <%-- 🚩 แก้ไขสีสถานะ: ถ้า Reserved เป็นสีส้ม (#ff9800) ถ้าไม่เป็น Reserved ให้เป็นสีเขียว (#4caf50) --%>
                                <td><span style="color: ${res.status == 'Reserved' ? '#ff9800' : '#4caf50'}; font-weight: 500;">${res.status}</span></td>
                                <td>
                                    <c:if test="${res.status == 'Reserved'}">
                                    
                                        <%-- 🚩 แก้ไข: เปลี่ยนลิงก์ไปยัง Controller ใหม่ และส่ง 2 IDs --%>
                                        <a href="waiterCheckIn?reserveid=${res.reserveid}&tableid=${res.tables.tableid}" 
                                           class="btn-check-in-small"
                                           onclick="return confirm('ยืนยันการ Check-in สำหรับโต๊ะ ${res.tables.tableid} ?')">
                                           Check-In
                                        </a>
                                        
                                    </c:if>
                                    <c:if test="${res.status != 'Reserved'}">
                                        -
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p style="text-align: center; padding: 50px; background-color: #fff; border-radius: 12px;">
                    <i class="fas fa-exclamation-circle"></i> ไม่มีรายการจองโต๊ะที่กำลังใช้งานในขณะนี้
                </p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>