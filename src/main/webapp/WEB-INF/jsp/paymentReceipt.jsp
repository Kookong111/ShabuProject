<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ใบเสร็จชำระเงิน</title>
    <link href="https://fonts.googleapis.com/css2?family=Prompt:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Prompt', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .receipt-container {
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 520px;
            padding: 2.5rem 2.5rem;
        }

        .receipt-header {
            text-align: center;
            margin-bottom: 1rem;
            /* ▼▼▼ 2. ลด padding-bottom เพื่อให้เส้นขยับเข้าหาวันที่ ▼▼▼ */
            padding-bottom: 0.75rem;
            /* ▲▲▲ สิ้นสุดการแก้ไข ▲▲▲ */
            border-bottom: 1px solid #e5e7eb;
        }

        .receipt-header h1 {
            font-size: 1.1rem;
            font-weight: 500;
            color: #6b7280;
            line-height: 1.8;
            margin: 0;
        }
        
        .order-date {
            text-align: left;
            font-size: 0.9rem;
            color: #8a94a2;
            /* ▼▼▼ 1. เพิ่ม margin-top เพื่อดันวันที่ "ลงมา" ▼▼▼ */
            margin-top: 1.25rem;
            /* ▲▲▲ สิ้นสุดการแก้ไข ▲▲▲ */
            padding-left: 0.5rem;
            font-weight: 500;
        }

        .receipt-details {
            margin-bottom: 1.5rem;
            margin-top: 1.5rem;
        }

        .receipt-details table {
            width: 100%;
            border-collapse: collapse;
        }

        .receipt-details thead th {
            padding: 0.75rem 0.5rem;
            text-align: left;
            font-weight: 500;
            color: #6b7280;
            font-size: 0.95rem;
            border-bottom: none;
        }
        
        .receipt-details thead th.col-qty,
        .receipt-details thead th.col-total {
            text-align: right;
        }

        .receipt-details tbody td {
            padding: 1rem 0.5rem;
            color: #1f2937;
            font-size: 1rem;
            font-weight: 400;
        }

        .col-name { 
            width: 50%;
            text-align: left;
        }
        
        .col-qty  { 
            width: 20%;
            text-align: right;
        }
        
        .col-total{ 
            width: 30%;
            text-align: right;
            font-weight: 500;
        }

        .receipt-total {
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid #e5e7eb;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .receipt-total .label {
            font-size: 1.1rem;
            font-weight: 500;
            color: #1f2937;
        }

        .receipt-total .amount {
            font-size: 1.3rem;
            font-weight: 700;
            color: #1f2937;
        }

        .receipt-actions {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .action-btn {
            padding: 0.65rem 1.8rem;
            font-size: 0.9rem;
            min-width: 100px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            text-align: center;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .btn-confirm {
            background: #22c55e;
            color: white;
            box-shadow: 0 4px 12px rgba(34, 197, 94, 0.3);
        }
        
        .btn-confirm:hover { 
            background: #16a34a;
            box-shadow: 0 6px 16px rgba(34, 197, 94, 0.4);
            transform: translateY(-2px);
        }

        .btn-cancel {
            background: #ef4444;
            color: white;
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }
        
        .btn-cancel:hover { 
            background: #dc2626;
            box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
            transform: translateY(-2px);
        }
        
        .empty-state {
            text-align: center;
            padding: 2rem;
        }
        
        .empty-state h3 {
            color: #6b7280;
            font-weight: 500;
            margin-bottom: 2rem;
        }

        @media (max-width: 480px) {
            .receipt-container {
                padding: 2rem 1.5rem;
                max-width: 420px;
            }

            .action-btn {
                padding: 0.65rem 1.8rem;
                font-size: 0.9rem;
                min-width: 100px;
            }
        }
    </style>
</head>
<body>

    <div class="receipt-container">

        <c:choose>
            <c:when test="${not empty orderInfo and not empty orderDetails}">
                
                <div class="receipt-header">
                    
                    <h1>
                        เช็คบิลโต๊ะ: TA${orderInfo.table.tableid} เลขที่ใบเสร็จ O${orderInfo.oderId}
                    </h1>
                    
                    <div class="order-date">
                        วันที่: <fmt:formatDate value="${orderInfo.orderDate}" pattern="dd/MM/yyyy" />
                    </div>
                </div>
        
                <div class="receipt-details">
                    <table>
                        <thead>
                            <tr>
                                <th class="col-name">Name</th>
                                <th class="col-qty">Qty</th>
                                <th class="col-total">Total</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${orderDetails}" var="item">
                                <c:if test="${item.priceAtTimeOfOrder > 1.0}">
                                    <tr>
                                        <td class="col-name">${item.menufood.foodname}</td> 
                                        <td class="col-qty">${item.quantity}</td>
                                        <td class="col-total">
                                            <fmt:formatNumber value="${item.priceAtTimeOfOrder * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                        </td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
        
                <div class="receipt-total">
                    <span class="label">รวมทั้งสิ้น</span>
                    <span class="amount">
                        <fmt:formatNumber value="${totalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                    </span>
                </div>
        
                <div class="receipt-actions">
                    <form action="processFinalPayment" method="POST" style="display: contents;">
                        <input type="hidden" name="orderId" value="${orderInfo.oderId}">
                        <button type="submit" class="action-btn btn-confirm">เช็คบิล</button>
                    </form>
                    
                    <a href="backToListOrder" 
                    class="action-btn btn-cancel">ยกเลิก</a>
                </div>

            </c:when>
            
            <c:otherwise>
                <div class="empty-state">
                    <h3>ไม่พบข้อมูลออเดอร์</h3>
                    <div class="receipt-actions">
                        <a href="homecashier" class="action-btn btn-cancel">กลับหน้าหลัก</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>