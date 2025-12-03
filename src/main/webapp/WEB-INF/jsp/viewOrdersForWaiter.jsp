<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> <%-- ต้องเพิ่ม fn: เพื่อใช้ fn:toLowerCase และ fn:contains --%>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>จัดการรายการสั่งอาหาร</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        /* CSS สำหรับการจัดกลุ่มและการแสดงสถานะ */
        * { font-family: 'Kanit', sans-serif; box-sizing: border-box; }
        :root {
            --primary-color: #5d00a8; 
            --secondary-color: #f7f3ff; 
            --served-color: #17a2b8; 
            --progress-color: #ffc107; 
            --pending-color: #dc3545; 
            --order-header-bg: #e9ecef; 
        }
        body { 
            background-color: var(--secondary-color);
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            position: relative; 
        }
        
        /* NEW CSS FOR HOME BUTTON */
        .header-home-btn {
            position: absolute; 
            top: 20px;
            left: 20px;
            padding: 6px 10px !important; 
            font-size: 0.9em;
            font-weight: 500;
        }
        
        h2 {
            color: var(--primary-color);
            border-bottom: 2px solid var(--primary-color);
            padding-bottom: 10px;
            margin-bottom: 20px;
            display: flex;
            justify-content: flex-start; 
            align-items: center;
            /* ปรับ margin เพื่อหลีกเลี่ยงปุ่มกลับบ้าน */
            margin-left: 120px; 
        }
        .order-group {
            border: 1px solid #ccc;
            border-radius: 6px;
            margin-bottom: 25px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
        }
        .order-header {
            background-color: var(--order-header-bg);
            padding: 10px 15px;
            font-size: 1.1em;
            font-weight: 600;
            color: #333;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap; /* NEW: ให้ header wrap ได้ */
        }
        /* NEW: สำหรับตารางบนมือถือ */
        .table-responsive {
            overflow-x: auto; 
        }
        .order-table {
            min-width: 700px; /* NEW: กำหนดความกว้างขั้นต่ำ เพื่อให้ตารางเลื่อนได้ */
            width: 100%;
            border-collapse: collapse;
        }
        .order-table th, .order-table td {
            padding: 10px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }
        .order-table th {
            background-color: #f8f8f8;
            font-weight: 600;
            color: #555;
        }
        
        /* แก้ไขเพื่อให้เหลือแค่สีข้อความ */
        .status-pill {
            display: inline-block;
            padding: 0;
            min-width: 0;
            border-radius: 0;
            font-size: 0.9em;
            font-weight: 500;
            color: inherit; 
            text-align: center;
            background-color: transparent !important; 
        }
        .status-pill.pending { 
            color: var(--pending-color); 
        }
        .status-pill.in-progress { 
            color: var(--progress-color); 
        }
        .status-pill.served { 
            color: var(--served-color); 
        }

        /* Action Buttons */
        .action-form {
            display: inline-block;
            margin-right: 5px;
        }
        .action-btn {
            padding: 8px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            color: #fff;
            font-weight: 500;
            transition: background-color 0.2s;
            white-space: nowrap; /* NEW: กันปุ่มขึ้นบรรทัดใหม่ */
            font-size: 0.9em; /* NEW: ลดขนาดปุ่มลงเล็กน้อย */
        }
        .action-btn:hover:not(:disabled) {
            opacity: 0.9;
        }
        /* Style for disabled buttons (e.g. Buffet items) */
        .action-btn:disabled {
            background-color: #ccc !important; 
            cursor: not-allowed;
            color: #666;
            opacity: 1; 
        }
        .no-orders {
            text-align: center;
            padding: 50px;
            font-size: 1.2em;
            color: #6c757d;
            background-color: #f9f9f9;
            border-radius: 6px;
        }
        .message-box {
            padding: 10px 20px;
            margin-bottom: 20px;
            border-radius: 4px;
            font-weight: 500;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        
        /* === NEW MEDIA QUERY FOR MOBILE VIEW === */
        @media (max-width: 768px) {
            body {
                padding: 10px;
            }
            .container {
                padding: 10px;
            }
            .header-home-btn {
                top: 10px;
                left: 10px;
            }
            h2 {
                margin-left: 80px; /* ลด margin ซ้าย */
                font-size: 1.2em;
            }
            .order-header {
                font-size: 1em;
                padding: 8px 10px;
            }
            .order-header > div,
            .order-header > span {
                width: 100%;
                margin-bottom: 5px;
            }
            .order-header > span {
                text-align: right;
            }
            .action-btn {
                padding: 6px 8px;
                font-size: 0.8em;
            }
            .action-form {
                display: block; /* ทำให้ปุ่ม Action รวมแสดงเป็นบล็อก */
                margin-bottom: 5px;
            }
            .order-group > div:nth-child(2) { /* Action Button Group */
                 flex-direction: column; /* ให้ปุ่มรวมเรียงลงมา */
            }
            .order-table th, .order-table td {
                padding: 8px 10px;
            }
        }
    </style>
</head>
<body>

    <div class="container">
    
        <%-- ปุ่ม "กลับหน้าหลัก" (ย้ายมาอยู่บนซ้าย และลดขนาด) --%>
        <a href="<c:url value="/gohome" />" class="action-btn header-home-btn" style="background-color: #6c757d;">
            <i class="fas fa-home"></i> กลับ
        </a>

        <h2>
            <i class="fas fa-list-alt"></i> รายการสั่งอาหารที่รอการจัดการ
            <%-- ลบปุ่มกลับหน้าหลักเดิมออก --%>
        </h2>

       <%-- แสดงข้อความแจ้งเตือน (อ่านจาก Model Attribute ที่ Controller ส่งมา) --%>
       <c:if test="${not empty successMessage}">
            <div class="message-box success">${successMessage}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="message-box error">${errorMessage}</div>
        </c:if>

        <c:choose>
            <c:when test="${not empty groupedOrders}">
                <%-- วนซ้ำตาม Order (Key = Order ID, Value = List<OrderDetail>) --%>
                <c:forEach var="entry" items="${groupedOrders}">
                    <c:set var="orderId" value="${entry.key}"/>
                    <c:set var="orderDetails" value="${entry.value}"/>
                    
                    <%-- ใช้ OrderDetail ตัวแรกในกลุ่มเพื่อดึงข้อมูล Order/Table --%>
                    <c:set var="order" value="${orderDetails[0].orders}"/>

                    <%-- VVVV Logic: ตรวจสอบสถานะรวมของ Order VVVV --%>
                    <c:set var="hasPending" value="false"/>
                    <c:set var="hasInProgress" value="false"/>
                    <c:forEach var="detail" items="${orderDetails}">
                        <c:if test="${fn:contains(fn:toLowerCase(detail.menufood.foodname), 'บุฟเฟต์') == false}">
                             <%-- ตรวจสอบ Pending/InProgress เฉพาะรายการที่ไม่ใช่บุฟเฟต์ --%>
                            <c:if test="${detail.status eq 'Pending'}">
                                <c:set var="hasPending" value="true"/>
                            </c:if>
                            <c:if test="${detail.status eq 'In Progress'}">
                                <c:set var="hasInProgress" value="true"/>
                            </c:if>
                        </c:if>
                    </c:forEach>
                    <%-- ^^^^ สิ้นสุด Logic: ตรวจสอบสถานะรวมของ Order ^^^^ --%>

                    <div class="order-group">
                        <div class="order-header">
                            <div>
                                บิล Order ID: ${orderId} 
                            </div>
                            <span>
                                โต๊ะ: <strong>${order.table.tableid}</strong> 
                            </span>
                        </div>
                        
                        <%-- VVVV ปุ่ม Action รวม (จัดเตรียมทั้งหมด / เสิร์ฟทั้งหมด) VVVV --%>
                        <div style="padding: 10px 15px; background-color: #f0f4f7; border-bottom: 1px solid #ddd; display: flex; gap: 10px;">
                            
                            <c:if test="${hasPending}">
                                <%-- แสดงปุ่ม "จัดเตรียมทั้งหมด" ถ้ามีรายการที่ 'Pending' (ไม่รวมบุฟเฟต์) --%>
                                <form action="updateOrderToInProgress" method="post" class="action-form">
                                    <input type="hidden" name="orderId" value="${orderId}">
                                    <button type="submit" class="action-btn" style="background-color: var(--progress-color); color: #333; font-weight: 700;">
                                        <i class="fas fa-hourglass-start"></i> จัดเตรียมทั้งหมด
                                    </button>
                                </form>
                            </c:if>
                            
                            <c:if test="${!hasPending and hasInProgress}">
                                <%-- แสดงปุ่ม "เสิร์ฟอาหารทั้งหมด" ถ้าไม่มีรายการที่ 'Pending' แต่มีรายการที่ 'In Progress' (ไม่รวมบุฟเฟต์) --%>
                                <form action="updateOrderToServed" method="post" class="action-form">
                                    <input type="hidden" name="orderId" value="${orderId}">
                                    <button type="submit" class="action-btn" style="background-color: var(--served-color); font-weight: 700;">
                                        <i class="fas fa-concierge-bell"></i> เสิร์ฟอาหารทั้งหมด
                                    </button>
                                </form>
                            </c:if>

                            <c:if test="${!hasPending and !hasInProgress}">
                                <span style="color: green; font-weight: 500;"><i class="fas fa-check-circle"></i> รายการอาหารที่สั่งเสิร์ฟแล้วทั้งหมด</span>
                            </c:if>
                        </div>
                        <%-- ^^^^ สิ้นสุดปุ่ม Action รวม ^^^^ --%>
                        
                        <div class="table-responsive"> <%-- NEW: Wrap ตารางด้วย div เพื่อให้เลื่อนได้ --%>
                            <table class="order-table">
                                <thead>
                                    <tr>
                                        <th style="width: 10%;">ID</th>
                                        <th style="width: 40%;">เมนูอาหาร</th>
                                        <th style="width: 10%;">จำนวน</th>
                                        <th style="width: 15%;">สถานะ</th>
                                        <th style="width: 25%;">ดำเนินการ (รายการเดียว)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="detail" items="${orderDetails}">
                                        
                                        <%-- VVVV Logic: ตรวจสอบว่าเป็นรายการบุฟเฟต์หรือไม่ VVVV --%>
                                        <c:set var="isBuffet" value="${fn:contains(fn:toLowerCase(detail.menufood.foodname), 'บุฟเฟต์')}"/>
                                        
                                        <tr>
                                            <td>${detail.odermenuId}</td>
                                            <td>${detail.menufood.foodname}</td>
                                            <td>${detail.quantity}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${detail.status eq 'Pending'}">
                                                        <span class="status-pill pending">รอดำเนินการ</span>
                                                    </c:when>
                                                    <c:when test="${detail.status eq 'In Progress'}">
                                                        <span class="status-pill in-progress">กำลังจัดเตรียม</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status-pill served">เสิร์ฟแล้ว</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <%-- Action Buttons (สำหรับการอัปเดตรายการเดียว) --%>
                                                <c:if test="${detail.status eq 'Pending' && !isBuffet}">
                                                    <form action="updateOrderDetailStatus" method="post" class="action-form">
                                                        <input type="hidden" name="odermenuId" value="${detail.odermenuId}">
                                                        <input type="hidden" name="newStatus" value="In Progress">
                                                        
                                                        <button type="submit" class="action-btn" style="background-color: var(--progress-color); color: #333;">
                                                            <i class="fas fa-hourglass-start"></i> เริ่มทำ
                                                        </button>
                                                    </form>
                                                </c:if>
                                                
                                                <c:if test="${detail.status eq 'In Progress' && !isBuffet}">
                                                    <form action="updateOrderDetailStatus" method="post" class="action-form">
                                                        <input type="hidden" name="odermenuId" value="${detail.odermenuId}">
                                                        <input type="hidden" name="newStatus" value="Served">
                                                        
                                                        <button type="submit" class="action-btn" style="background-color: var(--served-color);">
                                                            <i class="fas fa-concierge-bell"></i> เสิร์ฟแล้ว
                                                        </button>
                                                    </form>
                                                </c:if>
                                                
                                                <c:if test="${isBuffet}">
                                                    <span class="status-pill" style="color: #6c757d;">
                                                        บุฟเฟต์
                                                    </span>
                                                </c:if>

                                                <c:if test="${!isBuffet && detail.status eq 'Served'}">
                                                    <span class="status-pill" style="color: green;">
                                                        เสร็จสิ้น
                                                    </span>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div> <%-- End table-responsive --%>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="no-orders">
                    <i class="fas fa-smile-beam"></i> ไม่มีรายการสั่งอาหารใหม่ที่ต้องดำเนินการในขณะนี้
                </div>
            </c:otherwise>
        </c:choose>

    </div>
        <script>
        // ตั้งค่าให้รีโหลดหน้าทุก 5 วินาที เพื่อดึงสถานะล่าสุดจาก Server
        // การรีโหลดนี้จะทำให้ Progress Bar มี Animation ผ่าน CSS Transition
        setTimeout(function() {
            window.location.reload();
        }, 1000); 
    </script>
</body>
</html>