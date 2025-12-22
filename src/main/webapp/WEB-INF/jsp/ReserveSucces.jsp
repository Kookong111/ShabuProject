<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>การจองสำเร็จ - Restaurant</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans Thai', 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            padding: 40px 20px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            max-width: 680px;
            width: 100%;
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1);
        }

        @keyframes fadeInUp {
            from {opacity: 0; transform: translateY(40px);}
            to {opacity: 1; transform: translateY(0);}
        }

        .header {
            background: #fff;
            padding: 50px 40px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .header::before {
            display: none;
        }

        @keyframes rotate {
            from {transform: rotate(0deg);}
            to {transform: rotate(360deg);}
        }

        .success-icon {
            position: relative;
            z-index: 1;
            width: 100px;
            height: 100px;
            margin: 0 auto 20px;
            background: #22c55e;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            animation: scaleIn 0.6s cubic-bezier(0.16, 1, 0.3, 1) 0.3s both;
            box-shadow: 0 2px 12px rgba(34,197,94,0.10);
        }

        @keyframes scaleIn {
            from {transform: scale(0); opacity: 0;}
            to {transform: scale(1); opacity: 1;}
        }

        .success-icon i {
            font-size: 50px;
            color: #fff;
        }

        .header h1 {
            position: relative;
            z-index: 1;
            font-size: 2.2em;
            color: #222;
            margin-bottom: 12px;
            font-weight: 600;
            letter-spacing: -0.5px;
        }

        .header p {
            position: relative;
            z-index: 1;
            font-size: 1.05em;
            color: #222;
            font-weight: 300;
        }

        .content {
            padding: 45px 40px 50px;
        }

        .reservation-id-card {
            background: #f8f9fa;
            border-radius: 16px;
            border: 1px solid #e9ecef;
            padding: 24px;
            text-align: center;
            margin-bottom: 35px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }

        .reservation-id-card::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            animation: shine 3s infinite;
        }

        @keyframes shine {
            0% {transform: translateX(-100%) translateY(-100%) rotate(45deg);}
            100% {transform: translateX(100%) translateY(100%) rotate(45deg);}
        }

        .reservation-id-card .label {
            font-size: 0.9em;
            color: #6c757d;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 500;
        }

        .reservation-id-card .id-number {
            font-size: 2em;
            color: #222;
            font-weight: 700;
            letter-spacing: 2px;
        }

        .section-card {
            background: #f8f9fa;
            border-radius: 16px;
            padding: 28px;
            margin-bottom: 24px;
            border: 1px solid #e9ecef;
            transition: all 0.3s ease;
        }

        .section-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.06);
        }

        .section-card h3 {
            color: #2c3e50;
            margin-bottom: 20px;
            font-size: 1.15em;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .section-card h3 i {
            color: #667eea;
            font-size: 1.2em;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .detail-row:last-child {
            border-bottom: none;
            padding-bottom: 0;
        }

        .detail-label {
            font-size: 0.95em;
            color: #6c757d;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .detail-value {
            font-size: 0.95em;
            color: #2c3e50;
            font-weight: 600;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 16px;
            background: linear-gradient(135deg, #ff9f43 0%, #ee5a24 100%);
            color: white;
            border-radius: 20px;
            font-size: 0.9em;
            font-weight: 600;
        }

        .info-box {
            background: linear-gradient(135deg, #fff9e6 0%, #ffeaa7 100%);
            border-left: 4px solid #fdcb6e;
            border-radius: 12px;
            padding: 24px;
            margin-bottom: 30px;
        }

        .info-box h4 {
            color: #d63031;
            margin-bottom: 14px;
            font-size: 1.05em;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-box ul {
            list-style: none;
            padding: 0;
        }

        .info-box li {
            color: #2d3436;
            margin-bottom: 10px;
            padding-left: 24px;
            position: relative;
            line-height: 1.6;
        }

        .info-box li::before {
            content: '•';
            position: absolute;
            left: 8px;
            color: #fdcb6e;
            font-weight: bold;
            font-size: 1.3em;
        }

        .btn-container {
            display: flex;
            justify-content: center;
            margin-top: 35px;
        }

        .btn-home {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 16px 40px;
            background: #f8f9fa;
            color: #222;
            text-decoration: none;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.05em;
            transition: all 0.3s ease;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            border: 1px solid #e0e0e0;
        }

        .btn-home:hover {
            transform: translateY(-3px);
            background: #ececec;
            color: #111;
            box-shadow: 0 4px 16px rgba(0,0,0,0.08);
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, #dee2e6, transparent);
            margin: 30px 0;
        }

        @media (max-width: 768px) {
            body {padding: 20px 15px;}
            .container {border-radius: 20px;}
            .header {padding: 40px 25px;}
            .header h1 {font-size: 1.8em;}
            .content {padding: 30px 25px 35px;}
            .section-card {padding: 20px;}
            .detail-row {
                flex-direction: column;
                align-items: flex-start;
                gap: 6px;
                padding: 12px 0;
            }
            .reservation-id-card .id-number {font-size: 1.6em;}
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="success-icon">
                <i class="fas fa-check"></i>
            </div>
            <h1>จองโต๊ะสำเร็จ</h1>
            <p>ขอบคุณที่ไว้วางใจเลือกใช้บริการร้านของเรา</p>
        </div>

        <div class="content">
            <div class="reservation-id-card">
                <div class="label">หมายเลขการจอง</div>
                <div class="id-number">#${reservation.reserveid}</div>
            </div>

            <div class="section-card">
                <h3><i class="fas fa-user"></i> ข้อมูลผู้จอง</h3>
                <div class="detail-row">
                    <span class="detail-label">ชื่อผู้จอง</span>
                    <span class="detail-value">${reservation.customers.cusname}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">เบอร์โทรศัพท์</span>
                    <span class="detail-value">${reservation.customers.phonenumber}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">อีเมล</span>
                    <span class="detail-value">${reservation.customers.gmail}</span>
                </div>
            </div>

            <div class="section-card">
                <h3><i class="fas fa-clipboard-list"></i> รายละเอียดการจอง</h3>
                <div class="detail-row">
                    <span class="detail-label">หมายเลขโต๊ะ</span>
                    <span class="detail-value">โต๊ะ ${reservation.tables.tableid}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">วันที่จอง</span>
                    <span class="detail-value">
                        <fmt:formatDate value="${reservation.reservedate}" pattern="dd MMMM yyyy" var="formattedDate"/>
                        ${formattedDate}
                    </span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">เวลาจอง</span>
                    <span class="detail-value">${reservation.reservetime} น.</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">จำนวนผู้ใช้บริการ</span>
                    <span class="detail-value">${reservation.numberOfGuests} คน</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">ความจุโต๊ะ</span>
                    <span class="detail-value">${reservation.tables.capacity} ที่นั่ง</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">สถานะ</span>
                    <span class="status-badge">
                        <i class="fas fa-check-circle"></i>
                        <c:choose>
                            <c:when test="${reservation.status eq 'Reserved'}">จองแล้ว</c:when>
                            <c:otherwise>${reservation.status}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>

            <div class="info-box">
                <h4><i class="fas fa-info-circle"></i> ข้อมูลสำคัญ</h4>
                <ul>
                    <li>กรุณามาถึงร้านก่อนเวลาจอง 15 นาที</li>
                    <li>หากมาสายเกิน 20 นาที การจองอาจถูกยกเลิก</li>
                </ul>
            </div>

            <div class="btn-container">
                <a href="listTable" class="btn-home">
                    <i class="fas fa-home"></i>
                    กลับหน้าหลัก
                </a>
            </div>
        </div>
    </div>
</body>
</html>