<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>การจองของฉัน - ShaBu Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-red: #d32f2f;
            --warm-red: #e57373;
            --soft-cream: #faf8f5;
            --warm-white: #ffffff;
            --charcoal: #2c2c2c;
            --soft-gray: #757575;
            --light-gray: #f5f5f5;
            --shadow-soft: 0 4px 20px rgba(0, 0, 0, 0.08);
            --shadow-medium: 0 8px 30px rgba(0, 0, 0, 0.12);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans Thai', 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--charcoal);
            background: linear-gradient(135deg, var(--soft-cream), rgba(211, 47, 47, 0.05));
            min-height: 100vh;
        }

        /* Navigation */
        nav {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 20px 5%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(211, 47, 47, 0.1);
            z-index: 1000;
            transition: var(--transition);
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            font-size: 32px;
            font-weight: 700;
            color: var(--primary-red);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logo::before {
            content: "🍲";
            font-size: 28px;
        }

        /* Main Content */
        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 120px 20px 60px;
        }

        .page-header {
            text-align: center;
            margin-bottom: 50px;
        }

        .page-title {
            font-size: 3rem;
            font-weight: 700;
            color: var(--charcoal);
            margin-bottom: 16px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .page-subtitle {
            font-size: 1.2rem;
            color: var(--soft-gray);
        }

        .user-welcome {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: var(--shadow-soft);
            margin-bottom: 40px;
            border-left: 5px solid var(--primary-red);
        }

        .user-welcome h3 {
            color: var(--charcoal);
            margin-bottom: 10px;
            font-size: 1.5rem;
        }

        .user-welcome p {
            color: var(--soft-gray);
            font-size: 1.1rem;
        }

        /* Reservations Grid */
        .reservations-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .reservation-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: var(--shadow-soft);
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .reservation-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-red), var(--warm-red));
        }

        .reservation-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-medium);
        }

        .reservation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .reservation-id {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--primary-red);
        }

        .status-badge {
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-confirm {
            background: #d4edda;
            color: #155724;
        }

        .status-pending {
            background: #fff3cd;
            color: #856404;
        }

        .status-cancelled {
            background: #f8d7da;
            color: #721c24;
        }

        .reservation-details {
            margin-bottom: 20px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            font-size: 1rem;
        }

        .detail-icon {
            width: 25px;
            margin-right: 12px;
            font-size: 1.1rem;
        }

        .detail-label {
            font-weight: 600;
            color: var(--charcoal);
            margin-right: 8px;
            min-width: 100px;
        }

        .detail-value {
            color: var(--soft-gray);
        }

        .reservation-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            font-size: 0.9rem;
            transition: var(--transition);
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-detail {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }

        .btn-detail:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 123, 255, 0.3);
        }

        .btn-cancel {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }

        .btn-cancel:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(220, 53, 69, 0.3);
        }

        .btn-back {
            background: linear-gradient(135deg, #6c757d, #495057);
            color: white;
            margin-bottom: 30px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(108, 117, 125, 0.3);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            background: white;
            border-radius: 20px;
            box-shadow: var(--shadow-soft);
        }

        .empty-icon {
            font-size: 5rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-title {
            font-size: 1.5rem;
            color: var(--charcoal);
            margin-bottom: 10px;
        }

        .empty-message {
            color: var(--soft-gray);
            margin-bottom: 30px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-red), #b71c1c);
            color: white;
            padding: 15px 30px;
            font-size: 1rem;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(211, 47, 47, 0.3);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                padding: 100px 15px 40px;
            }

            .page-title {
                font-size: 2rem;
            }

            .reservations-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }

            .reservation-card {
                padding: 20px;
            }

            .reservation-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }

            .reservation-actions {
                flex-direction: column;
            }

            .detail-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .detail-label {
                min-width: auto;
            }
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .reservation-card {
            animation: fadeInUp 0.6s ease-out;
        }

        .reservation-card:nth-child(2) { animation-delay: 0.1s; }
        .reservation-card:nth-child(3) { animation-delay: 0.2s; }
        .reservation-card:nth-child(4) { animation-delay: 0.3s; }
    </style>
</head>
<body>
    <nav>
        <div class="nav-container">
            <a href="loginCustomer" class="logo">ShaBu</a>
        </div>
    </nav>

    <div class="main-container">
        <a href="loginCustomer" class="btn btn-back">
            ← กลับหน้าหลัก
        </a>

        <div class="page-header">
            <h1 class="page-title">📋 การจองของฉัน</h1>
            <p class="page-subtitle">ดูรายละเอียดและจัดการการจองโต๊ะของคุณ</p>
        </div>

        <c:if test="${not empty user}">
            <div class="user-welcome">
                <h3>👤 สวัสดี, ${user.cusname}</h3>
                <p>นี่คือรายการการจองโต๊ะทั้งหมดของคุณ</p>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty reservations}">
                <div class="reservations-grid">
                    <c:forEach var="reservation" items="${reservations}">
                        <div class="reservation-card">
                            <div class="reservation-header">
                                <div class="reservation-id">#${reservation.reserveid}</div>
                                <div class="status-badge status-${reservation.status.toLowerCase()}">
                                    ${reservation.status}
                                </div>
                            </div>

                            <div class="reservation-details">
                                <div class="detail-item">
                                    <span class="detail-icon">🏷️</span>
                                    <span class="detail-label">โต๊ะ:</span>
                                    <span class="detail-value">${reservation.tables.tableid}</span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-icon">📅</span>
                                    <span class="detail-label">วันที่:</span>
                                    <span class="detail-value">
                                        <fmt:formatDate value="${reservation.reservedate}" pattern="dd MMMM yyyy"/>
                                    </span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-icon">🕐</span>
                                    <span class="detail-label">เวลา:</span>
                                    <span class="detail-value">${reservation.reservetime} น.</span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-icon">👥</span>
                                    <span class="detail-label">จำนวนคน:</span>
                                    <span class="detail-value">${reservation.numberOfGuests} คน</span>
                                </div>

                                <div class="detail-item">
                                    <span class="detail-icon">🪑</span>
                                    <span class="detail-label">ความจุ:</span>
                                    <span class="detail-value">${reservation.tables.capacity} ที่นั่ง</span>
                                </div>
                            </div>

                            <div class="reservation-actions">
                                <a href="<c:url value='reservationDetail?id=${reservation.reserveid}' />" 
                                   class="btn btn-detail">
                                    📄 ดูรายละเอียด
                                </a>
                                <c:if test="${reservation.status eq 'confirm'}">
                                    <a href="<c:url value='cancelReservation?id=${reservation.reserveid}' />" 
                                       class="btn btn-cancel"
                                       onclick="return confirm('คุณแน่ใจหรือไม่ที่จะยกเลิกการจอง?')">
                                        ❌ ยกเลิกการจอง
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">📅</div>
                    <h3 class="empty-title">ยังไม่มีการจองโต๊ะ</h3>
                    <p class="empty-message">คุณยังไม่มีประวัติการจองโต๊ะ เริ่มจองโต๊ะแรกของคุณเลย!</p>
                    <a href="<c:url value='reserve&listTable' />" class="btn btn-primary">
                        🍽️ จองโต๊ะเลย
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Add some interactive effects
        document.querySelectorAll('.reservation-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });

        // Smooth scroll to top
        window.scrollTo({ top: 0, behavior: 'smooth' });
    </script>
</body>
</html>