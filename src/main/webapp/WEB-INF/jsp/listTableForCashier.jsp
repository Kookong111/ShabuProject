<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<!DOCTYPE html>
<html lang="th">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายการเมนูอาหาร</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Prompt:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-purple: #6b46c1;
            --secondary-purple: #8b5cf6;
            --light-purple: #c4b5fd;
            --very-light-purple: #f3f4f6;
            --purple-gradient-start: #8b5cf6;
            --purple-gradient-end: #a78bfa;
            --white: #ffffff;
            --text-dark: #1f2937;
            --text-light: #6b7280;
            --border: #e5e7eb;
            --shadow: rgba(139, 92, 246, 0.12);
            --shadow-hover: rgba(139, 92, 246, 0.20);
            --accent-blue: #3b82f6;
            --accent-green: #10b981;
            --table-highlight: #6366f1;
            --customer-highlight: #4338ca;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Prompt', sans-serif;
            background: linear-gradient(135deg, #ffffff 0%, #fefbff 30%, #faf5ff 100%);
            color: var(--text-dark);
            line-height: 1.6;
            min-height: 100vh;
        }

        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Header Section */
        .header-section {
            background: linear-gradient(135deg, var(--white) 0%, #fefbff 100%);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 20px var(--shadow);
            border: 1px solid #ede9fe;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1.5rem;
        }

        .title-section h1 {
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--secondary-purple) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .subtitle {
            color: var(--text-light);
            font-size: 1rem;
            font-weight: 400;
        }

        .add-menu-btn {
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--secondary-purple) 100%);
            color: var(--white);
            padding: 1rem 2rem;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            border: none;
            cursor: pointer;
            box-shadow: 0 4px 15px var(--shadow);
        }

        .add-menu-btn:hover {
            background: linear-gradient(135deg, var(--secondary-purple) 0%, var(--purple-gradient-end) 100%);
            color: var(--white);
            transform: translateY(-2px);
            box-shadow: 0 8px 25px var(--shadow-hover);
        }

        /* Cards Grid Layout */
        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .reservation-card {
            background: linear-gradient(135deg, var(--white) 0%, #fefbff 100%);
            border-radius: 16px;
            padding: 1.5rem;
            border: 1px solid #ede9fe;
            box-shadow: 0 4px 20px var(--shadow);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .reservation-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary-purple) 0%, var(--secondary-purple) 50%, var(--light-purple) 100%);
        }

        .reservation-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 30px var(--shadow-hover);
            border-color: var(--secondary-purple);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        /* ปรับปรุงหมายเลขโต๊ะให้เห็นชัด */
        .table-number {
            font-size: 1.2rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--secondary-purple) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            background: linear-gradient(135deg, var(--light-purple) 0%, #ddd6fe 100%);
            color: var(--primary-purple);
            border: 1px solid var(--light-purple);
        }

        /* ปรับปรุงชื่อลูกค้าให้เห็นชัด */
        .customer-info {
            margin-bottom: 1.5rem;
            padding: 0.5rem 0;
        }

        .customer-name {
            font-size: 1.4rem;
            font-weight: 700;
            color: var(--customer-highlight);
            margin-bottom: 0.3rem;
            text-transform: uppercase;
            letter-spacing: 0.3px;
        }

        .customer-label {
            font-size: 0.9rem;
            color: var(--text-light);
            font-weight: 500;
            margin-bottom: 0.3rem;
        }

        .reservation-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .detail-label {
            font-size: 0.85rem;
            color: var(--text-light);
            font-weight: 500;
        }

        .detail-value {
            font-size: 1rem;
            color: var(--text-dark);
            font-weight: 600;
        }

        .card-actions {
            display: flex;
            gap: 0.75rem;
            padding-top: 1rem;
            border-top: 1px solid var(--light-purple);
        }

        .action-btn {
            flex: 1;
            padding: 0.75rem;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 600;
            text-align: center;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            border: 2px solid transparent;
        }

        .edit-btn {
            background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%);
            color: var(--accent-green);
            border-color: #bbf7d0;
        }

        .edit-btn:hover {
            background: var(--accent-green);
            color: var(--white);
            border-color: var(--accent-green);
            transform: translateY(-2px);
        }

        .payment-btn {
            background: linear-gradient(135deg, #eff6ff 0%, #dbeafe 100%);
            color: var(--accent-blue);
            border-color: #bfdbfe;
        }

        .payment-btn:hover {
            background: var(--accent-blue);
            color: var(--white);
            border-color: var(--accent-blue);
            transform: translateY(-2px);
        }

        .confirm-btn {
            background: linear-gradient(135deg, var(--very-light-purple) 0%, #e9d5ff 100%);
            color: var(--primary-purple);
            border-color: var(--light-purple);
        }

        .confirm-btn:hover {
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--secondary-purple) 100%);
            color: var(--white);
            border-color: var(--primary-purple);
            transform: translateY(-2px);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: linear-gradient(135deg, var(--white) 0%, #fefbff 100%);
            border-radius: 16px;
            border: 1px solid #ede9fe;
            box-shadow: 0 4px 20px var(--shadow);
        }

        .empty-state i {
            font-size: 4rem;
            background: linear-gradient(135deg, var(--light-purple) 0%, var(--secondary-purple) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            color: var(--primary-purple);
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        /* Footer */
        .footer-section {
            text-align: center;
            margin-top: 3rem;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            color: var(--primary-purple);
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
            padding: 1rem 2rem;
            border-radius: 12px;
            background: linear-gradient(135deg, var(--white) 0%, #faf5ff 100%);
            border: 1px solid var(--light-purple);
            transition: all 0.3s ease;
        }

        .back-link:hover {
            color: var(--white);
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--secondary-purple) 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 20px var(--shadow);
        }

        /* Error Message */
        .error-message {
            background: linear-gradient(135deg, #fef2f2 0%, #fee2e2 100%);
            color: #dc2626;
            padding: 1.5rem;
            border-radius: 12px;
            margin: 2rem 0;
            text-align: center;
            font-weight: 500;
            border: 1px solid #fca5a5;
        }

        /* Responsive Design */
        @media (max-width: 1200px) {
            .cards-container {
                grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .main-container {
                padding: 1rem;
            }

            .header-content {
                flex-direction: column;
                align-items: stretch;
                text-align: center;
            }

            .title-section h1 {
                font-size: 1.75rem;
            }

            .cards-container {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .reservation-details {
                grid-template-columns: 1fr;
            }

            .card-actions {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 0.5rem;
            }

            .card-actions .confirm-btn {
                grid-column: span 2;
            }

            .card-header {
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }

            .table-number {
                align-self: center;
            }

            .customer-name {
                font-size: 1.4rem;
            }
        }

        @media (max-width: 480px) {
            .header-section,
            .reservation-card {
                padding: 1.25rem;
            }

            .title-section h1 {
                font-size: 1.5rem;
            }

            .table-number {
                font-size: 1.1rem;
            }

            .customer-name {
                font-size: 1.2rem;
            }
        }
    </style>
</head>

<body>
    <div class="main-container">
        <!-- Header Section -->
        <div class="header-section">
            <div class="header-content">
                <div class="title-section">
                    <h1>รายการเมนูอาหาร</h1>
                    <p class="subtitle">จำนวนเมนูทั้งหมด: ${listable.size()} โต๊ะ</p>
                </div>
            </div>
        </div>

        <!-- Cards Container -->
        <div class="cards-container">
            <c:forEach items="${listable}" var="item" varStatus="status">
                <div class="reservation-card">
                    <div class="card-header">
                        <div class="table-number">
                            โต๊ะ ${item.tables.tableid}
                        </div>
                        <div class="status-badge">${item.status}</div>
                    </div>
                    
                    <div class="customer-info">
                        <span class="customer-label">คุณ <span class="customer-name">${item.customers.cususername}</span></span>
                        
                    </div>
                    
                    <div class="reservation-details">
                        <div class="detail-item">
                            <span class="detail-label">จำนวนคน</span>
                            <span class="detail-value">${item.numberOfGuests} คน</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">วันที่จอง</span>
                            <span class="detail-value">${item.reservedate}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">เวลา</span>
                            <span class="detail-value">${item.reservetime}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">รหัสการจอง</span>
                            <span class="detail-value">#${item.reserveid}</span>
                        </div>
                    </div>
                    
                    <div class="card-actions">
                        <a href="geteditMenufood?foodId=${item.reserveid}" class="action-btn edit-btn">
                            <i class="bi bi-pencil"></i>
                            แก้ไข
                        </a>
                        <a href="#" onclick="confirmReservation('${item.reserveid}')" class="action-btn confirm-btn">
                            <i class="bi bi-check-circle"></i>
                            ยืนยันการจอง
                        </a>
                        <a href="#" onclick="processPayment('${item.reserveid}')" class="action-btn payment-btn">
                            <i class="bi bi-credit-card"></i>
                            ชำระเงิน
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Empty State (แสดงเมื่อไม่มีข้อมูล) -->
        <c:if test="${empty listable}">
            <div class="empty-state">
                <i class="bi bi-journal-text"></i>
                <h3>ยังไม่มีรายการเมนู</h3>
                <p>เริ่มต้นเพิ่มเมนูแรกของคุณ</p>
            </div>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty error_message}">
            <div class="error-message">${error_message}</div>
        </c:if>

        <!-- Footer -->
        <div class="footer-section">
            <a href="home" class="back-link">
                <i class="bi bi-house"></i>
                กลับหน้าหลัก
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmReservation(reserveId) {
            if (confirm('คุณต้องการยืนยันการจองนี้หรือไม่?')) {
                fetch('confirmReservation', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'reserveId=' + encodeURIComponent(reserveId)
                }).then(response => response.text())
                  .then(() => location.reload())
                  .catch(error => {
                      console.error('Error:', error);
                      alert('เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
                  });
            }
        }

        function processPayment(reserveId) {
            if (confirm('คุณต้องการดำเนินการชำระเงินสำหรับการจองนี้หรือไม่?')) {
                fetch('processPayment', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'reserveId=' + encodeURIComponent(reserveId)
                }).then(response => response.text())
                  .then(() => location.reload())
                  .catch(error => {
                      console.error('Error:', error);
                      alert('เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง');
                  });
            }
        }

        // เพิ่มเอฟเฟกต์ loading
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.reservation-card');
            cards.forEach((card, index) => {
                setTimeout(() => {
                    card.style.opacity = '0';
                    card.style.transform = 'translateY(20px)';
                    card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                    setTimeout(() => {
                        card.style.opacity = '1';
                        card.style.transform = 'translateY(0)';
                    }, 50);
                }, index * 100);
            });
        });
    </script>
</body>
</html>