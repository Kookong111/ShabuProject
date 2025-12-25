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

        :root {
            --primary-color: #5d00a8;
            --secondary-color: #f7f3ff;
            --accent-color: #22c55e;
            --text-color: #333;
            --white: #ffffff;
            --shadow: 0 10px 30px rgba(93, 0, 168, 0.2);
        }

        body {
            background: linear-gradient(135deg, var(--secondary-color) 0%, #e0e7ff 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            color: var(--text-color);
        }

        .receipt-container {
            background: var(--white);
            border-radius: 20px;
            box-shadow: var(--shadow);
            width: 100%;
            max-width: 550px;
            padding: 2.5rem;
            position: relative;
            overflow: hidden;
        }

        .receipt-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
        }

        .receipt-header {
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid var(--secondary-color);
            position: relative;
        }

        .receipt-header::after {
            content: '🍜';
            font-size: 2rem;
            position: absolute;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--white);
            padding: 0 10px;
        }

        .receipt-header h1 {
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary-color);
            margin: 0;
            line-height: 1.4;
        }

        .order-date {
            font-size: 0.95rem;
            color: #666;
            margin-top: 1rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .order-date i {
            color: var(--primary-color);
        }

        .receipt-details {
            margin: 2rem 0;
            background: var(--secondary-color);
            border-radius: 12px;
            padding: 1.5rem;
        }

        .receipt-details table {
            width: 100%;
            border-collapse: collapse;
        }

        .receipt-details thead th {
            padding: 1rem 0.5rem;
            text-align: left;
            font-weight: 600;
            color: var(--primary-color);
            font-size: 0.95rem;
            border-bottom: 2px solid var(--primary-color);
        }

        .receipt-details thead th.col-qty,
        .receipt-details thead th.col-total {
            text-align: right;
        }

        .receipt-details tbody td {
            padding: 1rem 0.5rem;
            color: var(--text-color);
            font-size: 1rem;
            font-weight: 500;
            border-bottom: 1px solid rgba(93, 0, 168, 0.1);
        }

        .receipt-details tbody tr:last-child td {
            border-bottom: none;
        }

        .receipt-details tbody tr:hover {
            background: rgba(93, 0, 168, 0.05);
            border-radius: 8px;
        }

        .col-name {
            width: 50%;
            text-align: left;
            font-weight: 600;
        }

        .col-qty {
            width: 20%;
            text-align: right;
            color: var(--primary-color);
        }

        .col-total {
            width: 30%;
            text-align: right;
            font-weight: 700;
            color: var(--accent-color);
        }

        .receipt-total {
            margin-top: 2rem;
            padding: 1.5rem;
            background: linear-gradient(135deg, var(--primary-color), #7b00e0);
            border-radius: 12px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            color: var(--white);
            box-shadow: 0 4px 15px rgba(93, 0, 168, 0.3);
        }

        .receipt-total .label {
            font-size: 1.2rem;
            font-weight: 600;
        }

        .receipt-total .amount {
            font-size: 1.8rem;
            font-weight: 700;
        }

        .receipt-actions {
            margin-top: 2.5rem;
            display: flex;
            gap: 1rem;
            justify-content: center;
        }

        .action-btn {
            padding: 0.8rem 2rem;
            font-size: 1rem;
            min-width: 120px;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            text-align: center;
            transition: all 0.3s ease;
            border: 2px solid;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }

        .action-btn:hover::before {
            left: 100%;
        }

        .btn-confirm {
            background: var(--accent-color);
            border-color: var(--accent-color);
            color: var(--white);
            box-shadow: 0 4px 15px rgba(34, 197, 94, 0.4);
        }

        .btn-confirm:hover {
            background: #16a34a;
            border-color: #16a34a;
            box-shadow: 0 6px 20px rgba(34, 197, 94, 0.6);
            transform: translateY(-2px);
        }

        .btn-cancel {
            background: transparent;
            border-color: var(--primary-color);
            color: var(--primary-color);
            box-shadow: 0 4px 15px rgba(93, 0, 168, 0.2);
        }

        .btn-cancel:hover {
            background: var(--primary-color);
            color: var(--white);
            box-shadow: 0 6px 20px rgba(93, 0, 168, 0.4);
            transform: translateY(-2px);
        }

        .paid-status {
            text-align: center;
            margin-bottom: 2rem;
            padding: 1rem;
            background: linear-gradient(135deg, var(--accent-color), #16a34a);
            color: var(--white);
            border-radius: 12px;
            font-weight: 600;
            font-size: 1.1rem;
            box-shadow: 0 4px 15px rgba(34, 197, 94, 0.3);
        }

        .paid-status i {
            margin-right: 0.5rem;
        }
        
        
        .btn-cancel:hover { 
            background: #dc2626;
            box-shadow: 0 6px 16px rgba(239, 68, 68, 0.4);
            transform: translateY(-2px);
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            color: #666;
        }

        .empty-state i {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .empty-state h3 {
            color: var(--text-color);
            font-weight: 600;
            margin-bottom: 1rem;
        }

        @media (max-width: 480px) {
            .receipt-container {
                padding: 2rem 1.5rem;
                max-width: 420px;
                margin: 10px;
            }

            .receipt-header h1 {
                font-size: 1.2rem;
            }

            .action-btn {
                padding: 0.8rem 1.5rem;
                font-size: 0.95rem;
                min-width: 100px;
            }

            .receipt-total {
                padding: 1rem;
                flex-direction: column;
                gap: 0.5rem;
                text-align: center;
            }

            .receipt-total .amount {
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
                    
                    <h1>
                        <i class="fas fa-receipt"></i><br>
                        เช็คบิลโต๊ะ: TA${orderInfo.table.tableid}<br>
                        <small>เลขที่ใบเสร็จ O${orderInfo.oderId}</small>
                    </h1>
                    
                    <div class="order-date">
                        <i class="fas fa-calendar-alt"></i>
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
                    <c:if test="${isPaid}">
                        <div class="paid-status">
                            <i class="fas fa-check-circle"></i> ชำระเงินเรียบร้อยแล้ว
                        </div>
                        <a href="backToPastBills" class="action-btn btn-confirm">กลับไปหน้ารายการบิล</a>
                    </c:if>
                    <c:if test="${!isPaid}">
                        <form action="processFinalPayment" method="POST" style="display: contents;">
                            <input type="hidden" name="orderId" value="${orderInfo.oderId}">
                            <button type="submit" class="action-btn btn-confirm">เช็คบิล</button>
                        </form>
                        <a href="backToListOrder" class="action-btn btn-cancel">ยกเลิก</a>
                    </c:if>
                </div>

            </c:when>
            
            <c:otherwise>
                <div class="empty-state">
                    <i class="fas fa-exclamation-triangle"></i>
                    <h3>ไม่พบข้อมูลออเดอร์</h3>
                    <p>กรุณาตรวจสอบเลขที่ออเดอร์อีกครั้ง</p>
                    <div class="receipt-actions">
                        <a href="welcomeCashier.jsp" class="action-btn btn-cancel">กลับหน้าหลัก</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </div>

</body>
</html>