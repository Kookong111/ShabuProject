<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Table Details</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        margin: 0;
        padding: 40px;
        background: linear-gradient(135deg, #f3e8ff, #ede7f6);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: flex-start;
    }

    .container {
        max-width: 600px;
        width: 100%;
        background: #fff;
        padding: 35px 30px 45px;
        border-radius: 20px;
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        animation: fadeIn 0.6s ease;
        position: relative; /* ให้ปุ่ม Home อยู่ภายใน */
    }

    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(20px);}
        to {opacity: 1; transform: translateY(0);}
    }

    h1 {
        text-align: center;
        color: #6a1b9a;
        font-weight: 600;
        margin-bottom: 25px;
        font-size: 1.8rem;
    }

    .detail-item {
        margin-bottom: 20px;
    }

    .detail-item label {
        display: flex;
        align-items: center;
        font-weight: 600;
        margin-bottom: 6px;
        color: #333;
    }

    .detail-item label i {
        margin-right: 8px;
        color: #8e44ad;
    }

    .detail-value {
        padding: 14px 16px;
        border: 1px solid #eee;
        border-radius: 12px;
        background-color: #fafafa;
        font-size: 15px;
        color: #444;
    }

    /* status styles */
    .status-free { color: #27ae60; font-weight: 600; }
    .status-in-use { color: #e74c3c; font-weight: 600; }
    .status-reserved { color: #f39c12; font-weight: 600; }

    .reserve-button {
        background: linear-gradient(135deg, #9b59b6, #8e44ad);
        color: #fff;
        padding: 14px 20px;
        border: none;
        border-radius: 12px;
        cursor: pointer;
        font-size: 16px;
        font-weight: 600;
        width: 100%;
        margin-top: 25px;
        transition: all 0.3s ease;
    }

    .reserve-button:hover {
        background: linear-gradient(135deg, #8e44ad, #732d91);
        transform: translateY(-2px);
        box-shadow: 0 6px 15px rgba(0,0,0,0.2);
    }

    .disabled-button {
        background: #ccc;
        color: #666;
        cursor: not-allowed;
        box-shadow: none;
    }

    /* ปุ่ม Home */
    .home-button {
        position: absolute;
        top: 15px;
        left: 15px;
        background: linear-gradient(135deg, #9b59b6, #8e44ad);
        color: white;
        text-decoration: none;
        font-weight: 500;
        padding: 8px 16px;
        border-radius: 50px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.15);
        transition: all 0.3s ease;
        font-size: 14px;
    }

    .home-button:hover {
        background: linear-gradient(135deg, #8e44ad, #732d91);
        box-shadow: 0 6px 15px rgba(0,0,0,0.25);
    }
</style>

</head>
<body>
    <div class="container">
        <!-- ปุ่ม Home -->
        <a href="listTable" class="home-button"><i class="fas fa-home"></i> Home</a>
        
        <h1><i class="fas fa-chair"></i> Table Details</h1>

        <div class="detail-item">
            <label><i class="fas fa-hashtag"></i> Table ID:</label>
            <div class="detail-value">${table.tableid}</div>
        </div>

        <div class="detail-item">
            <label><i class="fas fa-users"></i> Capacity:</label>
            <div class="detail-value">${table.capacity} seats</div>
        </div>

        <div class="detail-item">
            <label><i class="fas fa-info-circle"></i> Status:</label>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${table.status == 'Free'}">
                        <span class="status-free"><i class="fas fa-circle-check"></i> Free</span>
                    </c:when>
                    <c:when test="${table.status == 'In use'}">
                        <span class="status-in-use"><i class="fas fa-chair"></i> In use</span>
                    </c:when>
                    <c:when test="${table.status == 'Already reserved'}">
                        <span class="status-reserved"><i class="fas fa-lock"></i> Reserved</span>
                    </c:when>
                    <c:otherwise>
                        ${table.status}
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
		
        <c:choose>
            <c:when test="${table.status == 'Free'}">
                <form action="reserveTable">
                    <input type="hidden" name="tableid" value="${table.tableid}">
                    <button type="submit" class="reserve-button"><i class="fas fa-plus-circle"></i> Reserve Table</button>
                </form>
            </c:when>
            <c:otherwise>
                <button type="button" class="reserve-button disabled-button" disabled><i class="fas fa-ban"></i> Table Not Available</button>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
