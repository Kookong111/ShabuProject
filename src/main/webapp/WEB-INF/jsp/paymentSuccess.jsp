<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ชำระเงินสำเร็จ</title>
    <link href="https://fonts.googleapis.com/css2?family=Prompt:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Prompt', sans-serif;
            background: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .receipt-container {
            background: #ffffff;
            border-radius: 24px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            width: 100%;
            max-width: 480px;
            padding: 2.5rem 2rem;
            border: 1px solid #e5e7eb;
        }

        .receipt-header {
            text-align: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .receipt-header h1 {
            font-size: 1.3rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.75rem;
        }

        .receipt-header .order-info {
            font-size: 1.1rem;
            font-weight: 500;
            color: #6b7280;
        }

        .store-info {
            text-align: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .store-info p {
            font-size: 0.9rem;
            color: #6b7280;
            line-height: 1.6;
            margin: 0.25rem 0;
        }

        .order-details {
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0.4rem 0;
            font-size: 0.95rem;
        }

        .detail-row .label {
            color: #6b7280;
            font-weight: 400;
        }

        .detail-row .value {
            color: #1f2937;
            font-weight: 500;
        }

        .items-table {
            margin-bottom: 1.5rem;
        }

        .items-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .items-table thead th {
            padding: 0.75rem 0.5rem;
            text-align: left;
            font-weight: 500;
            color: #6b7280;
            font-size: 0.95rem;
        }

        .items-table thead th.col-qty,
        .items-table thead th.col-total {
            text-align: right;
        }

        .items-table tbody td {
            padding: 0.75rem 0.5rem;
            color: #1f2937;
            font-size: 0.95rem;
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

        .total-section {
            text-align: right;
            margin-bottom: 1.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }

        .total-section .total-row {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 2rem;
            margin-top: 0.5rem;
        }

        .total-section .label {
            font-size: 1.1rem;
            font-weight: 600;
            color: #1f2937;
        }

        .total-section .amount {
            font-size: 1.3rem;
            font-weight: 700;
            color: #1f2937;
        }

        .thank-you {
            text-align: center;
        }

        .thank-you h2 {
            font-size: 1.2rem;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 0.5rem;
        }

        .thank-you p {
            font-size: 0.95rem;
            color: #6b7280;
            font-weight: 400;
        }

        .btn-home {
            display: block;
            margin: 1rem auto 0; /* <<< ปรับ margin จาก 2rem เป็น 1rem */
            padding: 0.75rem 2.5rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            background: #3b82f6;
            color: white;
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
            transition: all 0.3s ease;
            text-align: center;
        }

        .btn-home:hover {
            background: #2563eb;
            box-shadow: 0 6px 16px rgba(59, 130, 246, 0.4);
            transform: translateY(-2px);
        }

        /* --- CSS สำหรับปุ่มปริ้นที่เพิ่มเข้ามา --- */
        .btn-print {
            display: block;
            width: 100%; /* ทำให้ปุ่มเต็มความกว้างเหมือนปุ่ม home */
            box-sizing: border-box; /* เพื่อให้ padding ไม่ล้น */
            margin: 2rem auto 0;
            padding: 0.75rem 2.5rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            font-size: 1rem;
            border: none;
            cursor: pointer;
            background: #6b7280; /* สีเทา */
            color: white;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transition: all 0.3s ease;
            text-align: center;
        }

        .btn-print:hover {
            background: #4b5563; /* สีเทาเข้ม */
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.15);
            transform: translateY(-2px);
        }
        /* ---------------------------------- */


        @media (max-width: 480px) {
            .receipt-container {
                padding: 2rem 1.5rem;
            }
        }
        
        /* --- CSS สำหรับซ่อนปุ่มตอนสั่งพิมพ์ --- */
        @media print {
            body {
                background: #ffffff;
                padding: 0;
            }
            .receipt-container {
                box-shadow: none;
                border: none;
                width: 100%;
                max-width: 100%;
            }
            .btn-home, .btn-print {
                display: none;
            }
        }
        /* --------------------------------- */

    </style>
</head>
<body>
    <div class="receipt-container">
        <c:if test="${not empty paymentInfo}">
            
            <div class="receipt-header">
                <h1>ใบเสร็จชำระเงิน</h1>
                <p class="order-info">เลขที่ใบเสร็จ # ${paymentInfo.orders.oderId} โต๊ะ: ${paymentInfo.orders.table.tableid}</p>
            </div>

            <div class="store-info">
                <p>63 ตำบลหนองพาร อำเภอสันทราย เชียงใหม่ 50290</p>
                <p>Tel. 022-222-2222</p>
            </div>

            <div class="order-details">
                <div class="detail-row">
                    <span class="label">Table :</span>
                    <span class="value">${paymentInfo.orders.table.tableid}</span>
                </div>
               
                <div class="detail-row">
                    <span class="label">Cashier :</span>
                    <span class="value">${paymentInfo.employees.empname}</span>
                </div>
                <div class="detail-row">
                    <span class="label">Date :</span>
                    <span class="value">
                        <fmt:formatDate value="${paymentInfo.paymentDate}" pattern="dd/MM/yyyy" />
                    </span>
                </div>
                <div class="detail-row">
                    <span class="label">Time :</span>
                    <span class="value">
                        <fmt:formatDate value="${paymentInfo.paymentDate}" pattern="HH:mm" />
                    </span>
                </div>
            </div>

            <div class="total-section">
                <div class="total-row">
                    <span class="label">รวมทั้งสิ้น</span>
                    <span class="amount">
                        <fmt:formatNumber value="${paymentInfo.totalPrice}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                    </span>
                </div>
            </div>

            <div class="thank-you">
                <h2>กำนันไข่</h2>
                <p>ขอบคุณที่ใช้บริการ Thankyou</p>
            </div>

            <button type="button" class="btn-print" onclick="window.print()">ปริ้นใบเสร็จ</button>
            
            <a href="homecashier" class="btn-home">กลับหน้าหลัก</a>

        </c:if>
    </div>
</body>
</html>