<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ใบเสร็จชำระเงิน</title>
    <link href="https://fonts.googleapis.com/css2?family=Prompt:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Prompt', sans-serif;
        }

        body {
            background: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
            /* ซ่อน body จนกว่า JavaScript จะโหลด */
            opacity: 0; 
            transition: opacity 0.5s ease-in-out;
        }
        
        /* [NEW] Loading Overlay CSS */
        #loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.95);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            transition: opacity 0.4s ease, visibility 0.4s ease;
        }

        .loader {
            border: 5px solid #f3f3f3;
            border-top: 5px solid #555;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        /* [END] Loading Overlay CSS */

        .receipt-container {
            background: #ffffff;
            /* ขอบโค้งมนมากขึ้น (24px) */
            border-radius: 24px; 
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 550px;
            padding: 20px 25px; 
            text-align: center;
        }

        .receipt-header {
            margin-bottom: 25px;
            padding-bottom: 15px;
          
        }
        
        .header-status {
            display: none; 
        }

        /* [MODIFIED] ลบเส้นใต้ h1 */
        .receipt-header h1 {
            font-size: 1.5rem; 
            color: #333;
            font-weight: 600;
            margin-bottom: 5px;
            padding-bottom: 0; /* ลบ padding */
            border-bottom: none; /* ลบเส้น */
        }
        
        /* [MODIFIED] ส่วน "เลขที่ใบเสร็จ..." */
        .receipt-header p {
            font-size: 1.2rem; 
            color: #333; 
            font-weight: 600; 
            margin-bottom: 15px;
            padding-bottom: 15px;
            /* คงเส้นที่ย้ายลงมาไว้ */
            border-bottom: 1px solid #ccc; 
            margin-top: 15px; 
        }

        /* [MODIFIED] ส่วนที่อยู่ */
        .store-info {
            font-size: 0.9rem;
            color: #777;
            margin-top: 0; 
            margin-bottom: 25px;
            padding-bottom: 40px;
            /* คงเส้นใต้ที่อยู่ไว้ */
            border-bottom: 1px solid #ccc;
        }
        
        .order-details {
            text-align: left;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: none; 
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
            font-size: 0.95rem;
            line-height: 1.2;
        }
        
        .label {
             color: #333;
             font-weight: 400;
             width: 40%;
          
        }

        .value {
             color: #333;
             font-weight: 500;
             text-align: right;
             width: 60%;
        }
        
        .items-table {
            margin-bottom: 20px;
            font-size: 0.95rem;
        }

        .items-table table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
        }

        .items-table th, .items-table td {
            padding: 8px 0;
            line-height: 1.2;
            border-bottom: none !important;
        }
        
        .items-table thead tr th {
            font-weight: 500;
            color: #333;
            border-bottom: none;
            /* ใช้เส้นบางสีเทาอ่อน */
            border-top: 1px solid #ccc;
            padding-top: 5px;
            padding-bottom: 5px;
            font-size: 0.9rem;
        }
        
        .items-table tbody tr {
            border-bottom: none !important;
        }
        
        .items-table .col-name { width: 55%; }
        .items-table .col-qty { width: 15%; text-align: center; }
        .items-table .col-total { width: 30%; text-align: right; }
        
        .total-section {
            padding-top: 15px;
            border-top: none; 
            margin-bottom: 0;
            text-align: right;
            
        }

        .total-row {
            display: flex;
            justify-content: flex-end; 
            align-items: center;
            font-size: 1.1rem;
            color: #000;
          
            
            /* คงเส้นหนาใต้ราคารวม */
            border-bottom: 1px solid #ccc;
            padding-bottom: 5px;
        }
        
        .total-row .label {
            font-weight: 600;
            width: auto;
            margin-right: 20px;
        }

        .total-row .amount {
            font-weight: 700;
            font-size: 1.3rem;
            width: auto;
        }

        .thank-you {
            margin-top: 25px;
            margin-bottom: 25px;
            padding-top: 10px;
            border-top: none;
        }
        
        .thank-you h2 {
            font-size: 1rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 5px;
        }

        .thank-you p {
            font-size: 0.85rem;
            font-weight: 400; 
            color: #555;
        }

        .receipt-actions {
            margin-top: 20px;
        }

        .btn-print, .btn-home {
            display: block;
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            font-size: 15px;
            font-weight: 500;
            text-align: center;
            text-decoration: none;
            margin-bottom: 8px;
        }

        .btn-print {
            background-color: #555;
            color: #ffffff;
            border: none;
        }

        .btn-home {
            background-color: #f0f0f0;
            color: #333;
            border: 1px solid #ddd;
        }
        
        @media print {
            body { background: none; }
            .receipt-container {
                box-shadow: none;
                max-width: none;
            }
            .receipt-actions { display: none; } 
        }
    </style>
