<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ใบเสร็จชำระเงิน - ShaBu Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Kanit', sans-serif;
        }

        :root {
            --primary: #6366f1;
            --success: #10b981;
            --danger: #ef4444;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-600: #4b5563;
            --gray-900: #111827;
        }

        body {
            background: var(--gray-50);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .receipt-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 480px;
            overflow: hidden;
        }

        .receipt-header {
            background: linear-gradient(135deg, var(--primary), #8b5cf6);
            color: white;
            padding: 2rem 1.5rem;
            text-align: center;
        }

        .receipt-header i {
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            opacity: 0.9;
        }

        .receipt-header h1 {
            font-size: 1.25rem;
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .receipt-header .order-id {
            font-size: 0.875rem;
            opacity: 0.9;
            font-weight: 300;
        }

        .order-date {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 1rem;
            font-size: 0.875rem;
            opacity: 0.95;
        }

        .receipt-body {
            padding: 1.5rem;
        }

        .items-table {
            width: 100%;
            margin-bottom: 1.5rem;
        }

        .items-table thead {
            border-bottom: 2px solid var(--gray-100);
        }

        .items-table th {
            padding: 0.75rem 0.5rem;
            text-align: left;
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--gray-600);
            text-transform: uppercase;
            letter-spacing: 0.025em;
        }

        .items-table th:last-child,
        .items-table td:last-child {
            text-align: right;
        }

        .items-table th:nth-child(2),
        .items-table td:nth-child(2) {
            text-align: center;
            width: 60px;
        }

        .items-table tbody tr {
            border-bottom: 1px solid var(--gray-100);
        }

        .items-table tbody tr:last-child {
            border-bottom: none;
        }

        .items-table td {
            padding: 1rem 0.5rem;
            font-size: 0.95rem;
            color: var(--gray-900);
        }

        .item-name {
            font-weight: 500;
        }

        .item-qty {
            color: var(--gray-600);
        }

        .item-price {
            font-weight: 600;
            color: var(--gray-900);
        }

        .total-section {
            background: var(--gray-50);
            border-radius: 12px;
            padding: 1.25rem;
            margin-bottom: 1.5rem;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-label {
            font-size: 1.125rem;
            font-weight: 500;
            color: var(--gray-900);
        }

        .total-amount {
            font-size: 1.75rem;
            font-weight: 600;
            color: var(--primary);
        }

        .paid-badge {
            background: linear-gradient(135deg, var(--success), #059669);
            color: white;
            padding: 1rem;
            border-radius: 12px;
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .paid-badge i {
            font-size: 1.25rem;
        }

        .actions {
            display: flex;
            gap: 0.75rem;
        }

        .btn {
            flex: 1;
            padding: 0.875rem;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-primary {
            background: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background: #4f46e5;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(99, 102, 241, 0.4);
        }

        .btn-success {
            background: var(--success);
            color: white;
        }

        .btn-success:hover {
            background: #059669;
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.4);
        }

        .btn-outline {
            background: white;
            color: var(--danger);
            border: 1.5px solid var(--danger);
        }

        .btn-outline:hover {
            background: var(--danger);
            color: white;
            transform: translateY(-1px);
        }

        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
        }

        .empty-state i {
            font-size: 3.5rem;
            color: var(--gray-600);
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .empty-state h3 {
            color: var(--gray-900);
            font-weight: 500;
            margin-bottom: 0.5rem;
            font-size: 1.25rem;
        }

        .empty-state p {
            color: var(--gray-600);
            margin-bottom: 2rem;
        }

        @media (max-width: 480px) {
            .receipt-container {
                max-width: 100%;
            }

            .receipt-header {
                padding: 1.5rem 1rem;
            }

            .receipt-body {
                padding: 1rem;
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
                    <i class="fas fa-receipt"></i>
                    <h1>โต๊ะ TA${orderInfo.table.tableid}</h1>
                    <div class="order-id">เลขที่ใบเสร็จ O${orderInfo.oderId}</div>
                    <div class="order-date">
                        <i class="fas fa-calendar-alt"></i>
                        <fmt:formatDate value="${orderInfo.orderDate}" pattern="dd/MM/yyyy" />
                    </div>
                </div>
        
                <div class="receipt-body">
                    
                    <c:if test="${isPaid}">
                        <div class="paid-badge">
                            <i class="fas fa-check-circle"></i>
                            <span>ชำระเงินเรียบร้อยแล้ว</span>
                        </div>
                    </c:if>

                    <table class="items-table">
                        <thead>
                            <tr>
                                <th>รายการ</th>
                                <th>จำนวน</th>
                                <th>ราคา</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orderDetails}" var="item">
                                <c:if test="${item.priceAtTimeOfOrder > 1.0}">
                                    <tr>
                                        <td class="item-name">${item.menufood.foodname}</td> 
                                        <td class="item-qty">${item.quantity}</td>
                                        <td class="item-price">
                                            ฿<fmt:formatNumber value="${item.priceAtTimeOfOrder * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
        
                    <div class="total-section">
                        <div class="total-row">
                            <span class="total-label">รวมทั้งสิ้น</span>
                            <span class="total-amount">
                                ฿<fmt:formatNumber value="${totalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                            </span>
                        </div>
                    </div>
        
                    <div class="actions">
                        <c:if test="${isPaid}">
                            <a href="backToPastBills" class="btn btn-primary">กลับไปหน้ารายการบิล</a>
                        </c:if>
                        <c:if test="${!isPaid}">
                            <form action="processFinalPayment" method="POST" style="flex: 1;">
                                <input type="hidden" name="orderId" value="${orderInfo.oderId}">
                                <button type="submit" class="btn btn-success" style="width: 100%;">ยืนยันชำระเงิน</button>
                            </form>
                            <a href="backToListOrder" class="btn btn-outline">ยกเลิก</a>
                        </c:if>
                    </div>

                </div>

            </c:when>
            
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-exclamation-circle"></i>
                    <h3>ไม่พบข้อมูลออเดอร์</h3>
                    <p>กรุณาตรวจสอบเลขที่ออเดอร์อีกครั้ง</p>
                    <a href="welcomeCashier.jsp" class="btn btn-primary" style="max-width: 200px; margin: 0 auto;">กลับหน้าหลัก</a>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>