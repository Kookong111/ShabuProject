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
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
        <style>
            .table-filter-bar {
                display: flex;
                gap: 10px;
                margin-bottom: 28px;
                flex-wrap: wrap;
                align-items: center;
            }
            .table-filter-btn {
                background: #f1f5f9;
                color: #34495e;
                border: 1.5px solid #e1e8ed;
                border-radius: 8px;
                padding: 8px 18px;
                font-size: 1rem;
                font-weight: 500;
                cursor: pointer;
                transition: background 0.18s, color 0.18s, border 0.18s;
                outline: none;
            }
            .table-filter-btn.active, .table-filter-btn:focus {
                background: #2563eb;
                color: #fff;
                border-color: #2563eb;
            }
            @media (max-width: 700px) {
                .table-filter-bar {
                    gap: 6px;
                    margin-bottom: 18px;
                }
                .table-filter-btn {
                    padding: 7px 10px;
                    font-size: 0.97rem;
                }
            }
        /* (Styles ส่วนบนคงเดิม) */
        * { 
            font-family: 'Kanit', sans-serif;
 box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        
        :root {
            --primary: #2c3e50;
 --secondary: #34495e;
            --accent: #3498db;
            --success: #27ae60;
            --warning: #f39c12;
            --danger: #e74c3c;
            --light-bg: #f8f9fa;
            --card-bg: #ffffff;
            --border: #e1e8ed;
            --text-primary: #2c3e50;
            --text-secondary: #7f8c8d;
 --shadow: rgba(0, 0, 0, 0.08);
        }

        body { 
            background: linear-gradient(135deg, #f5f7fa 0%, #e8eef3 100%);
 color: var(--text-primary);
            padding: 20px;
            min-height: 100vh;
        }

        .container { 
            max-width: 1400px;
 margin: auto; 
            padding-top: 20px; 
        }
        
        /* Header (คงเดิม) */
        .header-bar {
            display: flex;
 justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: var(--card-bg);
            padding: 20px 30px;
            border-radius: 16px;
            box-shadow: 0 2px 10px var(--shadow);
 }
        
        .header-bar h2 { 
            color: var(--text-primary);
 font-weight: 600;
            font-size: 1.75rem;
            display: flex;
            align-items: center;
            gap: 12px;
 }

        .header-bar h2 i {
            color: var(--accent);
 font-size: 1.5rem;
        }
        
        .home-button {
            padding: 10px 20px;
 background: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 400;
            transition: all 0.3s;
            display: flex;
            align-items: center;
            gap: 8px;
 font-size: 0.95rem;
        }
        
        .home-button:hover {
            background: var(--secondary);
 transform: translateY(-2px);
            box-shadow: 0 4px 12px var(--shadow);
        }
        
        /* Notification - ปรับเป็นหน้าต่างลอย กลางจอ */
        .notification-bar {
            /* VVVV NEW CENTER STYLES VVVV */
            position: fixed;
 top: 50%; /* เลื่อนลงมา 50% */
            left: 50%;
 /* เลื่อนไปขวา 50% */
            transform: translate(-50%, -50%);
 /* เลื่อนกลับ 50% ของขนาดตัวเอง */
            z-index: 2000;
 /* เพิ่ม z-index ให้สูงขึ้น */
            max-width: 500px;
 /* เพิ่มความกว้างเล็กน้อย */
            width: 90%;
 /* ^^^^ END NEW CENTER STYLES ^^^^ */
            
            background: var(--card-bg);
 padding: 25px 30px; /* เพิ่ม Padding */
            border-radius: 12px;
 margin-bottom: 0; 
            display: flex;
            flex-direction: column;
            gap: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
 /* เพิ่มเงาให้ดูเด่นมาก */
            animation: fadeInScale 0.5s ease-out;
 /* ใช้ Animation ใหม่ */
        }
        
        /* Keyframe for center animation */
        @keyframes fadeInScale {
            from { opacity: 0;
 transform: translate(-50%, -50%) scale(0.9); }
            to { opacity: 1;
 transform: translate(-50%, -50%) scale(1); }
        }

        /* สำหรับซ่อน Notification Bar */
        .notification-bar.hidden {
            display: none !important;
 }
        
        .notification-bar .details {
            flex-grow: 1;
 display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px; 
        }
        
        .notification-bar .icon-check {
            width: 50px;
 height: 50px; 
            background: #e8f5e9;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
 }
        
        .notification-bar .icon-check i {
            color: var(--success);
 font-size: 1.5rem; 
        }
        
        .notification-bar .text-content strong {
            font-size: 1.2rem;
 display: block;
            margin-bottom: 5px;
            color: var(--text-primary);
            font-weight: 600;
            text-align: center;
 }
        
        .notification-bar .text-content span {
            font-size: 1.0rem;
 color: var(--text-secondary);
            font-weight: 400;
            text-align: center;
        }
        
        .notification-bar .action-button {
            /* ปรับปุ่มให้สั้นลง */
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
 color: white;
            padding: 14px 28px; /* เพิ่ม Padding เล็กน้อย */
            border-radius: 10px;
 text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            margin-left: 0;
            font-size: 1.05rem;
 flex-shrink: 0;
            width: 100%;
            box-shadow: 0 4px 15px rgba(44, 62, 80, 0.25);
            border: none;
 }
        
        .notification-bar .action-button:hover {
            background: linear-gradient(135deg, #34495e 0%, #2c3e50 100%);
 transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(44, 62, 80, 0.35);
 }
        
        .notification-bar .action-button:active {
            transform: translateY(0);
 box-shadow: 0 2px 10px rgba(44, 62, 80, 0.25);
        }

        .close-button {
            background: none;
 border: none;
            color: var(--text-secondary);
            font-size: 1.2rem;
            cursor: pointer;
            transition: color 0.2s;
            position: absolute;
            top: 15px;
            right: 15px;
 }
        .close-button:hover {
            color: var(--danger);
 }
        
        /* (Styles ส่วนอื่น ๆ คงเดิม) */
        
        .system-message {
            background: var(--card-bg);
 border-left: 4px solid var(--success);
            padding: 16px 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            box-shadow: 0 2px 8px var(--shadow);
            color: var(--text-primary);
            font-weight: 400;
 }
        
        .table-grid {
            display: grid;
 grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); 
            gap: 20px;
        }
        
        .table-card {
            background: var(--card-bg);
 padding: 28px;
            border-radius: 16px;
            box-shadow: 0 2px 12px var(--shadow);
            text-align: center;
            transition: all 0.3s ease;
            position: relative;
 border-top: 3px solid var(--border);
        }
        
        .table-card:hover { 
            transform: translateY(-5px);
 box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
        }
        
        /* Status Borders */
        .status-Free { border-top-color: var(--success);
 }
        .status-Occupied, .status-In_Use { border-top-color: var(--danger);
 }
        .status-Already_reserved { border-top-color: var(--warning);
 }
        .status-Cleaning { border-top-color: var(--accent);
 }

        /* Table Info */
        .table-info {
            font-size: 2rem;
 font-weight: 600;
            margin-bottom: 8px;
            color: var(--text-primary);
        }
        
        .table-capacity {
            font-size: 0.95rem;
 color: var(--text-secondary);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
 }

        /* Status Badge */
        .status-badge {
            display: inline-flex;
 align-items: center;
            gap: 6px;
            padding: 8px 16px;
            border-radius: 20px;
            font-weight: 500;
            margin-bottom: 20px;
            font-size: 0.85rem;
            background: var(--light-bg);
            color: var(--text-primary);
 }
        
        .status-badge::before {
            content: '';
 width: 8px;
            height: 8px;
            border-radius: 50%;
            display: inline-block;
        }
        
        .status-Free .status-badge::before { background: var(--success);
 }
        .status-Occupied .status-badge::before, 
        .status-In_Use .status-badge::before { background: var(--danger);
 }
        .status-Already_reserved .status-badge::before { background: var(--warning);
 }
        .status-Cleaning .status-badge::before { background: var(--accent);
 }

        /* Action Group */
        .action-group {
            padding-top: 20px;
 border-top: 1px solid var(--border);
            display: flex;
            flex-direction: column;
            gap: 10px;
 }
        
        .action-button {
            padding: 12px 20px;
 border-radius: 10px;
            text-decoration: none;
            font-weight: 500;
            color: white;
            transition: all 0.3s;
            font-size: 0.95rem;
            display: flex;
            align-items: center;
            justify-content: center;
 gap: 8px;
            border: none;
            cursor: pointer;
        }
        
        .action-button:hover:not(.btn-no-action) {
            transform: translateY(-2px);
 box-shadow: 0 4px 12px var(--shadow);
        }

        .btn-walk-in { background: linear-gradient(135deg, #27ae60 0%, #229954 100%);
 }
        .btn-check-in { background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
 }
        .btn-print { background: linear-gradient(135deg, #555555 0%, #3a3a3a 100%);
 }
        .btn-finish { background: linear-gradient(135deg, #f39c12 0%, #e67e22 100%);
 }
        .btn-clean { background: linear-gradient(135deg, #27ae60 0%, #229954 100%);
 }
        .btn-no-action { 
            background: var(--light-bg);
 color: var(--text-secondary);
            cursor: default;
        }

        /* QR Display */
        .qr-display {
            margin: 15px auto 20px;
 padding: 15px;
            background: var(--light-bg);
            border: 2px dashed var(--border);
            border-radius: 12px;
            width: 160px;
 }
        
        .qr-display img {
            width: 100%;
 height: auto;
            display: block;
            border-radius: 8px;
        }
        
        .qr-display small {
            display: block;
 margin-top: 10px;
            color: var(--text-secondary);
            font-size: 0.8rem;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .header-bar {
                flex-direction: column;
 gap: 15px;
                text-align: center;
            }
            
            /* Notification ในมือถือกลับไปอยู่ด้านบน (ไม่ลอยตรงกลาง) */
            .notification-bar {
                position: fixed;
 top: 0;
                left: 0;
                right: 0;
                transform: none; 
                max-width: 100%;
                border-radius: 0;
 }
            
            .notification-bar .details {
                width: 100%;
 }
            
            .notification-bar .action-button {
                width: 100%;
 justify-content: center;
            }
            
            .table-grid {
                grid-template-columns: 1fr;
 }
        }
    </style>
</head>
<body>
    
    <c:set var="contextPath" value="${pageContext.request.contextPath}" />
    
    <div class="container">
        <div class="header-bar">
            <h2>
                <i class=""></i>
                รายการโต๊ะ
            </h2>
  
            <a href="gohome" class="home-button">
                <i class="fas fa-home"></i>
                หน้าหลัก
            </a>
                </div>
                <!-- Filter Bar -->
                <div class="table-filter-bar" id="tableFilterBar">
                    <button class="table-filter-btn active" data-status="all" type="button">ทั้งหมด</button>
                    <button class="table-filter-btn" data-status="Free" type="button">ว่าง</button>
                    <button class="table-filter-btn" data-status="Already_reserved" type="button">จองแล้ว</button>
                    <button class="table-filter-btn" data-status="Occupied,In_Use" type="button">ไม่ว่าง</button>
                    
                    <input type="number" id="capacitySearchInput" min="1" placeholder="ค้นหาความจุโต๊ะ..." style="margin-left:16px; padding:7px 12px; border-radius:7px; border:1.5px solid #e1e8ed; font-size:1rem; width:160px; max-width:40vw;" />
                </div>
                <div id="noTableFoundMsg" style="display:none; color:#e74c3c; font-weight:500; margin-bottom:18px; text-align:center;">ไม่พบโต๊ะในสถานะที่เลือก</div>
        
        <c:if test="${not empty successMessage}">
            <div class="system-message">
  
                <i class="fas fa-check-circle"></i> ${successMessage}
            </div>
        </c:if>
 
        <c:set var="orderIdToPrint" value="${param.orderIdToPrint}" />
        <c:set var="tableId" value="${param.tableId}" />
        <c:set var="qrToken" value="${param.qrToken}" />
        
        <c:if test="${not empty orderIdToPrint and not empty tableId}">
      
          <%-- เพิ่ม ID สำหรับ JavaScript --%>
            <div class="notification-bar" id="openTableNotification">
                <div class="details">
                    <div class="icon-check">
                        <i class="fas fa-check"></i>
           
                     </div>
                    <div class="text-content">
                        <strong>เปิดบิลสำเร็จ</strong>
                        <span>โต๊ะ ${tableId} · บิล #${orderIdToPrint} ถูกเปิดแล้ว</span>
                 
    </div>
                </div>
                
                <c:if test="${not empty qrToken}">
                    <div style="text-align: center; margin: 15px 0;">
                        <img src="generateQrForTable?token=${qrToken}" alt="QR Code" style="width: 150px; height: 150px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.15);" />
                    </div>
                </c:if>
                
                <a href="#" 
                   onclick="handlePrintClick('${orderIdToPrint}');
 return false;" 
                   class="action-button">
                    พิมพ์ QR Code
                </a>
                
                <button class="close-button" onclick="hideNotification()">
       
                     <i class="fas fa-times"></i>
                </button>
            </div>
        </c:if>

        <div class="table-grid" id="tableGrid">
            <c:forEach var="table" items="${tables}">
                <c:set var="statusCss" value="${fn:replace(table.status, ' ', '_')}" /> 
                <div class="table-card status-${statusCss}" data-status="${statusCss}">
                    <div class="table-info">โต๊ะ ${table.tableid}</div>
                    <div class="table-capacity">
                        <i class="fas 
 fa-users"></i>
                        <span>${table.capacity} ที่นั่ง</span>
                    </div>
                    
                    <div class="status-badge">
                        <c:choose>
                            <c:when test="${table.status == 'Free'}">ว่าง</c:when>
                            <c:when test="${table.status == 'Occupied' || table.status == 'In Use'}">ไม่ว่าง</c:when>
                            <c:when test="${table.status == 'Already reserved'}">จองแล้ว</c:when>
                            
                            <c:otherwise>${table.status}</c:otherwise>
                        </c:choose>
                    </div>
              
       
                    <div class="action-group">
                        <c:choose>
                            <c:when test="${table.status == 'Free'}">
                  
                                <a href="gotoOpenTable?tableid=${table.tableid}" 
                                   class="action-button btn-walk-in">
                                    <i class="fas fa-user-plus"></i>
          
                                      เปิดโต๊ะ (Walk-in)
                                </a>
                            </c:when>
             
                
                            <c:when test="${table.status == 'Already reserved'}">
                                <a href="gotoViewReservations" 
                   
                                     class="action-button btn-check-in">
                                    <i class="fas fa-calendar-check"></i>
                                    จัดการรายการจอง
        
                                 </a>
                            </c:when>

                            <c:when test="${table.status == 'Occupied' ||
 table.status == 'In Use'}">
                                <c:if test="${not empty table.qrToken}">
                                    <div class="qr-display">
                         
                                        <img src="generateQrForTable?token=${table.qrToken}" 
                                            alt="QR Code for Table ${table.tableid}" />
                                  
       
                                    </div>
                                </c:if>

                          
       <a href="#" 
                                   onclick="openPrintOrderInfoByTableId('${table.tableid}');
 return false;" 
                                   class="action-button btn-print">
                                    <i class="fas fa-print"></i>
                        
                             พิมพ์ Order Info
                                </a>
    
                                                                <!-- ปุ่มลูกค้าเสร็จสิ้นถูกลบออก -->
                            </c:when>
                            
                  
                            <c:when test="${table.status == 'Cleaning'}">
                                <!-- ปุ่มทำความสะอาดเสร็จสิ้นถูกลบออก -->
                            </c:when>
                            
                            <c:otherwise>
                           
                                 <span class="action-button btn-no-action">
                                    ไม่มี Action
                                </span>
                        
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
    
        <script>
        // Table filter logic
        document.addEventListener('DOMContentLoaded', function() {
            const filterBar = document.getElementById('tableFilterBar');
            if (!filterBar) return;
            const filterBtns = filterBar.querySelectorAll('.table-filter-btn');
            const tableCards = document.querySelectorAll('.table-card');
            const noTableMsg = document.getElementById('noTableFoundMsg');
            const capacityInput = document.getElementById('capacitySearchInput');
            let currentStatus = 'all';

            function filterTables() {
                let found = false;
                const capacityVal = capacityInput.value.trim();
                tableCards.forEach(card => {
                    const cardStatus = card.getAttribute('data-status');
                    // หา capacity จาก .table-capacity span
                    const capSpan = card.querySelector('.table-capacity span');
                    let cardCap = capSpan ? capSpan.textContent.replace(/[^\d]/g, '') : '';
                    let matchStatus = false;
                    if (currentStatus === 'all') {
                        matchStatus = true;
                    } else if (currentStatus === 'Occupied,In_Use') {
                        matchStatus = (cardStatus === 'Occupied' || cardStatus === 'In_Use');
                    } else {
                        matchStatus = (cardStatus === currentStatus);
                    }
                    let matchCap = true;
                    if (capacityVal) {
                        matchCap = (cardCap === capacityVal);
                    }
                    if (matchStatus && matchCap) {
                        card.style.display = '';
                        found = true;
                    } else {
                        card.style.display = 'none';
                    }
                });
                if (!found) {
                    noTableMsg.style.display = '';
                } else {
                    noTableMsg.style.display = 'none';
                }
            }

            filterBar.addEventListener('click', function(e) {
                if (!e.target.classList.contains('table-filter-btn')) return;
                filterBtns.forEach(btn => btn.classList.remove('active'));
                e.target.classList.add('active');
                currentStatus = e.target.getAttribute('data-status');
                filterTables();
            });
            if (capacityInput) {
                capacityInput.addEventListener('input', filterTables);
            }
        });
    
    const APP_CONTEXT_PATH = '${contextPath}';
        const NOTIFICATION_BAR_ID = 'openTableNotification';
 // Define ID

        // Helper function to hide the notification bar
        function hideNotification() {
            const notificationBar = document.getElementById(NOTIFICATION_BAR_ID);
 if (notificationBar) {
                notificationBar.classList.add('hidden');
 }
        }
        
        // ******************************************************
        // ✅ NEW FUNCTION: สำหรับเรียกพิมพ์โดยใช้ Order ID (จาก Notification Bar)
        // ******************************************************
        function openPrintOrderInfoByOrderId(orderId) {
             const urlToCall = APP_CONTEXT_PATH + '/printOrderInfo?orderId=' + orderId;
 window.open(urlToCall, '_blank', 
                 'toolbar=no,scrollbars=yes,resizable=yes,top=0,left=0,width='+screen.width+',height='+screen.height+'');
 }

        // ******************************************************
        // ✅ NEW FUNCTION: สำหรับเรียกพิมพ์โดยใช้ Table ID (จาก Table Card)
        // ******************************************************
        function openPrintOrderInfoByTableId(tableId) {
            // ใช้ findAndPrintOrder เพราะเรามีแค่ Table ID ต้องให้ Controller ไปหา Active Order ID
             const urlToCall = APP_CONTEXT_PATH + '/findAndPrintOrder?tableId=' + tableId;
 window.open(urlToCall, '_blank', 
                 'toolbar=no,scrollbars=yes,resizable=yes,top=0,left=0,width='+screen.width+',height='+screen.height+'');
 }
        
        // ******************************************************
        // ✅ NEW HANDLER: จัดการการกดพิมพ์จาก Notification Bar และซ่อน Bar
        // ******************************************************
        function handlePrintClick(orderId) {
            // 1. สั่งเปิดหน้าพิมพ์
            openPrintOrderInfoByOrderId(orderId);
 // 2. ซ่อน Notification Bar ทันที
            hideNotification();
 }


        window.onload = function() {
            // โค้ดล้าง URL คงเดิม
            if (window.history.replaceState) {
                const urlParams = new URLSearchParams(window.location.search);
 if (urlParams.has('orderIdToPrint')) {
                    const cleanUrl = window.location.pathname + window.location.search
                         // ใช้ regex เพื่อลบ parameter ทั้ง 3 ตัวออกจาก URL
                        .replace(/([?&])orderIdToPrint=[^&]*/, '')
               
             .replace(/([?&])tableId=[^&]*/, '')
                        .replace(/([?&])qrToken=[^&]*/, '');
 window.history.replaceState(null, null, cleanUrl);
                }
            }
        };
 </script>
</body>
</html>