</head>
<body>
    
    <div id="loading-overlay">
        <div class="loader"></div>
    </div>
    
    <div class="receipt-container">
        <c:if test="${not empty paymentInfo}">
            
            <c:set var="guestCount" value="1" /> 
            <c:forEach items="${orderDetails}" var="item">
                <c:if test="${fn:contains(fn:toLowerCase(item.menufood.foodname), 'บุฟเฟต์')}">
                    <c:set var="guestCount" value="${item.quantity}" />
                </c:if>
            </c:forEach>

            <div class="header-status">
                <i class="fas fa-check-circle"></i> 
                <h1>ชำระเงินสำเร็จ</h1>
            </div>

            <div class="receipt-header">
                <h1>ใบเสร็จชำระเงิน</h1>
                <p>เลขที่ใบเสร็จ #${paymentInfo.paymentId} โต๊ะ ${paymentInfo.orders.table.tableid}</p>
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
                    <span class="label">Guests :</span>
                    <span class="value">${guestCount}</span>
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
                
            </div>

            <div class="items-table">
                <table>
                    <thead>
                        <tr>
                            <th class="col-name">Name</th>
                            <th class="col-qty" style="text-align: center;">Qty</th>
                            <th class="col-total" style="text-align: right;">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderDetails}" var="item">
                            <c:if test="${item.priceAtTimeOfOrder > 1.0}">
                                <tr>
                                    <td class="col-name">${item.menufood.foodname}</td>
                                    <td class="col-qty" style="text-align: center;">${item.quantity}</td>
                                    <td class="col-total" style="text-align: right;">
                                        <fmt:formatNumber value="${item.priceAtTimeOfOrder * item.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2" />
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                    </tbody>
                </table>
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
                
                <p>ขอบคุณที่ใช้บริการ Thankyou</p>
            </div>
            
            <div class="receipt-actions">
                <button type="button" class="btn-print" onclick="window.print()">ปริ้นใบเสร็จ</button>
                <a href="homecashier" class="btn-home">กลับหน้าหลัก</a>
            </div>

        </c:if>
        
        <c:if test="${empty paymentInfo}">
             <div style="padding: 20px; color: red;">ไม่พบข้อมูลการชำระเงิน</div>
        </c:if>
    </div>
    
    <script>
        // [NEW] JavaScript เพื่อซ่อน Loading Overlay เมื่อหน้าโหลดเสร็จ
        window.addEventListener('load', function() {
            const overlay = document.getElementById('loading-overlay');
            const body = document.body;

            // 1. ทำให้เนื้อหาหลักของ body แสดงผล
            body.style.opacity = '1'; 

            // 2. ซ่อน overlay ด้วย animation
            overlay.style.opacity = '0';
            
            // 3. ลบ overlay ออกจาก DOM หลังจาก animation จบ
            setTimeout(() => {
                overlay.style.visibility = 'hidden';
            }, 400); 
        });

        // หาก JavaScript ทำงานได้ไม่สมบูรณ์ (เช่น เกิด error) ให้แสดง body ทันที
        document.addEventListener('DOMContentLoaded', function() {
             document.body.style.opacity = '1';
        });
    </script>
</body>
</html>