<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายการบิลย้อนหลัง - ShaBu Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Kanit', sans-serif;
        }

        :root {
            --primary-color: #5d00a8; /* ม่วงเข้ม */
            --secondary-color: #f7f3ff; /* ม่วงอ่อน */
            --text-color: #333;
            --white: #ffffff;
            --shadow-light: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        body {
            background-color: var(--secondary-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 30px;
            background: var(--white);
            border-radius: 15px;
            box-shadow: var(--shadow-light);
        }

        .header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 3px solid var(--secondary-color);
        }

        .header h1 {
            font-size: 2.2rem;
            color: var(--primary-color);
            margin-bottom: 10px;
            font-weight: 700;
        }

        .bills-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        .bills-table th, .bills-table td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .bills-table th {
            background-color: var(--primary-color);
            color: var(--white);
            font-weight: 600;
        }

        .bills-table tr:hover {
            background-color: var(--secondary-color);
        }

        .no-bills {
            text-align: center;
            color: #666;
            font-size: 1.2rem;
            margin-top: 50px;
        }

        .back-btn {
            background: #e0e0e0;
            color: var(--text-color);
            padding: 12px 25px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.3s;
            display: inline-block;
            margin-top: 30px;
        }

        .back-btn:hover {
            background: #c0c0c0;
        }

        .error-message {
            color: #d9534f;
            text-align: center;
            font-size: 1.1rem;
            margin-top: 20px;
        }

        .view-slip-btn {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
        }

        .view-slip-btn:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-history"></i> รายการบิลย้อนหลัง</h1>
            <p>ประวัติการชำระเงินที่สำเร็จแล้ว</p>
        </div>

        <c:if test="${not empty error_message}">
            <div class="error-message">
                <i class="fas fa-exclamation-triangle"></i> ${error_message}
            </div>
        </c:if>

        <c:if test="${not empty pastBills}">
            <table class="bills-table">
                <thead>
                    <tr>
                        <th>รหัสบิล</th>
                        <th>วันที่ชำระ</th>
                        <th>จำนวนเงิน</th>
                        <th>พนักงาน</th>
                        <th>ออเดอร์</th>
                        <th>ดูสลิป</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="bill" items="${pastBills}">
                        <tr>
                            <td>${bill.paymentId}</td>
                            <td><fmt:formatDate value="${bill.paymentDate}" pattern="dd/MM/yyyy HH:mm" timeZone="Asia/Bangkok"/></td>
                            <td><fmt:formatNumber value="${bill.totalPrice}" pattern="#,##0.00"/> บาท</td>
                            <td>${bill.employees.empname}</td>
                            <td>ออเดอร์ #${bill.orders.oderId} (โต๊ะ ${bill.orders.table.tableid})</td>
                            <td><a href="checkbill-page?orderId=${bill.orders.oderId}&amp;from=manager" class="view-slip-btn">ดูสลิป</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty pastBills and empty error_message}">
            <div class="no-bills">
                <i class="fas fa-receipt"></i><br>
                ยังไม่มีรายการบิลย้อนหลัง
            </div>
        </c:if>

        <div style="text-align: center;">
            <a href="backToHomeManager" class="back-btn"><i class="fas fa-arrow-left"></i> กลับไปหน้าแรก</a>
        </div>
    </div>
</body>
</html>