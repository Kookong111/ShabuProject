<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายการอาหารที่ต้องเสิร์ฟ</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * { font-family: 'Kanit', sans-serif; box-sizing: border-box; }
        body { background-color: #f0f4f8; color: #333; padding: 20px; }
        .container { max-width: 1000px; margin: auto; }
        h2 { color: #1a237e; text-align: center; margin-bottom: 30px; font-weight: 600; }
        
        .order-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
        }

        .order-card {
            background-color: #fff;
            border: 1px solid #e0e0e0;
            padding: 15px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        .order-card h3 {
            background-color: #ff9800;
            color: white;
            padding: 8px;
            border-radius: 8px;
            margin-top: 0;
            font-size: 1.2rem;
            text-align: center;
        }
        .order-item {
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
            border-bottom: 1px dashed #eee;
        }
        .order-item:last-child { border-bottom: none; }

        .btn-serve {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            background-color: #00bcd4;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.2s;
            text-align: center;
            text-decoration: none;
        }
        .btn-serve:hover { background-color: #0097a7; }
        
        .status-ready { color: #4caf50; font-weight: 500; }
        .status-pending { color: #ff9800; font-weight: 500; }
    </style>
</head>
<body>
    <div class="container">
        <h2><i class="fas fa-bell"></i> รายการอาหารที่ต้องเสิร์ฟ</h2>
        
        <div class="order-container">
            <%-- ตัวอย่างการวนลูป Orders ที่มาจาก Controller (สมมติชื่อ 'pendingOrders') --%>
            <c:choose>
                <c:when test="${not empty pendingOrders}">
                    <c:forEach var="order" items="${pendingOrders}">
                        <div class="order-card">
                            <h3>คำสั่งซื้อ | โต๊ะ ${order.tableid}</h3>
                            <div style="font-size: 0.9rem; color: #666; margin-bottom: 10px;">
                                <i class="fas fa-clock"></i> เวลาสั่ง: <fmt:formatDate value="${order.orderTime}" pattern="HH:mm" />
                            </div>
                            
                            <%-- ตัวอย่างรายการอาหารย่อย (สมมติว่าเป็น List<OrderItem> ใน Order) --%>
                            <c:forEach var="item" items="${order.items}">
                                <div class="order-item">
                                    <span>${item.foodName} (${item.quantity}x)</span>
                                    <span class="${item.status == 'Ready' ? 'status-ready' : 'status-pending'}">
                                        ${item.status == 'Ready' ? 'พร้อมเสิร์ฟ' : 'กำลังทำ'}
                                    </span>
                                </div>
                            </c:forEach>
                            
                            <%-- ปุ่มนี้จะเชื่อมโยงไปยัง Controller เพื่อเปลี่ยนสถานะอาหารทั้งหมดในออเดอร์นี้เป็น 'Served' --%>
                            <a href="serveOrder?orderid=${order.orderid}" class="btn-serve">
                                <i class="fas fa-concierge-bell"></i> เสิร์ฟอาหารทั้งหมด
                            </a>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="text-align: center; padding: 50px; background-color: #fff; border-radius: 12px; grid-column: 1 / -1;">
                        <i class="fas fa-check-circle"></i> ไม่มีรายการอาหารที่ต้องเสิร์ฟในขณะนี้!
                    </p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>