<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <title>รายการอาหารที่สั่ง</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    
    <style>
        /* === 1. Global & Variables (Elegant Mint Green) === */
        * { 
            font-family: 'Kanit', sans-serif; 
            box-sizing: border-box; 
            margin: 0;
            padding: 0;
        }

        :root {
            --primary-green: #4caf50; 
            --soft-mint: #e8f5e9;
            --accent-gold: #c0c0c0;
            
            --bg-light: #f9f9f9;
            --text-dark: #333333;
            --text-muted: #757575;
            --shadow-sm: 0 4px 10px rgba(0,0,0,0.08);
        }
        
        body { 
            background-color: var(--bg-light); 
            color: var(--text-dark); 
            min-height: 100vh;
        }
        
        .order-container {
            max-width: 800px;
            margin: 30px auto;
            background-color: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            padding: 30px;
        }
        
        /* === Header === */
        .header-section { 
             display: flex;
             justify-content: space-between;
             align-items: flex-start;
             margin-bottom: 20px;
             border-bottom: 2px solid #eee;
             padding-bottom: 15px;
        }

        h1 {
            font-size: 28px;
            font-weight: 800;
            color: var(--text-dark); /* VVVV เปลี่ยนเป็นสีดำ VVVV */
            margin: 0;
            display: flex; /* เพื่อจัดเรียงไอคอน (แม้ว่าจะถูกลบออกไปแล้ว) */
            align-items: center;
        }
        
        /* ปุ่มกลับ */
        .back-to-menu {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 15px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--text-dark); 
            background-color: var(--accent-gold); 
            font-weight: 600;
            transition: background-color 0.2s;
            flex-shrink: 0;
        }
        
        .back-to-menu:hover {
            background-color: #aaa;
        }
        /* Message/Summary Box */
        .order-summary {
            background-color: var(--soft-mint); 
            padding: 18px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 15px;
            border: 1px solid var(--primary-green);
        }
        
        .order-summary p {
            margin-bottom: 5px;
            font-weight: 500;
        }
        
        .order-summary strong {
            font-weight: 700;
            color: var(--text-dark);
        }
        
        /* Order List */
        .order-list {
            margin-top: 20px;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid var(--border);
            margin-bottom: 8px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: var(--shadow-sm);
        }
        
        /* VVVV รายละเอียดสินค้าและรูป VVVV */
        .item-content {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-grow: 1;
        }

        .item-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 8px;
            border: 1px solid #ddd;
        }

        .item-details {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }
        
        .item-name {
            font-weight: 700;
            font-size: 16px;
            color: var(--text-dark);
        }
        
        .item-qty {
            color: var(--text-muted);
            font-size: 14px;
            margin-top: 2px;
        }

        /* Status Tag */
        .status-col {
            flex-shrink: 0;
            width: 120px;
            text-align: right;
        }
        
        .status-tag {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
        }
        
        /* ใช้สีตามสถานะ */
        .status-Pending { 
            background-color: #ffcc80; 
            color: #e65100;
        }
        .status-In_Progress { 
            background-color: var(--primary-green); 
            color: white;
        }
        .status-Served { 
            background-color: #388e3c; 
            color: white;
        }
        
        /* Footer/Actions */
        .back-to-menu-bottom {
            display: block;
            margin-top: 20px;
            text-align: center;
        }

        .empty-state {
            padding: 40px;
            text-align: center;
            border: 2px dashed #eee;
            border-radius: 10px;
            color: var(--text-muted);
        }
        /* Responsive */
        @media (max-width: 520px) {
            .order-container {
                padding: 15px;
                margin: 10px auto;
            }
            .header-section {
                flex-direction: column-reverse;
                gap: 15px;
            }
            .back-to-menu {
                width: 100%;
                justify-content: center;
            }
            .order-item {
                flex-direction: column;
                align-items: flex-start;
                gap: 10px;
            }
            .item-content {
                width: 100%;
            }
            .status-col {
                width: 100%;
                text-align: left;
                padding-left: 75px; 
            }
        }
    </style>
</head>
<body>
    <div class="order-container">
        
        <div class="header-section">
            <h1 style="color: var(--text-dark);">รายการสั่งอาหาร</h1> <%-- VVVV เปลี่ยนสีเป็นสีดำและลบไอคอน VVVV --%>
            <a href="viewmenu" class="back-to-menu">
                <i class="fas fa-arrow-left"></i> กลับไปเมนู
            </a>
        </div>

        <c:if test="${not empty error}">
            <div class="order-summary" style="background-color: #f8d7da; color: #721c24;">
                <p>⚠️ <strong>ข้อผิดพลาด:</strong> ${error}</p>
            </div>
        </c:if>

        <c:if test="${not empty currentOrder}">
            <div class="order-summary">
                <p><strong>บิลเลขที่:</strong> #${currentOrder.oderId}</p>
                <p><strong>โต๊ะที่ใช้งาน:</strong> ${tableId}</p>
                <p><strong>ราคารวมบิลปัจจุบัน:</strong> ฿<fmt:formatNumber value="${currentOrder.totalPeice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
            </div>

            <div class="order-list">
                <c:if test="${empty orderDetails}">
                    <p style="text-align: center; color: #777; font-style: italic;">ยังไม่มีรายการอาหารในบิลนี้</p>
                </c:if>
                
                <%-- VVVV OrderDetails ถูกจัดเรียงโดย Controller VVVV --%>
                <c:forEach items="${orderDetails}" var="detail">
                    <div class="order-item">
                        <div class="item-content">
                            <img src="${detail.menufood.foodImage}" alt="${detail.menufood.foodname}" class="item-img" />
                            
                            <div class="item-details">
                                <div class="item-name">${detail.menufood.foodname}</div>
                                <div class="item-qty">จำนวน: ${detail.quantity} | ฿<fmt:formatNumber value="${detail.priceAtTimeOfOrder}" type="number" minFractionDigits="2" maxFractionDigits="2" />/หน่วย</div>
                            </div>
                        </div>
                        
                        <div class="status-col">
                             <span class="status-tag status-${detail.status}">
                                <c:choose>
                                    <c:when test="${detail.status == 'Pending'}">รอกำลังทำ</c:when>
                                    <c:when test="${detail.status == 'In_Progress'}">กำลังจัดเตรียม</c:when>
                                    <c:when test="${detail.status == 'Served'}">เสิร์ฟแล้ว</c:when>
                                    <c:otherwise>${detail.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        
        <c:if test="${empty currentOrder}">
             <div class="empty-state">
                 <i class="fas fa-exclamation-triangle" style="color: #f0ad4e;"></i>
                 <p>ไม่พบบิลที่เปิดใช้งานอยู่สำหรับโต๊ะของคุณ</p>
                 <a href="viewmenu" class="back-to-menu" style="background-color: var(--primary-green);">
                    <i class="fas fa-arrow-left"></i> กลับไปหน้าเมนู
                 </a>
            </div>
        </c:if>
        
    </div>
</body>
</html>