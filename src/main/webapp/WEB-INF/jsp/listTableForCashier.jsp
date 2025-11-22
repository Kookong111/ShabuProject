<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายการออเดอร์</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-purple: #7047eb; /* ม่วงหลัก */
            --secondary-purple: #9b5af9;
            --light-purple: #e5d5ff;
            --white: #ffffff;
            --background-light: #f7f9fc;
            --text-dark: #374151;
            --text-muted: #6b7280;
            --border: #e5e7eb;
            --shadow-light: 0 4px 10px rgba(0, 0, 0, 0.05);
            --shadow-medium: 0 8px 25px rgba(0, 0, 0, 0.1);
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --error-color: #ef4444;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Kanit', sans-serif;
        }

        body {
            background-color: var(--background-light);
            color: var(--text-dark);
            line-height: 1.6;
            min-height: 100vh;
            padding: 2rem;
        }

        .main-container {
            max-width: 1400px;
            margin: 0 auto;
        }

        /* Header Section */
        .header-section {
            background: var(--white);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--border);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 1.5rem;
        }

        .title-section h1 {
            color: var(--primary-purple);
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .subtitle {
            color: var(--text-muted);
            font-size: 1rem;
            font-weight: 400;
        }

        /* Cards Grid Layout */
        .cards-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .order-card {
            background: var(--white);
            border-radius: 16px;
            padding: 1.5rem;
            border: 1px solid var(--border);
            box-shadow: var(--shadow-light);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.5s ease-out forwards; /* Apply animation */
        }

        .order-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-purple) 0%, var(--secondary-purple) 100%);
        }

        .order-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--shadow-medium);
            border-color: var(--light-purple);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .order-number {
            font-size: 1.3rem;
            font-weight: 800;
            color: var(--text-dark);
            letter-spacing: 0.5px;
        }
        
        /* Status Badges */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-badge.completed {
            background-color: var(--success-color);
            color: var(--white);
        }

        .status-badge.pending,
        .status-badge.open {
            background-color: var(--warning-color);
            color: var(--white);
        }

        .status-badge.cancelled {
            background-color: var(--error-color);
            color: var(--white);
        }

        .table-info {
            margin-bottom: 1.5rem;
            padding: 0.5rem 0;
        }

        .table-number {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--primary-purple);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .table-number i {
            color: var(--secondary-purple);
        }

        .order-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            padding-top: 1rem;
            border-top: 1px dashed var(--border);
            margin-bottom: 1.5rem;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .detail-label {
            font-size: 0.85rem;
            color: var(--text-muted);
            font-weight: 500;
        }

        .detail-value {
            font-size: 1rem;
            color: var(--text-dark);
            font-weight: 600;
        }

        .detail-value.price {
            color: var(--success-color);
            font-size: 1.3rem;
            font-weight: 800;
        }

        /* Action Buttons */
        .card-actions {
            display: flex;
            gap: 0.75rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border);
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
            font-size: 0.95rem;
            border: 2px solid transparent;
        }

        .check-btn {
            background-color: var(--primary-purple);
            color: var(--white);
        }

        .check-btn:hover {
            background-color: var(--secondary-purple);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.15);
        }

        .edit-btn {
            background-color: #f3f4f6;
            color: var(--text-dark);
            border-color: var(--border);
        }

        .edit-btn:hover {
            background-color: var(--border);
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            background: var(--white);
            border-radius: 16px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow-medium);
        }

        .empty-state i {
            font-size: 4rem;
            color: var(--primary-purple);
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            color: var(--primary-purple);
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        /* Home Button */
        .home-button-container {
            text-align: center;
            margin-top: 2.5rem;
            margin-bottom: 1rem;
        }

        .home-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            padding: 0.85rem 2rem;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 600;
            font-size: 1rem;
            transition: all 0.3s ease;
            border: 2px solid var(--primary-purple);
            background: var(--light-purple);
            color: var(--primary-purple);
            box-shadow: var(--shadow-light);
        }

        .home-btn:hover {
            background: var(--primary-purple);
            color: var(--white);
            transform: translateY(-3px);
            box-shadow: var(--shadow-medium);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            body {
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

            .order-details {
                grid-template-columns: 1fr;
            }
        }
    
        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>

<body>
    <div class="main-container">
        <div class="header-section">
            <div class="header-content">
                <div class="title-section">
                    <h1><i class="fas fa-receipt"></i> รายการออเดอร์</h1>
                    <p class="subtitle">แสดงออเดอร์ทั้งหมดที่รอการชำระเงิน หรืออยู่ในสถานะกำลังดำเนินการ</p>
                    <p class="subtitle">จำนวนออเดอร์ปัจจุบัน: <c:out value="${ordersList.size()}" default="0"/> รายการ</p>
                </div>
            </div>
        </div>

        <c:choose>
            <c:when test="${not empty ordersList}">
                <div class="cards-container">
                    <c:forEach items="${ordersList}" var="order" varStatus="loop">
                        <div class="order-card" style="animation-delay: ${loop.index * 0.1}s;">
                            <div class="card-header">
                                <div class="order-number">
                                    #${order.oderId}
                                </div>
                                
                                <span class="status-badge 
                                    <c:choose>
                                        <c:when test='${order.status == "เสร็จสิ้น"}'>completed</c:when>
                                        <c:when test='${order.status == "Open"}'>pending</c:when>
                                        <c:when test='${order.status == "รอดำเนินการ"}'>pending</c:when>
                                        <c:otherwise>cancelled</c:otherwise>
                                    </c:choose>
                                ">
                                    ${order.status}
                                </span>
                            </div>
                            
                            <div class="table-info">
                                <div class="table-number">
                                    <i class="fas fa-utensils"></i>
                                    โต๊ะ ${order.table.tableid}
                                </div>
                            </div>
                            
                            <div class="order-details">
                                <div class="detail-item">
                                    <span class="detail-label">วันที่/เวลา</span>
                                    <span class="detail-value">${order.orderDate}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">หมายเลขออเดอร์</span>
                                    <span class="detail-value">#${order.oderId}</span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">ราคารวม (บาท)</span>
                                    <span class="detail-value price">฿<c:out value="${order.totalPeice}" default="0.00"/></span>
                                </div>
                                <div class="detail-item">
                                    <span class="detail-label">สถานะโต๊ะ</span>
                                    <span class="detail-value">${order.table.status}</span>
                                </div>
                            </div>
                            
                            <div class="card-actions">
                                <a href="checkbill-page?orderId=${order.oderId}" class="action-btn check-btn">
                                    <i class="fas fa-money-check-alt"></i>
                                    ดำเนินการชำระเงิน
                                </a>
                                <a href="geteditOrderStatus?oderId=${order.oderId}" class="action-btn edit-btn">
                                    <i class="fas fa-pencil-alt"></i>
                                    แก้ไข
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-clipboard-list"></i>
                    <h3>ไม่พบรายการออเดอร์ที่กำลังเปิดอยู่</h3>
                    <p>กรุณารอพนักงานเสิร์ฟเปิดบิล หรือตรวจสอบสถานะโต๊ะที่กำลังใช้งาน</p>
                </div>
            </c:otherwise>
        </c:choose>

        <div class="home-button-container">
            <a href="homecashier" class="home-btn">
                <i class="fas fa-home"></i>
                กลับไปหน้าหลักแคชเชียร์
            </a>
        </div>
        </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Animation เพื่อให้การ์ดโหลดเข้ามาอย่างสวยงาม
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.order-card');
            cards.forEach(card => {
                card.style.opacity = '0';
            });
        });
    </script>
</body>
</html>