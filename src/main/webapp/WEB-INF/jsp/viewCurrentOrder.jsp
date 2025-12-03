<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
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
            --accent-gray: #ccc;
            --progress-base: #e0e0e0;
            
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
        
        /* === Header & Back Button === */
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
            color: var(--text-dark);
            margin: 0;
            display: flex;
            align-items: center;
        }
        
        .back-to-menu {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 15px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--text-dark); 
            background-color: var(--accent-gray); 
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
        
        .order-summary strong {
            font-weight: 700;
            color: var(--text-dark);
        }
        
        /* VVVV 4-Step Progress Tracker (Icon Style) VVVV */
        .status-tracker {
            display: flex;
            justify-content: space-between;
            position: relative;
            margin-bottom: 50px; 
            padding: 0 5%; 
        }

        /* เส้นเชื่อมต่อ (Base Line) */
        .status-tracker::before {
            content: '';
            position: absolute;
            height: 6px;
            width: 90%; 
            background: var(--progress-base);
            top: 35px; 
            left: 5%;
            right: 5%;
            z-index: 1;
            border-radius: 3px;
        }

        /* Filled progress line (เส้นสีเขียว) - แก้ไขให้ไม่ล้น */
        .status-tracker::after {
            content: '';
            position: absolute;
            height: 6px; 
            background: var(--primary-green);
            top: 35px;
            left: 5%; /* เริ่มจากจุดเริ่มต้น (5%) */
            z-index: 1;
            /* ใช้ percentage ที่คำนวณจาก JSP ซึ่งสัมพันธ์กับความกว้าง 90% ของเส้นฐาน */
            width: var(--progress-width, 0%); 
            transition: width 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94); 
            border-radius: 3px;
            box-shadow: 0 0 10px rgba(76, 175, 80, 0.5); 
        }

        .status-step {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 25%; 
            position: relative;
            z-index: 2;
            color: var(--text-muted);
            transition: color 0.3s;
            text-align: center;
        }

        /* วงกลมไอคอนใหญ่ (Circle Container) */
        .status-dot {
            width: 60px; 
            height: 60px; 
            border-radius: 50%;
            background: white; 
            border: 3px solid var(--progress-base); 
            display: flex;
            justify-content: center;
            align-items: center;
            margin-bottom: 15px;
            transition: border-color 0.3s, background 0.3s, transform 0.3s, box-shadow 0.3s;
        }

        /* ไอคอนภายในวงกลม */
        .status-dot i {
            font-size: 28px;
            color: var(--progress-base); 
            transition: color 0.3s;
        }

        /* สถานะเสร็จสิ้น (Complete) */
        .status-step.complete .status-dot {
            border-color: var(--primary-green); 
            animation: bounce 0.5s ease-out; 
        }
        .status-step.complete .status-dot i {
            color: var(--primary-green); 
        }

        /* สถานะปัจจุบัน (Active) */
        .status-step.active .status-dot {
            border-color: var(--primary-green);
            background: var(--primary-green); 
            transform: scale(1.05); 
            box-shadow: 0 0 0 6px var(--soft-mint), 0 0 15px rgba(76, 175, 80, 0.4); 
        }
        .status-step.active .status-dot i {
            color: white; 
        }
        .status-step.active .status-step-label {
            color: var(--text-dark); 
            font-weight: 700;
        }

        @keyframes bounce {
            0% { transform: scale(0.9); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1.0); }
        }
        /* ^^^^ END 4-Step Progress Tracker (Icon Style) VVVV */

        /* Order List */
        .order-list {
            margin-top: 20px;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            border-bottom: 1px solid #eee;
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
        /* *** สถานะสำหรับรายการที่ไม่ต้องติดตาม (บุฟเฟต์) *** */
        .status-No_Tracking { 
            background-color: transparent;
            color: var(--text-muted);
            border: 1px solid var(--accent-gray);
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
            .status-step-label {
                font-size: 0.75em;
            }
            /* ปรับให้วงกลมไม่ใหญ่เกินไปในมือถือ */
            .status-tracker::before, .status-tracker::after {
                top: 30px; 
            }
            .status-dot {
                width: 45px;
                height: 45px;
            }
            .status-dot i {
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="order-container">
        
        <div class="header-section">
            <h1 style="color: var(--text-dark);">รายการสั่งอาหาร</h1>
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
        
            <%-- VVVV 1. Logic สำหรับคำนวณสถานะรวม (Excluding Buffet) VVVV --%>
            <c:set var="totalItemsToTrack" value="0" />
            <c:set var="pendingCount" value="0" />
            <c:set var="inProgressCount" value="0" />
            <c:set var="servedCount" value="0" />
            
            <c:forEach items="${orderDetails}" var="detail">
                <c:set var="isBuffetItem" value="${fn:contains(fn:toLowerCase(detail.menufood.foodname), 'บุฟเฟต์')}" />
                
                <c:if test="${isBuffetItem == false}">
                    <c:set var="totalItemsToTrack" value="${totalItemsToTrack + 1}" />
                    <c:choose>
                        <c:when test="${detail.status == 'Pending'}">
                            <c:set var="pendingCount" value="${pendingCount + 1}" />
                        </c:when>
                        <c:when test="${detail.status == 'In Progress'}">
                            <c:set var="inProgressCount" value="${inProgressCount + 1}" />
                        </c:when>
                        <c:when test="${detail.status == 'Served'}">
                            <c:set var="servedCount" value="${servedCount + 1}" />
                        </c:when>
                    </c:choose>
                </c:if>
            </c:forEach>
            
            <c:set var="totalNonBuffetItems" value="${totalItemsToTrack}" />
            
            <%-- 2. กำหนดสถานะรวมของบิลตาม Logic --%>
            <c:set var="isOrderConfirmed" value="${totalNonBuffetItems > 0}" />
            <c:set var="isOrderPending" value="${pendingCount > 0}" />
            <c:set var="isOrderPreparing" value="${inProgressCount > 0}" /> 
            <c:set var="isOrderServed" value="${pendingCount == 0 && inProgressCount == 0 && totalNonBuffetItems > 0}" />
            
            <%-- 3. คำนวณความกว้างของ Progress Bar (0% / 30% / 60% / 90% ของความยาวเส้นฐาน 90%) --%>
            <c:set var="progressWidthPercentage" value="0" />
            
            <c:if test="${isOrderConfirmed}">
                <c:set var="progressWidthPercentage" value="0" /> 
            </c:if>
            <c:if test="${isOrderPending || isOrderPreparing || isOrderServed}">
                <%-- ขั้นที่ 2: รอดำเนินการ (30% คือ 1/3 ของความยาวเส้น 90%) --%>
                <c:set var="progressWidthPercentage" value="30" /> 
            </c:if>
            <c:if test="${isOrderPreparing || isOrderServed}">
                <%-- ขั้นที่ 3: กำลังจัดเตรียม (60% คือ 2/3 ของความยาวเส้น 90%) --%>
                <c:set var="progressWidthPercentage" value="60" /> 
            </c:if>
            <c:if test="${isOrderServed}">
                <%-- ขั้นที่ 4: เสิร์ฟแล้ว (90% คือ 100% ของความยาวเส้น) *** จุดแก้ไขการล้น *** --%>
                <c:set var="progressWidthPercentage" value="90" /> 
            </c:if>
            
            
            <%-- VVVV 4. Status Bar Display (Icon Style) VVVV --%>
            <div class="status-tracker" style="--progress-width: ${progressWidthPercentage}%;">
                
                <div class="status-step ${isOrderConfirmed ? 'complete' : ''} ${progressWidthPercentage == 0 ? 'active' : ''}">
                    <div class="status-dot"><i class="fas fa-clipboard-list"></i></div>
                    <div class="status-step-label">ยืนยันคำสั่งซื้อ</div>
                </div>
                
                <div class="status-step ${isOrderPending || isOrderPreparing || isOrderServed ? 'complete' : ''} ${progressWidthPercentage == 30 ? 'active' : ''}">
                    <div class="status-dot"><i class="fas fa-hourglass-half"></i></div>
                    <div class="status-step-label">รอดำเนินการ</div>
                </div>
                
                <div class="status-step ${isOrderPreparing || isOrderServed ? 'complete' : ''} ${progressWidthPercentage == 60 ? 'active' : ''}">
                    <div class="status-dot"><i class="fas fa-utensils"></i></div>
                    <div class="status-step-label">กำลังจัดเตรียม</div>
                </div>
                
                <div class="status-step ${isOrderServed ? 'complete active' : ''}">
                    <div class="status-dot"><i class="fas fa-check-circle"></i></div>
                    <div class="status-step-label">เสิร์ฟแล้ว</div>
                </div>
                
            </div>
            <%-- ^^^^ END Status Bar ^^^^ --%>
            
            
            <div class="order-summary">
                <p><strong>บิลเลขที่:</strong> #${currentOrder.oderId}</p>
                <p><strong>โต๊ะที่ใช้งาน:</strong> ${tableId}</p>
                <p><strong>ราคารวมบิลปัจจุบัน:</strong> ฿<fmt:formatNumber value="${currentOrder.totalPeice}" type="number" minFractionDigits="2" maxFractionDigits="2" /></p>
            </div>

            <div class="order-list">
                <c:if test="${empty orderDetails}">
                    <p style="text-align: center; color: #777; font-style: italic;">ยังไม่มีรายการอาหารในบิลนี้</p>
                </c:if>
                
                <%-- VVVV OrderDetails Display VVVV --%>
                <c:forEach items="${orderDetails}" var="detail">
                    <c:set var="isBuffetItem" value="${fn:contains(fn:toLowerCase(detail.menufood.foodname), 'บุฟเฟต์')}" />

                    <div class="order-item">
                        <div class="item-content">
                            <img src="${detail.menufood.foodImage}" alt="${detail.menufood.foodname}" class="item-img" />
                            
                            <div class="item-details">
                                <div class="item-name">${detail.menufood.foodname}</div>
                                <div class="item-qty">จำนวน: ${detail.quantity} | ฿<fmt:formatNumber value="${detail.priceAtTimeOfOrder}" type="number" minFractionDigits="2" maxFractionDigits="2" />/หน่วย</div>
                            </div>
                        </div>
                        
                        <div class="status-col">
                            
                            <c:choose>
                                <c:when test="${isBuffetItem}">
                                    <%-- *** สถานะสำหรับบุฟเฟต์: ใช้ status-No_Tracking และข้อความ 'บุฟเฟต์' *** --%>
                                    <span class="status-tag status-No_Tracking">บุฟเฟต์</span>
                                </c:when>
                                <c:otherwise>
                                    <%-- สถานะปกติสำหรับรายการทั่วไป --%>
                                    <c:set var="detailStatusCss" value="${fn:replace(detail.status, ' ', '_')}" />
                                    <span class="status-tag status-${detailStatusCss}">
                                        <c:choose>
                                            <c:when test="${detail.status == 'Pending'}">รอดำเนินการ</c:when>
                                            <c:when test="${detail.status == 'In Progress'}">กำลังจัดเตรียม</c:when>
                                            <c:when test="${detail.status == 'Served'}">เสิร์ฟแล้ว</c:when>
                                            <c:otherwise>${detail.status}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </c:otherwise>
                            </c:choose>
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
    
    <%-- VVVV JavaScript for Auto-Refresh VVVV --%>
    <script>
        // ตั้งค่าให้รีโหลดหน้าทุก 5 วินาที เพื่อดึงสถานะล่าสุดจาก Server
        setTimeout(function() {
             window.location.reload();
        }, 5000); 
    </script>
</body>
</html>