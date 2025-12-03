<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <title>ใบแจ้งข้อมูล Order #${orderInfo.oderId}</title>
    <style>
        body { font-family: 'Kanit', sans-serif; margin: 0; padding: 20px; color: #333; }
        .print-container { max-width: 600px; margin: 0 auto; border: 1px solid #ccc; padding: 30px; }
        .header { text-align: center; margin-bottom: 20px; }
        .header h1 { font-size: 1.5rem; margin-bottom: 5px; }
        .info-block { margin-bottom: 20px; border-bottom: 1px dashed #ddd; padding-bottom: 10px; }
        .info-block p { margin: 5px 0; font-size: 0.9rem; }
        .qr-section { text-align: center; margin-top: 30px; }
        .qr-section p { font-weight: 600; }
        
        /* สไตล์สำหรับ Print Media */
        @media print {
            body { background: white; }
            .print-button { display: none; }
            .print-container { border: none; padding: 0; }
        }
    </style>
</head>
<body>
    <div class="print-container">
        <div class="header">
            <h1>ใบแจ้ง Order & QR Code</h1>
            <p>ร้านอาหาร ShaBu Restaurant</p>
        </div>
        
        <div class="info-block">
            <p><strong>Order ID:</strong> #${orderInfo.oderId}</p>
            <p><strong>โต๊ะ:</strong> ${table.tableid} (รองรับ ${table.capacity} ที่นั่ง)</p>
            <p><strong>วันที่เปิดบิล:</strong> <fmt:formatDate value="${orderInfo.orderDate}" pattern="dd/MM/yyyy" /></p>
            <p><strong>สถานะบิล:</strong> ${orderInfo.status}</p>
        </div>
        
        <c:if test="${not empty orderDetails}">
            <h3>รายการอาหารเริ่มต้น:</h3>
            <ul>
                <c:forEach var="detail" items="${orderDetails}">
                    <li>${detail.menufood.foodname} (x${detail.quantity}) - ฿<fmt:formatNumber value="${detail.priceAtTimeOfOrder}" type="number" minFractionDigits="2" maxFractionDigits="2" /></li>
                </c:forEach>
            </ul>
        </c:if>
        <div class="qr-section">
            <p>สแกน QR Code นี้เพื่อสั่งอาหารเพิ่ม</p>
            <img src="generateQrForTable?token=${table.qrToken}" alt="QR Code" style="width: 200px; height: 200px;" />
            <p style="margin-top: 10px; font-size: 0.8rem;">URL Token: ${table.qrToken}</p>
        </div>
    </div>
    
    <div style="text-align: center; margin-top: 20px;" class="print-button">
        <button onclick="window.print()" style="padding: 10px 20px;">พิมพ์ (Print)</button>
        <button onclick="window.close()" style="padding: 10px 20px;">ปิด</button>
    </div>
</body>
</html>