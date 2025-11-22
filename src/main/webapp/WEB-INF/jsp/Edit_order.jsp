<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="th">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>แก้ไขข้อมูลออเดอร์</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">


    <style>
        :root {
            --primary-purple: #7047eb; /* ม่วงหลัก */
            --secondary-purple: #9b5af9;
            --light-purple: #e5d5ff;
            --white: #ffffff;
            --background-light: #f7f9fc;
            --text-dark: #374151;
            --text-muted: #6b7280;
            --border: #e5e7eb;
            --shadow-light: 0 4px 10px rgba(0, 0, 0, 0.05);
            --shadow-medium: 0 8px 25px rgba(0, 0, 0, 0.1);
            --success-color: #10b981;
            --error-color: #ef4444;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Kanit', sans-serif;
        }

        body {
            background-color: var(--background-light);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: var(--text-dark);
            padding: 20px;
        }

        .form-container {
            background-color: var(--white);
            border-radius: 16px;
            padding: 40px 30px;
            width: 100%;
            max-width: 500px;
            box-shadow: var(--shadow-medium);
            border: 1px solid var(--border);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-weight: 700;
            color: var(--primary-purple);
        }

        .form-label {
            color: var(--text-dark);
            margin-bottom: 0.4rem;
            display: block;
            font-weight: 600;
            font-size: 1rem;
        }

        .form-control,
        .form-control-select {
            background-color: var(--background-light);
            border: 1px solid var(--border);
            border-radius: 10px;
            color: var(--text-dark);
            padding: 12px 15px;
            margin-bottom: 1.3rem;
            transition: 0.3s ease-in-out;
            box-shadow: inset 0 1px 3px rgba(0, 0, 0, 0.05);
            width: 100%;
        }

        .form-control:focus {
            background-color: var(--white);
            border-color: var(--primary-purple);
            box-shadow: 0 0 0 3px rgba(112, 71, 235, 0.1);
            outline: none;
        }
        
        /* Readonly fields styling */
        .form-control[readonly] {
            background-color: #e9ecef;
            cursor: not-allowed;
            color: var(--text-muted);
        }


        .btn-primary {
            background-color: var(--primary-purple);
            border: none;
            border-radius: 10px;
            font-size: 1.05rem;
            font-weight: 600;
            padding: 12px;
            width: 48%;
            transition: 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-secondary {
            background-color: var(--text-muted);
            border: none;
            border-radius: 10px;
            font-size: 1.05rem;
            font-weight: 600;
            padding: 12px;
            width: 48%;
            transition: 0.3s;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }

        .btn-primary:hover {
            background-color: var(--secondary-purple);
            transform: scale(1.02);
            box-shadow: var(--shadow-light);
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            transform: scale(1.02);
            box-shadow: var(--shadow-light);
        }

        .form-links {
            text-align: center;
            margin-top: 25px;
        }

        .form-links a {
            color: var(--primary-purple);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s;
        }

        .form-links a:hover {
            color: var(--secondary-purple);
            text-decoration: underline;
        }

        .success-message {
            font-size: 1rem;
            color: var(--success-color);
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #d1fae5;
            border-radius: 8px;
        }

        .error-message {
            font-size: 1rem;
            color: var(--error-color);
            text-align: center;
            font-weight: bold;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #fee2e2;
            border-radius: 8px;
        }

        hr {
            border-color: var(--border);
            margin-top: 30px;
            margin-bottom: 20px;
        }

        .form-label i {
            margin-right: 6px;
            color: var(--secondary-purple);
        }

        @media (max-width: 576px) {
            .form-container {
                padding: 30px 20px;
            }
            
            .d-flex button {
                width: 100%;
                margin-bottom: 10px;
            }
            .d-flex {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

    <div class="form-container">
        <h2><i class="fas fa-edit"></i> แก้ไขข้อมูลออเดอร์</h2>
        
        <div class="result-message">
            <c:if test="${not empty add_result}">
                <div class="success-message">${add_result}</div>
            </c:if>
            <c:if test="${not empty edit_result}">
                <div class="error-message">${edit_result}</div>
            </c:if>
        </div>

        <form name="frm1" action="confirmEditOrder" method="post">
            <div class="mb-3">
                <label for="oderId" class="form-label"><i class="fas fa-hashtag"></i> หมายเลขออเดอร์</label>
                <input type="text" class="form-control" id="oderId" name="oderId" value="${editorder.oderId}" readonly>
            </div>
			
			<div class="mb-3">
                <label for="talbeid" class="form-label"><i class="fas fa-utensils"></i> หมายเลขโต๊ะ</label>
                <input type="text" class="form-control" id="talbeid" name="tableid" value="${editorder.table.tableid}" readonly>
            </div>
			
            <div class="mb-3">
                <label for="orderDate" class="form-label"><i class="fas fa-calendar-alt"></i> วันที่</label>
                <input type="date" class="form-control" id="orderDate" name="orderDate" value="${editorder.orderDate}">
            </div>

            <div class="mb-3">
                <label for="totalPeice" class="form-label"><i class="fas fa-dollar-sign"></i> ราคารวม</label>
                <input type="text" class="form-control" id="totalPeice" name="totalPeice" value="${editorder.totalPeice}">
            </div>

            <div class="mb-3">
                <label for="status" class="form-label"><i class="fas fa-info-circle"></i> สถานะ</label>
                <input type="text" class="form-control" id="status" name="status" value="${editorder.status}" readonly>
            </div>

            <div class="d-flex justify-content-between gap-2">  
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> บันทึก
                </button>
                <button type="reset" class="btn btn-secondary">
                    <i class="fas fa-undo"></i> รีเซ็ต
                </button>
            </div>
        </form>

        <hr>

        <div class="form-links">
            <a href="backToListOrder"><i class="fas fa-arrow-left"></i> กลับหน้ารายการออเดอร์</a>
        </div>
    </div>

</body>

</html>