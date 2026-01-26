<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <title>รายละเอียดและยกเลิกการจอง</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Kanit:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-body: #fff;
            --bg-card: #fff;
            --primary: #4f46e5;
            --primary-hover: #4338ca;
            --text-main: #1a202c;
            --text-muted: #718096;
            --border-color: #edf2f7;
            --danger: #ef4444;
            --danger-hover: #d32f2f;
            --warn: #f59e0b;
        }
        body {
            font-family: 'Plus Jakarta Sans', 'Kanit', sans-serif;
            margin: 0;
            padding: 0;
            background: var(--bg-body);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            max-width: 440px;
            width: 90%;
            background: var(--bg-card);
            padding: 40px 30px;
            border-radius: 24px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.04), 0 8px 10px -6px rgba(0, 0, 0, 0.04);
            position: relative;
            border: 2px solid #222;
            transition: transform 0.3s ease;
        }
        h2 {
            text-align: center;
            color: var(--text-main);
            font-weight: 700;
            margin: 20px 0 35px;
            font-size: 1.6rem;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 10px;
        }
        .detail-list {
            margin-bottom: 24px;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px 24px;
        }
        .detail-item {
            margin-bottom: 0;
        }
        .detail-item label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-muted);
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }
        .detail-value {
            padding: 12px 16px;
            border-radius: 14px;
            background-color: #f9fafb;
            font-size: 1rem;
            color: var(--text-main);
            font-weight: 500;
            border: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .status-Reserved { color: var(--warn); font-weight: 600; }
        .status-Cancelled { color: var(--danger); font-weight: 600; }
        .alert-box {
            padding: 15px;
            border-radius: 12px;
            margin-top: 20px;
            font-weight: 500;
            text-align: center;
            background: #fef2f2;
            color: var(--danger);
            border: 1px solid #fee2e2;
            font-size: 0.95rem;
        }
        .alert-warn {
            background: #fff8e1;
            color: #ff6f00;
            border: 1px solid #ffe082;
        }
        .btn-group {
            display: flex;
            gap: 12px;
            margin-top: 30px;
            justify-content: center;
        }
        .btn {
            flex: 1;
            padding: 14px;
            border-radius: 14px;
            font-family: 'Kanit', sans-serif;
            font-weight: 700;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s;
        }
        .btn-cancel {
            background: var(--danger);
            color: #fff;
            border: none;
        }
        .btn-cancel:hover {
            background: var(--danger-hover);
            transform: translateY(-2px);
        }
        .btn-back {
            background: var(--white);
            color: var(--text-main);
            border: 1px solid var(--border-color);
        }
        .btn-back:hover {
            background: #f9fafb;
        }
        @media (max-width: 700px) {
            .detail-list {
                grid-template-columns: 1fr;
            }
        }
        @media (max-width: 480px) {
            .container {
                padding: 35px 20px;
                width: 85%;
            }
            h2 { font-size: 1.4rem; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-calendar-check"></i> รายละเอียดการจอง</h2>
        <c:if test="${not empty error}">
            <div class="alert-box">${error}</div>
        </c:if>
        <c:choose>
            <c:when test="${not empty reservation}">
                <div class="detail-list">
                    <div class="detail-item">
                        <label>หมายเลขการจอง</label>
                        <div class="detail-value">${reservation.reserveid}</div>
                    </div>
                    <div class="detail-item">
                        <label>ชื่อลูกค้า</label>
                        <div class="detail-value">${reservation.customers.cusname}</div>
                    </div>
                    <div class="detail-item">
                        <label>หมายเลขโต๊ะ</label>
                        <div class="detail-value">${reservation.tables.tableid} (ขนาด: ${reservation.tables.capacity} ที่นั่ง)</div>
                    </div>
                    <div class="detail-item">
                        <label>จำนวนลูกค้า</label>
                        <div class="detail-value">${reservation.numberOfGuests} ท่าน</div>
                    </div>
                    <div class="detail-item">
                        <label>วันที่จอง</label>
                        <div class="detail-value"><fmt:formatDate value="${reservation.reservedate}" pattern="d MMMM yyyy" timeZone="Asia/Bangkok" /></div>
                    </div>
                    <div class="detail-item">
                        <label>เวลา</label>
                        <div class="detail-value">${reservation.reservetime} น.</div>
                    </div>
                    <div class="detail-item">
                        <label>สถานะปัจจุบัน</label>
                        <div class="detail-value status-${reservation.status}">${reservation.status}</div>
                    </div>
                </div>
                <c:if test="${reservation.status == 'Reserved'}">
                    <div class="alert-box">
                        <i class="fas fa-exclamation-triangle"></i> โปรดยืนยัน! การยกเลิกจะทำให้การจองนี้ถูกลบออกจากระบบ และโต๊ะจะถูกปล่อยให้ว่าง
                    </div>
                    <div class="btn-group">
                        <a href="myReservess" class="btn btn-back"><i class="fas fa-arrow-left"></i> กลับไปหน้ารายการ</a>
                        <a href="cancelReservationConfirm?reserveid=${reservation.reserveid}&tableid=${reservation.tables.tableid}"
                           onclick="return confirm('คุณแน่ใจหรือไม่ที่จะยกเลิกการจองนี้?')"
                           class="btn btn-cancel"><i class="fas fa-times-circle"></i> ยืนยันการยกเลิก</a>
                    </div>
                </c:if>
                <c:if test="${reservation.status != 'Reserved'}">
                    <div class="alert-box alert-warn">
                        <i class="fas fa-info-circle"></i> การจองนี้มีสถานะเป็น <b>${reservation.status}</b> จึงไม่สามารถยกเลิกได้
                    </div>
                    <div class="btn-group">
                        <a href="myReservess" class="btn btn-back"><i class="fas fa-arrow-left"></i> กลับไปหน้ารายการ</a>
                    </div>
                </c:if>
            </c:when>
            <c:otherwise>
                <div class="alert-box">
                    <i class="fas fa-exclamation-circle"></i> ไม่พบข้อมูลการจอง
                </div>
                <div class="btn-group">
                    <a href="myReservess" class="btn btn-back"><i class="fas fa-arrow-left"></i> กลับไปหน้ารายการ</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>