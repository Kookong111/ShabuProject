<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ใบเสร็จชำระเงิน - ShaBu Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Kanit', sans-serif;
        }

        body {
            background: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .receipt-container {
            background: #ffffff;
            width: 100%;
            max-width: 520px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .receipt-header {
            background: #ffffff;
            padding: 2rem 1.5rem 1rem;
            text-align: center;
            border-bottom: 2px dashed #e0e0e0;
        }

        .restaurant-name {
            font-size: 1.5rem;
            font-weight: 700;
            color: #1a1a1a;
            margin-bottom: 0.25rem;
            letter-spacing: 0.5px;
        }

        .restaurant-subtitle {
            font-size: 0.875rem;
            color: #666;
            margin-bottom: 1.5rem;
            font-weight: 400;
        }

        .receipt-info {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-top: 1px solid #f0f0f0;
            border-bottom: 1px solid #f0f0f0;
            margin-top: 1rem;
        }

        .receipt-info-item {
            text-align: left;
        }

        .receipt-info-item:last-child {
            text-align: right;
        }

        .receipt-info-label {
            font-size: 0.75rem;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.25rem;
        }

        .receipt-info-value {
            font-size: 0.95rem;
            color: #1a1a1a;
            font-weight: 600;
        }

        .receipt-body {
            padding: 1.5rem 1.5rem 2rem;
        }

        .paid-status {
            background: #f0fdf4;
            border: 1px solid #86efac;
            border-radius: 8px;
            padding: 0.875rem;
            text-align: center;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .paid-status i {
            color: #16a34a;
            font-size: 1.125rem;
        }

        .paid-status span {
            color: #16a34a;
            font-weight: 600;
            font-size: 0.95rem;
        }

        .items-section {
            margin-bottom: 1.5rem;
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
        }

        .items-table thead th {
            padding: 0.625rem 0.5rem;
            text-align: left;
            font-size: 0.75rem;
            font-weight: 600;
            color: #888;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 1px solid #e0e0e0;
        }

        .items-table thead th:nth-child(2) {
            text-align: center;
            width: 50px;
        }

        .items-table thead th:last-child {
            text-align: right;
        }

        .items-table tbody td {
            padding: 0.875rem 0.5rem;
            font-size: 0.95rem;
            color: #1a1a1a;
            border-bottom: 1px solid #f5f5f5;
        }

        .items-table tbody tr:last-child td {
            border-bottom: 1px solid #e0e0e0;
        }

        .item-name {
            font-weight: 500;
        }

        .item-qty {
            text-align: center;
            color: #666;
            font-weight: 400;
        }

        .item-price {
            text-align: right;
            font-weight: 600;
            color: #1a1a1a;
        }

        .summary-section {
            padding: 1rem 0;
            border-bottom: 2px dashed #e0e0e0;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.5rem 0;
        }

        .summary-label {
            font-size: 0.95rem;
            color: #666;
            font-weight: 400;
        }

        .summary-value {
            font-size: 0.95rem;
            color: #1a1a1a;
            font-weight: 500;
        }

        .total-row {
            padding-top: 1rem;
            margin-top: 0.5rem;
        }

        .total-label {
            font-size: 1.125rem;
            color: #1a1a1a;
            font-weight: 700;
        }

        .total-amount {
            font-size: 1.75rem;
            color: #1a1a1a;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .payment-info {
            padding: 1.5rem 0 0;
            text-align: center;
        }

        .payment-info-text {
            font-size: 0.875rem;
            color: #888;
            margin-bottom: 0.5rem;
        }

        .thank-you {
            font-size: 1rem;
            color: #1a1a1a;
            font-weight: 600;
            margin-top: 1rem;
        }

        .actions {
            display: flex;
            gap: 0.75rem;
            margin-top: 2rem;
        }

        .btn {
            flex: 1;
            padding: 0.875rem;
            border-radius: 6px;
            font-size: 0.95rem;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-primary {
            background: #1a1a1a;
            color: white;
            border: 2px solid #1a1a1a;
        }

        .btn-primary:hover {
            background: #333;
            border-color: #333;
        }

        .btn-success {
            background: #16a34a;
            color: white;
            border: 2px solid #16a34a;
        }

        .btn-success:hover {
            background: #15803d;
            border-color: #15803d;
        }

        .btn-outline {
            background: white;
            color: #dc2626;
            border: 2px solid #dc2626;
        }

        .btn-outline:hover {
            background: #dc2626;
            color: white;
        }

        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
        }

        .empty-state i {
            font-size: 3rem;
            color: #ccc;
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            color: #1a1a1a;
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 1.25rem;
        }

        .empty-state p {
            color: #666;
            margin-bottom: 2rem;
            font-size: 0.95rem;
        }

        @media print {
            body {
                background: white;
                padding: 0;
            }
            
            .receipt-container {
                box-shadow: none;
                max-width: 100%;
            }
            
            .actions {
                display: none;
            }
        }

        @media (max-width: 480px) {
            .receipt-container {
                max-width: 100%;
            }

            .receipt-header {
                padding: 1.5rem 1rem 0.75rem;
            }

            .receipt-body {
                padding: 1.25rem 1rem 1.5rem;
            }

            .total-amount {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>

<div class="receipt-container">
    <c:choose>
        <c:when test="${not empty orderInfo and not empty orderDetails}">
            <div class="receipt-header">
                <div class="restaurant-name">SHABU RESTAURANT</div>
                <div class="restaurant-subtitle">ใบเสร็จรับเงิน / Receipt</div>
                
                <div class="receipt-info">
                    <div class="receipt-info-item">
                        <div class="receipt-info-label">โต๊ะ / Table</div>
                        <div class="receipt-info-value">TA${orderInfo.table.tableid}</div>
                    </div>
                    <div class="receipt-info-item">
                        <div class="receipt-info-label">เลขที่ / No.</div>
                        <div class="receipt-info-value">O${orderInfo.oderId}</div>
                    </div>
                    <div class="receipt-info-item">
                        <div class="receipt-info-label">วันที่ / Date</div>
                        <div class="receipt-info-value">
                            <fmt:formatDate value="${orderInfo.orderDate}" pattern="dd/MM/yyyy HH:mm:ss" timeZone="Asia/Bangkok" />
                        </div>
                    </div>
                </div>
            </div>
    
            <div class="receipt-body">
                <%-- รวมทุกอย่างเข้าในฟอร์มเดียว --%>
                <form id="billForm" method="POST" action="processFinalPayment">
                    <input type="hidden" name="orderId" value="${orderInfo.oderId}">
                    
                    <div class="items-section">
                        <table class="items-table">
                            <thead>
                                <tr>
                                    <th>รายการ</th>
                                    <th style="text-align: center;">ราคา</th>
                                    <th style="text-align: center;">จำนวน</th>
                                    <th style="text-align: right;">รวม</th>
                                    <th style="text-align: center;">ลบ</th>
                                </tr>
                            </thead>
                            <tbody>
                               <c:forEach items="${orderDetails}" var="item" varStatus="status">
                                    <%-- เงื่อนไขเดิม: แสดงเฉพาะรายการที่มีราคา > 0 --%>
                                    <c:if test="${item.priceAtTimeOfOrder > 0}">
                                        <tr id="row_${item.odermenuId}" class="${status.first ? 'first-row' : ''}">
                                            <td>${item.menufood.foodname}</td>
                                            <td style="text-align: center;">
                                                ฿<span class="unit-price">${item.priceAtTimeOfOrder}</span>
                                                <input type="hidden" id="price_val_${item.odermenuId}" value="${item.priceAtTimeOfOrder}">
                                            </td>
                                            <td style="text-align: center;">
                                                <input type="number" name="quantity_${item.odermenuId}" 
                                                    id="qty_${item.odermenuId}" value="${item.quantity}" 
                                                    <%-- แถวแรกห้ามลดจำนวนจนเป็น 0 (ขั้นต่ำ 1) --%>
                                                    min="${status.first ? 1 : 0}" 
                                                    class="qty-input" oninput="calculateTotal()">
                                            </td>
                                            <td style="text-align: right;">
                                                ฿<span id="subtotal_${item.odermenuId}" class="subtotal-val">
                                                    <fmt:formatNumber value="${item.priceAtTimeOfOrder * item.quantity}" pattern="#,##0.00"/>
                                                </span>
                                            </td>
                                            <td style="text-align: center;">
                                                <%-- ถ้าเป็นแถวแรก (status.first) ให้ปิดการใช้งานปุ่มลบ หรือซ่อนปุ่ม --%>
                                                <c:choose>
                                                    <c:when test="${status.first}">
                                                        <button type="button" class="btn-delete" style="opacity: 0.3; cursor: not-allowed;" title="ไม่สามารถลบรายการหลักได้" disabled>
                                                            <i class="fas fa-ban"></i>
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="btn-delete" onclick="removeItem('${item.odermenuId}')">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
            
                    <div class="summary-section">
                        <div class="summary-row total-row">
                            <span class="total-label">ยอดรวมทั้งสิ้น</span>
                            <span class="total-amount">
                                ฿<span id="grandTotal"><fmt:formatNumber value="${totalPrice}" pattern="#,##0.00" /></span>
                            </span>
                        </div>
                    </div>

                    <div class="actions">
                        <c:if test="${!isPaid}">
                            <button type="submit" class="btn btn-success">ยืนยันชำระเงิน</button>
                            <a href="backToListOrder" class="btn btn-outline">ยกเลิก</a>
                        </c:if>
                    </div>
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <i class="fas fa-exclamation-circle"></i>
                <h3>ไม่พบข้อมูลออเดอร์</h3>
                <a href="homecashier" class="btn btn-primary">กลับหน้าหลัก</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function calculateTotal() {
        let grandTotal = 0;
        // ดึงทุกแถวที่มี id ขึ้นต้นด้วย row_
        const rows = document.querySelectorAll('tr[id^="row_"]');
        
        rows.forEach(row => {
            // คำนวณเฉพาะแถวที่ไม่ได้ถูกซ่อน (display !== 'none')
            if (row.style.display !== 'none') {
                const id = row.id.split('_')[1];
                const price = parseFloat(document.getElementById('price_val_' + id).value) || 0;
                const qty = parseInt(document.getElementById('qty_' + id).value) || 0;
                
                const subtotal = price * qty;
                
                // อัปเดตราคาย่อยรายบรรทัด
                const subtotalLabel = document.getElementById('subtotal_' + id);
                if (subtotalLabel) {
                    subtotalLabel.innerText = subtotal.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2});
                }
                
                grandTotal += subtotal;
            }
        });
        
        // อัปเดตราคารวมสุทธิ
        document.getElementById('grandTotal').innerText = grandTotal.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2});
    }

    function removeItem(id) {
        if (confirm('ยืนยันการลบรายการนี้?')) {
            const row = document.getElementById('row_' + id);
            const qtyInput = document.getElementById('qty_' + id);
            
            if (row && qtyInput) {
                row.style.display = 'none'; // ซ่อนแถว
                qtyInput.value = 0; // เซตจำนวนเป็น 0 เพื่อให้ Controller ลบใน DB
                calculateTotal(); // คำนวณเงินใหม่ทันที
            }
        }
    }
    
    // คำนวณครั้งแรกเมื่อโหลดหน้า
    window.onload = calculateTotal;
</script>

</body>
</html>