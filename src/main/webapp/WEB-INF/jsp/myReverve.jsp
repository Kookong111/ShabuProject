<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <title>การจองของฉัน</title>
    <style>
        body { font-family: 'Poppins', sans-serif; background: #f7f3ff; padding: 30px; }
        .container { max-width: 700px; margin: auto; background: #fff; padding: 25px; border-radius: 12px; box-shadow: 0 6px 20px rgba(0,0,0,0.1); }
        h2 { text-align: center; color: #6a1b9a; margin-bottom: 20px; }
        .detail { margin-bottom: 15px; }
        .label { font-weight: bold; color: #444; }
        .value { margin-left: 10px; }
    </style>
</head>
<body>
<div class="container">
    <h2>การจองของฉัน</h2>

    <c:choose>
        <c:when test="${not empty tableid}">
            <div class="detail"><span class="label">ชื่อลูกค้า:</span> <span class="value">${customerName}</span></div>
            <div class="detail"><span class="label">หมายเลขโต๊ะ:</span> <span class="value">${tableid}</span></div>
            <div class="detail"><span class="label">วันที่จอง:</span> <span class="value">${date}</span></div>
            <div class="detail"><span class="label">เวลา:</span> <span class="value">${time}</span></div>
        </c:when>
        <c:otherwise>
            <p style="text-align:center; color:#888;">คุณยังไม่มีการจอง</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
