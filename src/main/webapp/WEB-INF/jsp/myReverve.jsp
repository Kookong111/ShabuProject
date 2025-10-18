<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายการจองของฉัน</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        * {
            font-family: 'Kanit', sans-serif;
            box-sizing: border-box;
        }
        body { 
            background: #fafafa; 
            padding: 30px 15px; 
        }
        .container { 
            max-width: 800px; 
            margin: auto; 
            background: #ffffff; 
            padding: 30px; 
            border-radius: 16px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.08); 
        }
        h2 { 
            text-align: center; 
            color: #1a1a1a; 
            margin-bottom: 30px; 
            font-weight: 600;
            border-bottom: 2px solid #eee;
            padding-bottom: 15px;
        }
        .reservation-card {
            border: 1px solid #e0e0e0;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 12px;
            background-color: #f9f9f9;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: transform 0.3s ease;
        }
        .reservation-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 6px 16px rgba(0,0,0,0.1);
        }
        .detail { 
            display: flex;
            justify-content: space-between;
            padding: 5px 0;
            border-bottom: 1px dashed #e0e0e0;
        }
        .detail:last-child {
            border-bottom: none;
        }
        .label { 
            font-weight: 500; 
            color: #444; 
            flex-basis: 40%;
        }
        .value { 
            text-align: right;
            color: #1a1a1a; 
            flex-basis: 60%;
        }
        .status-badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 500;
            margin-top: 10px;
        }
        .status-Reserved {
            background-color: #ffeb3b; /* Yellow */
            color: #333;
        }
        .status-Completed {
            background-color: #4caf50; /* Green */
            color: white;
        }
        .status-Cancelled {
            background-color: #f44336; /* Red */
            color: white;
        }
        .no-reservations {
            text-align:center; 
            color:#888;
            padding: 40px 0;
            background: #f0f0f0;
            border-radius: 8px;
            font-size: 16px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>รายการจองโต๊ะของฉัน 📝</h2>

    <c:choose>
        <c:when test="${not empty reservations}">
            
            <c:forEach var="reserve" items="${reservations}" varStatus="loop">
                <div class="reservation-card">
			                	
			        <div class="detail" style="border-bottom: none; display: flex; justify-content: flex-end; padding-top: 15px;">
			            <c:if test="${reserve.status == 'Reserved'}">
			                <a href="viewReservationDetail?reserveid=${reserve.reserveid}" 
			                   class="btn-detail" 
			                   style="padding: 8px 15px; background: #6a1b9a; color: white; border-radius: 8px; text-decoration: none; font-weight: 500; transition: background 0.3s;">
			                    ดูรายละเอียด/ยกเลิก
			                </a>
			            </c:if>
			            <c:if test="${reserve.status != 'Reserved'}">
			                <span style="padding: 8px 15px; color: #888; font-style: italic;">ไม่สามารถยกเลิกได้</span>
			            </c:if>
			        </div>
                    <div class="detail">
                        <span class="label">หมายเลขการจอง:</span> 
                        <span class="value">${reserve.reserveid}</span>
                    </div>
                    <div class="detail">
                        <span class="label">ชื่อลูกค้า:</span> 
                        <span class="value">${reserve.customers.cusname}</span> 
                    </div>
                    <div class="detail">
                        <span class="label">หมายเลขโต๊ะ:</span> 
                        <span class="value">${reserve.tables.tableid} (ขนาด: ${reserve.tables.capacity} ที่นั่ง)</span>
                    </div>
                    <div class="detail">
                        <span class="label">จำนวนลูกค้า:</span> 
                        <span class="value">${reserve.numberOfGuests} ท่าน</span>
                    </div>
                    <div class="detail">
                        <span class="label">วันที่จอง:</span> 
                        <%-- ใช้ fmt:formatDate เพื่อจัดรูปแบบวันที่ --%>
                        <span class="value"><fmt:formatDate value="${reserve.reservedate}" pattern="d MMMM yyyy" timeZone="Asia/Bangkok" /></span>
                    </div>
                    <div class="detail">
                        <span class="label">เวลา:</span> 
                        <span class="value">${reserve.reservetime} น.</span>
                    </div>
                    <div class="detail" style="border-bottom: none;">
                        <span class="label">สถานะ:</span> 
                        <span class="value">
                            <span class="status-badge status-${reserve.status}">${reserve.status}</span>
                        </span>
                    </div>
                </div>
            </c:forEach>
            
        </c:when>
        <c:otherwise>
            <p class="no-reservations">
                ยังไม่มีรายการจองโต๊ะในขณะนี้ 😥
            </p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>