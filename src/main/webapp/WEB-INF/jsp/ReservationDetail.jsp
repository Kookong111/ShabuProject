<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <title>รายละเอียดและยกเลิกการจอง</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Kanit', sans-serif; box-sizing: border-box; }
        body { background: #fafafa; padding: 40px; }
        .container { max-width: 600px; margin: auto; background: #ffffff; padding: 30px; border-radius: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.08); }
        h2 { text-align: center; color: #1a1a1a; margin-bottom: 30px; border-bottom: 2px solid #eee; padding-bottom: 15px; font-weight: 600; }
        .detail-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px dashed #e0e0e0; }
        .detail-row:last-of-type { border-bottom: none; }
        .label { font-weight: 500; color: #444; }
        .value { color: #1a1a1a; }
        .alert-box { padding: 15px; border-radius: 8px; margin-top: 20px; font-weight: 500; text-align: center; }
        .alert-error { background-color: #fce4e4; color: #c62828; border: 1px solid #c62828; }
        .btn-group { display: flex; justify-content: space-between; margin-top: 30px; }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 500; text-align: center; cursor: pointer; transition: background-color 0.3s; }
        .btn-cancel { background-color: #f44336; color: white; border: none; }
        .btn-cancel:hover { background-color: #d32f2f; }
        .btn-back { background-color: #f0f0ff; color: #444; border: 1px solid #ddd; }
        .btn-back:hover { background-color: #e0e0e0; }
        .status-Reserved { color: #ff9800; font-weight: 600; }
        .status-Cancelled { color: #f44336; font-weight: 600; }
    </style>
</head>
<body>
<div class="container">
    <h2>รายละเอียดการจอง</h2>

    <c:if test="${not empty error}">
        <div class="alert-box alert-error">${error}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty reservation}">
            <div class="detail-row"><span class="label">หมายเลขการจอง:</span> <span class="value">${reservation.reserveid}</span></div>
            <div class="detail-row"><span class="label">ชื่อลูกค้า:</span> <span class="value">${reservation.customers.cusname}</span></div>
            <div class="detail-row"><span class="label">หมายเลขโต๊ะ:</span> <span class="value">${reservation.tables.tableid} (ขนาด: ${reservation.tables.capacity} ที่นั่ง)</span></div>
            <div class="detail-row"><span class="label">จำนวนลูกค้า:</span> <span class="value">${reservation.numberOfGuests} ท่าน</span></div>
            <div class="detail-row"><span class="label">วันที่จอง:</span> <span class="value"><fmt:formatDate value="${reservation.reservedate}" pattern="d MMMM yyyy" timeZone="Asia/Bangkok" /></span></div>
            <div class="detail-row"><span class="label">เวลา:</span> <span class="value">${reservation.reservetime} น.</span></div>
            <div class="detail-row"><span class="label">สถานะปัจจุบัน:</span> <span class="value status-${reservation.status}">${reservation.status}</span></div>

            <c:if test="${reservation.status == 'Reserved'}">
                <div class="alert-box alert-error">
                    โปรดยืนยัน! การยกเลิกจะทำให้การจองนี้ถูกลบออกจากระบบ และโต๊ะจะถูกปล่อยให้ว่าง
                </div>
                <div class="btn-group">
                    <a href="myReservess" class="btn btn-back">กลับไปหน้ารายการ</a>
                    <a href="cancelReservationConfirm?reserveid=${reservation.reserveid}&tableid=${reservation.tables.tableid}" 
                       onclick="return confirm('คุณแน่ใจหรือไม่ที่จะยกเลิกการจองนี้?')"
                       class="btn btn-cancel">ยืนยันการยกเลิก</a>
                </div>
            </c:if>
            <c:if test="${reservation.status != 'Reserved'}">
                <div class="alert-box alert-error" style="background-color: #fff8e1; color: #ff6f00;">
                    การจองนี้มีสถานะเป็น **${reservation.status}** จึงไม่สามารถยกเลิกได้
                </div>
                 <div class="btn-group" style="justify-content: center;">
                    <a href="myReservess" class="btn btn-back">กลับไปหน้ารายการ</a>
                </div>
            </c:if>
        </c:when>
        <c:otherwise>
             <div class="alert-box alert-error">
                ไม่พบข้อมูลการจอง
            </div>
             <div class="btn-group" style="justify-content: center;">
                <a href="myReservess" class="btn btn-back">กลับไปหน้ารายการ</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>