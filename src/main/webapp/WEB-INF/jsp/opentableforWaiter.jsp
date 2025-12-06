<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>จัดการโต๊ะอาหาร</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * { font-family: 'Kanit', sans-serif; box-sizing: border-box; }
        body { background-color: #f0f4f8; color: #333; padding: 20px; }
        .container { max-width: 1200px; margin: auto; }
        .home-button {
            display: inline-block;
            margin-bottom: 20px;
            padding: 10px 18px;
            background-color: #1a237e; /* สีน้ำเงินเข้ม */
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: background-color 0.2s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .home-button:hover {
            background-color: #3949ab;
        }
        h2 { color: #1a237e; text-align: center; margin-bottom: 30px; font-weight: 600; }
        .table-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }
        .table-card {
            background-color: #fff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: transform 0.2s;
        }
        .table-card:hover { transform: translateY(-5px); }
        
        /* Status Badges */
        .status-badge {
            display: inline-block;
            padding: 6px 15px;
            border-radius: 20px;
            font-weight: 500;
            margin-top: 10px;
            font-size: 0.95rem;
        }
        .status-Free { background-color: #4caf50; color: white; }
        .status-Occupied { background-color: #f44336; color: white; }
        .status-Already_reserved { background-color: #ffeb3b; color: #333; }
        .status-Cleaning { background-color: #2196f3; color: white; }
        .status-In_Use { background-color: #f44336; color: white; }

        .table-info {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
        }
        .table-capacity {
            color: #666;
            margin-top: 5px;
        }

        .action-button {
            display: block;
            margin-top: 15px;
            padding: 10px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            color: white;
            transition: background-color 0.2s;
        }
        .btn-check-in { background-color: #00bcd4; }
        .btn-check-in:hover { background-color: #0097a7; }
        .btn-finish { background-color: #ff9800; }
        .btn-finish:hover { background-color: #f57c00; }
        .btn-clean { background-color: #607d8b; }
        .btn-clean:hover { background-color: #455a64; }
        .btn-walk-in { 
             background-color: #4caf50; 
             margin-top: 15px;
        }
        .btn-walk-in:hover {
             background-color: #388e3c;
        }
        .btn-no-action {
             background-color: #9e9e9e; 
             cursor: default;
             text-decoration: none;
        }
        .btn-no-action:hover {
            background-color: #9e9e9e;
        }
        /* NEW QR STYLE */
        .qr-display {
            margin: 10px 0;
            padding: 5px;
            border: 1px dashed #ccc;
            border-radius: 5px;
        }
        .qr-display img {
            width: 100px;
            height: 100px;
            display: block;
            margin: auto;
        }
        /* NEW PRINT BUTTON STYLE */
        .btn-print { 
             background-color: #7b1fa2; /* ม่วงเข้ม */
             margin-top: 5px; 
             font-size: 0.85rem; /* ทำให้ปุ่มไม่ใหญ่เกินไป */
        }
        .btn-print:hover {
             background-color: #5d00a8;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="gohome" class="home-button">
            <i class="fas fa-home"></i> 🏠 กลับหน้าหลัก
        </a>
        
        <h2><i class="fas fa-table"></i> สถานะและการจัดการโต๊ะอาหาร</h2>
        
        <c:if test="${not empty successMessage}">
            <div style="background-color: #d4edda; color: #155724; padding: 15px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
                ${successMessage}
            </div>
        </c:if>

        <div class="table-grid">
            <c:forEach var="table" items="${tables}">
                <div class="table-card">
                    <div class="table-info">โต๊ะ ${table.tableid}</div>
                    <div class="table-capacity"><i class="fas fa-users"></i> ${table.capacity} ที่นั่ง</div>
                    
                    <%-- ใช้ fn:replace เพื่อจัดการช่องว่างในชื่อสถานะสำหรับ CSS --%>
                    <c:set var="statusCss" value="${fn:replace(table.status, ' ', '_')}" /> 
                    <div class="status-badge status-${statusCss}">${table.status}</div>

                    <c:choose>
                        
                        <%-- 1. โต๊ะว่าง -> เปิดโต๊ะ Walk-in (ไม่ต้องแสดง QR) --%>
						<c:when test="${table.status == 'Free'}">
						    <a href="gotoOpenTable?tableid=${table.tableid}" 
						       class="action-button btn-walk-in">เปิดโต๊ะ (Walk-in)</a>
						</c:when>

                        <%-- VVVV 2. โต๊ะถูกจอง/ใช้งาน -> แสดง QR และแสดงปุ่ม Action VVVV --%>
                        <c:when test="${table.status == 'Already reserved' || table.status == 'Occupied' || table.status == 'In Use'}">
                            
                            <%-- ✅ โค้ดแสดง QR Code จะอยู่ตรงนี้เท่านั้น! ✅ --%>
                            <c:if test="${not empty table.qrToken}">
                                <div class="qr-display">
                                    <img src="generateQrForTable?token=${table.qrToken}" 
                                         alt="QR Code for Table ${table.tableid}" 
                                    />
                                </div>
                            </c:if>

                            <c:choose>
                                <c:when test="${table.status == 'Already reserved'}">
                                    <a href="gotoViewReservations" 
                                       class="action-button btn-check-in">ไปหน้า Check-in การจอง</a>
                                </c:when>
                                
                                <c:when test="${table.status == 'Occupied'}">
                                    <a href="#" 
                                       onclick="window.open('findAndPrintOrder?tableId=${table.tableid}', '_blank', 'width=600,height=800'); return false;" 
                                       class="action-button btn-print">
                                        <i class="fas fa-print"></i> พิมพ์ Order Info
                                    </a>
                                    <a href="updateTableStatus?tableid=${table.tableid}&status=Cleaning" 
                                       class="action-button btn-finish">ลูกค้าเสร็จสิ้น (ไปทำความสะอาด)</a>
                                </c:when>
                            </c:choose>
                            
                        </c:when>
                        
                        <%-- 3. โต๊ะรอทำความสะอาด (Cleaning) -> เสร็จสิ้น (ไม่ต้องแสดง QR) --%>
                        <c:when test="${table.status == 'Cleaning'}">
                            <a href="updateTableStatus?tableid=${table.tableid}&status=Free" 
                               class="action-button btn-clean">ทำความสะอาดเสร็จสิ้น</a>
                        </c:when>
                        
                        <%-- 4. สถานะอื่นๆ (ไม่มี action) --%>
                        <c:otherwise>
                            <span class="action-button btn-no-action">ไม่มี Action ที่เกี่ยวข้อง</span>
                        </c:otherwise>
                        
                    </c:choose>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>