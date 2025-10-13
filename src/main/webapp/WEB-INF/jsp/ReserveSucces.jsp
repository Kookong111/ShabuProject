<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>การจองสำเร็จ - Restaurant</title>
    <!-- ใช้ font awesome สำหรับไอคอน -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            min-height: 100vh;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            max-width: 700px;
            width: 100%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(31, 38, 135, 0.37);
            border: 1px solid rgba(255, 255, 255, 0.18);
            overflow: hidden;
            animation: slideUp 0.6s ease-out;
        }

        @keyframes slideUp {
            from {opacity: 0; transform: translateY(30px);}
            to {opacity: 1; transform: translateY(0);}
        }

        .header {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 40px;
            text-align: center;
        }

        .success-icon {
            font-size: 4em;
            margin-bottom: 20px;
            animation: bounce 1s ease-in-out;
        }

        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
            40% {transform: translateY(-20px);}
            60% {transform: translateY(-10px);}
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            font-weight: 300;
        }

        .header p {
            font-size: 1.2em;
            opacity: 0.9;
        }

        .content {
            padding: 40px;
        }

        .reservation-details {
            background: linear-gradient(135deg, #e8f5e8, #f0f9f0);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            border-left: 5px solid #28a745;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 12px 0;
            border-bottom: 1px solid #e0e0e0;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            font-weight: 600;
            color: #333;
            font-size: 1.1em;
        }

        .detail-value {
            font-size: 1.1em;
            color: #555;
            font-weight: 500;
        }

        .reservation-id {
            background: #28a745;
            color: white;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 25px;
            font-size: 1.2em;
            font-weight: bold;
        }

        .customer-info {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
        }

        .customer-info h3 {
            color: #333;
            margin-bottom: 15px;
            font-size: 1.3em;
        }

        .important-note {
            background: #fff3cd;
            border: 1px solid #ffeeba;
            color: #856404;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
        }

        .important-note h4 {
            margin-bottom: 10px;
            color: #856404;
        }

        .important-note ul {
            margin-left: 20px;
        }

        .important-note li {
            margin-bottom: 5px;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1.1em;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-success {
            background: linear-gradient(135deg, #28a745, #1e7e34);
            color: white;
        }

        .btn-success:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(40, 167, 69, 0.4);
        }

        @media (max-width: 768px) {
            .detail-row {flex-direction: column; align-items: flex-start; gap: 5px;}
            .btn-group {flex-direction: column;}
            .content {padding: 25px;}
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="success-icon">✅</div>
            <h1>จองโต๊ะสำเร็จ!</h1>
            <p>ขอบคุณที่ใช้บริการร้านของเรา</p>
        </div>

        <div class="content">
            <div class="reservation-id">
                หมายเลขการจอง: #${reservation.reserveid}
            </div>

            <div class="customer-info">
                <h3>👤 ข้อมูลผู้จอง</h3>
                <div class="detail-row">
                    <span class="detail-label">ชื่อผู้จอง:</span>
                    <span class="detail-value">${reservation.customers.cusname}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">เบอร์โทรศัพท์:</span>
                    <span class="detail-value">${reservation.customers.phonenumber}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">อีเมล:</span>
                    <span class="detail-value">${reservation.customers.gmail}</span>
                </div>
            </div>

            <div class="reservation-details">
                <h3 style="color: #28a745; margin-bottom: 20px; text-align: center;">📋 รายละเอียดการจอง</h3>
                <div class="detail-row">
                    <span class="detail-label">🏷️ หมายเลขโต๊ะ:</span>
                    <span class="detail-value">${reservation.tables.tableid}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">📅 วันที่จอง:</span>
                    <span class="detail-value">
                        <fmt:formatDate value="${reservation.reservedate}" pattern="dd MMMM yyyy" var="formattedDate"/>
                        ${formattedDate}
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">🕐 เวลาจอง:</span>
                    <span class="detail-value">${reservation.reservetime} น.</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">👥 จำนวนผู้ใช้บริการ:</span>
                    <span class="detail-value">${reservation.numberOfGuests} คน</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">🪑 ความจุโต๊ะ:</span>
                    <span class="detail-value">${reservation.tables.capacity} ที่นั่ง</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">📊 สถานะ:</span>
                    <span class="detail-value" style="color: #28a745; font-weight: bold;">${reservation.status}</span>
                </div>
            </div>

            <div class="important-note">
                <h4>⚠️ ข้อมูลสำคัญ</h4>
                <ul>
                    <li>กรุณามาถึงร้านก่อนเวลาจอง 15 นาที</li>
                    <li>หากมาสายเกิน 20 นาที การจองอาจถูกยกเลิก</li>
                </ul>
            </div>

            <!-- ปุ่ม Action -->
            <div class="btn-group">
                <a href="listTable" class="btn btn-success">
                    <i class="fas fa-home"></i> กลับหน้าหลัก
                </a>
            </div>
        </div>
    </div>
</body>
</html>
