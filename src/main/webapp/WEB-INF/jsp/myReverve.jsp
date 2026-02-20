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
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * { font-family: 'Kanit', sans-serif; box-sizing: border-box; }
        body { background: #fafafa; padding: 30px 15px; }
        .container { max-width: 900px; margin: auto; }
        
        .section-title {
            font-size: 1.5rem; font-weight: 600; color: #1a1a1a;
            margin: 40px 0 20px; padding-bottom: 10px;
            border-bottom: 3px solid #6a1b9a; display: flex; align-items: center; gap: 10px;
        }

        .reservation-card {
            background: #ffffff; padding: 25px; margin-bottom: 20px;
            border-radius: 16px; border: 1px solid #e0e0e0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: 0.3s;
        }
        .reservation-card:hover { transform: translateY(-4px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        
        /* สไตล์พิเศษสำหรับประวัติการยกเลิก */
        .history-card { opacity: 0.8; background-color: #fcfcfc; border-left: 5px solid #ccc; }
        .history-card .label, .history-card .value { color: #888; }

        .detail { display: flex; justify-content: space-between; padding: 8px 0; border-bottom: 1px dashed #eee; }
        .detail:last-child { border-bottom: none; }
        .label { font-weight: 500; color: #444; flex-basis: 40%; }
        .value { text-align: right; color: #1a1a1a; flex-basis: 60%; }

        .status-badge { display: inline-block; padding: 5px 15px; border-radius: 20px; font-size: 13px; font-weight: 600; }
        .status-Reserved { background-color: #fff9c4; color: #f57f17; border: 1px solid #fbc02d; }
        .status-CheckedIn { background-color: #e3f2fd; color: #1976d2; border: 1px solid #90caf9; }
        .status-Cancelled { background-color: #ffebee; color: #c62828; border: 1px solid #ef9a9a; }
        
        .btn-back { display: inline-block; padding: 12px 24px; background: #6a1b9a; color: white; border-radius: 12px; text-decoration: none; font-weight: 500; transition: 0.3s; margin-bottom: 10px; }
        .btn-back:hover { background: #4a148c; transform: scale(1.02); }
        
        .btn-detail { padding: 8px 20px; background: #6a1b9a; color: white; border-radius: 8px; text-decoration: none; font-size: 14px; transition: 0.3s; display: inline-flex; align-items: center; gap: 5px; }
        .btn-detail:hover { background: #4a148c; }
        
        .empty-box { text-align: center; padding: 50px; background: #eee; border-radius: 15px; color: #777; }
    </style>
</head>
<body>

<div class="container">
    <a href="gotowelcomeCustomerCheck" class="btn-back"><i class="fas fa-chevron-left"></i> กลับหน้าหลัก</a>
    
    <%-- 1. ส่วนรายการจองที่ยังใช้งานได้ (Active Reservations) --%>
    <h2 class="section-title"><i class="fas fa-calendar-check text-success"></i> รายการจองปัจจุบัน</h2>
    
    <c:set var="hasActive" value="false" />
    <c:forEach var="reserve" items="${reservations}">
        <c:if test="${reserve.status == 'Reserved'}">
            <c:set var="hasActive" value="true" />
            <div class="reservation-card">
                <div class="detail" style="border-bottom: none; justify-content: flex-end;">
                    <a href="viewReservationDetail?reserveid=${reserve.reserveid}" class="btn-detail">
                        <i class="fas fa-edit"></i> ดูรายละเอียด / ยกเลิก
                    </a>
                </div>
                <div class="detail">
                    <span class="label">หมายเลขการจอง:</span> 
                    <span class="value">#${reserve.reserveid}</span>
                </div>
                <div class="detail">
                    <span class="label">หมายเลขโต๊ะ:</span> 
                    <span class="value">โต๊ะ ${reserve.tables.tableid}</span>
                </div>
                <div class="detail">
                    <span class="label">วันที่และเวลา:</span> 
                    <span class="value">
                        <fmt:formatDate value="${reserve.reservedate}" pattern="d MMMM yyyy" timeZone="Asia/Bangkok" />
                        เวลา ${reserve.reservetime} น.
                    </span>
                </div>
                <div class="detail" style="border-bottom: none;">
                    <span class="label">สถานะ:</span> 
                    <span class="value">
                        <span class="status-badge status-Reserved">รอยืนยันการใช้บริการ</span>
                    </span>
                </div>
            </div>
        </c:if>
    </c:forEach>

    <c:if test="${not hasActive}">
        <div class="empty-box">ไม่มีรายการจองที่กำลังรอรับบริการ</div>
    </c:if>

    <hr style="margin: 50px 0; border: 0; border-top: 1px solid #ddd;">

    <%-- 2. ส่วนประวัติการจองและประวัติการยกเลิก (History) --%>
    <h2 class="section-title"><i class="fas fa-history text-muted"></i> ประวัติการยกเลิกและรายการย้อนหลัง</h2>

    <c:set var="hasHistory" value="false" />
    <c:forEach var="reserve" items="${reservations}">
        <c:if test="${reserve.status != 'Reserved'}">
            <c:set var="hasHistory" value="true" />
            <div class="reservation-card history-card">
                <div class="detail">
                    <span class="label">หมายเลขการจอง:</span> 
                    <span class="value">#${reserve.reserveid}</span>
                </div>
                <div class="detail">
                    <span class="label">หมายเลขโต๊ะ:</span> 
                    <span class="value">โต๊ะ ${reserve.tables.tableid}</span>
                </div>
                <div class="detail">
                    <span class="label">วันที่จองเดิม:</span> 
                    <span class="value">
                        <fmt:formatDate value="${reserve.reservedate}" pattern="d MMM yyyy" timeZone="Asia/Bangkok" />
                    </span>
                </div>
                <div class="detail" style="border-bottom: none;">
                    <span class="label">สถานะสุดท้าย:</span> 
                    <span class="value">
                        <c:choose>
                            <c:when test="${reserve.status == 'Cancelled'}">
                                <span class="status-badge status-Cancelled"><i class="fas fa-times-circle"></i> ยกเลิกแล้ว</span>
                            </c:when>
                            <c:when test="${reserve.status == 'CheckedIn'}">
                                <span class="status-badge status-CheckedIn"><i class="fas fa-user-check"></i> เข้าใช้บริการแล้ว</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status-badge" style="background:#eee;">${reserve.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </c:if>
    </c:forEach>

    <c:if test="${not hasHistory}">
        <div class="empty-box">ยังไม่มีประวัติการจองย้อนหลัง</div>
    </c:if>
</div>

</body>
</html>