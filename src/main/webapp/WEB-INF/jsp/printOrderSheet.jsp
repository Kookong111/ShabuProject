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
        .order-table { width: 100%; border-collapse: collapse; margin: 15px 0; }
        .order-table th { background-color: #f0f0f0; padding: 10px; text-align: left; border-bottom: 2px solid #333; font-weight: 600; }
        .order-table td { padding: 10px; border-bottom: 1px solid #ddd; }
        .order-table tr:last-child td { border-bottom: 2px solid #333; }
        .text-right { text-align: right; }
        .total-row { font-weight: 600; font-size: 1.1rem; background-color: #f9f9f9; }
        
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
            <h1>สแกน QR Code เพื่อสั่งอาหาร</h1>
            
        </div>
        
        
        
        <div class="info-block">
            <div class="qr-section">
            
            <img src="generateQrForTable?token=${table.qrToken}" alt="QR Code" style="width: 300px; height: 300px;" />
            
        </div>
            
        </div>
        <p><strong>Order ID:</strong> #${orderInfo.oderId}</p>
            <p><strong>โต๊ะ:</strong> ${table.tableid} (รองรับ ${table.capacity} ที่นั่ง)</p>
            <p><strong>วันที่:</strong> <fmt:formatDate value="${orderInfo.orderDate}" pattern="dd/MM/yyyy" /></p>
            <div class="info-block"></div>
        <c:if test="${not empty orderDetails}">
            <h3>รายการอาหารที่สั่ง:</h3>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>ชื่อเมนู</th>
                        <th style="text-align: center;">จำนวน</th>
                        <th class="text-right">ราคา/หน่วย</th>
                        <th class="text-right">รวม</th>
                    </tr>
                </thead>
                <tbody>
                    <c:set var="subtotal" value="0" />
                    <c:forEach var="detail" items="${orderDetails}">
                        <c:if test="${detail.priceAtTimeOfOrder > 0}">
                            <c:set var="itemTotal" value="${detail.quantity * detail.priceAtTimeOfOrder}" />
                            <c:set var="subtotal" value="${subtotal + itemTotal}" />
                            <tr>
                                <td>${detail.menufood.foodname}</td>
                                <td style="text-align: center;">${detail.quantity}</td>
                                <td class="text-right">฿<fmt:formatNumber value="${detail.priceAtTimeOfOrder}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                                <td class="text-right">฿<fmt:formatNumber value="${itemTotal}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                            </tr>
                        </c:if>
                    </c:forEach>
                    <tr class="total-row">
                        <td colspan="3" style="text-align: right;">ยอดรวม:</td>
                        <td class="text-right">฿<fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                    </tr>
                </tbody>
            </table>
        </c:if>
    </div>
    
    <div style="text-align: center; margin-top: 20px;" class="print-button">
        <button onclick="window.print()" style="padding: 10px 20px;">พิมพ์ (Print)</button>
        <button onclick="window.close()" style="padding: 10px 20px;">ปิด</button>
    </div>
</body>
</html>