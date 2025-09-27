<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Table</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-purple: #6b46c1;
            --light-purple: #8b5cf6;
            --very-light-purple: #ede9fe;
            --purple-hover: #5b21b6;
            --soft-purple: #f3f4f6;
            --text-dark: #374151;
            --text-light: #6b7280;
            --border-light: #e5e7eb;
            --white: #ffffff;
            --success-green: #10b981;
            --danger-red: #ef4444;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: var(--text-dark);
            min-height: 100vh;
            margin: 0;
            padding: 20px 0;
        }

        .table-container {
            position: relative;
            max-width: 1200px;
            margin: 0 auto;
            background: var(--white);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(107, 70, 193, 0.1);
            padding: 40px;
            border: 1px solid var(--border-light);
            backdrop-filter: blur(10px);
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--very-light-purple);
        }

        .title-section h2 {
            color: var(--primary-purple);
            font-weight: 700;
            font-size: 2rem;
            margin: 0;
            letter-spacing: -0.5px;
        }

        .menu-count {
            color: var(--text-light);
            font-weight: 500;
            font-size: 1rem;
            margin: 8px 0 0 0;
        }

        .add-btn {
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--light-purple) 100%);
            border: none;
            width: 60px;
            height: 60px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: var(--white);
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(107, 70, 193, 0.3);
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(107, 70, 193, 0.4);
            color: var(--white);
        }

        .add-btn i {
            font-size: 1.5rem;
        }

        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(107, 70, 193, 0.05);
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: var(--white);
            border-radius: 12px;
            overflow: hidden;
        }

        th {
            background: linear-gradient(135deg, var(--primary-purple) 0%, var(--light-purple) 100%);
            color: var(--white);
            padding: 20px 16px;
            text-align: center;
            font-weight: 600;
            font-size: 0.9rem;
            letter-spacing: 0.5px;
            border: none;
        }

        th:first-child {
            border-top-left-radius: 12px;
        }

        th:last-child {
            border-top-right-radius: 12px;
        }

        td {
            padding: 20px 16px;
            text-align: center;
            border-bottom: 1px solid var(--border-light);
            font-weight: 500;
            vertical-align: middle;
        }

        tr:hover {
            background-color: var(--very-light-purple);
            transition: all 0.2s ease;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .food-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 12px;
            border: 3px solid var(--very-light-purple);
            transition: transform 0.2s ease;
        }

        .food-image:hover {
            transform: scale(1.05);
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            text-decoration: none;
            transition: all 0.2s ease;
            margin: 0 4px;
        }

        .edit-btn {
            background: rgba(16, 185, 129, 0.1);
            color: var(--success-green);
        }

        .edit-btn:hover {
            background: var(--success-green);
            color: var(--white);
            transform: translateY(-1px);
        }

        .delete-btn {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-red);
        }

        .delete-btn:hover {
            background: var(--danger-red);
            color: var(--white);
            transform: translateY(-1px);
        }

        .action-btn i {
            font-size: 1.2rem;
        }

        .food-name {
            font-weight: 600;
            color: var(--text-dark);
        }

        .food-type {
            color: var(--text-light);
            font-weight: 500;
        }

        .food-price {
            font-weight: 600;
            color: var(--primary-purple);
        }

        .error-message {
            color: var(--danger-red);
            text-align: center;
            margin: 20px 0;
            font-weight: 500;
        }

        .back-link-container {
            text-align: center;
            margin-top: 40px;
            padding-top: 20px;
            border-top: 1px solid var(--border-light);
        }

        .back-link {
            color: var(--primary-purple);
            text-decoration: none;
            font-weight: 600;
            padding: 12px 24px;
            border-radius: 8px;
            background: var(--very-light-purple);
            transition: all 0.2s ease;
            display: inline-block;
        }

        .back-link:hover {
            background: var(--primary-purple);
            color: var(--white);
            transform: translateY(-1px);
        }

        .row-number {
            font-weight: 500;
            color: var(--text-dark);
        }

        @media (max-width: 768px) {
            .table-container {
                padding: 20px;
                margin: 10px;
            }

            .header-section {
                flex-direction: column;
                align-items: flex-start;
                gap: 20px;
            }

            .title-section h2 {
                font-size: 1.5rem;
            }

            .add-btn {
                align-self: flex-end;
            }

            th, td {
                padding: 12px 8px;
                font-size: 0.85rem;
            }

            .food-image {
                width: 60px;
                height: 60px;
            }
        }
    </style>
</head>

<body>

    <div class="table-container">
        <div class="header-section">
            <div class="title-section">
                <h2>รายการเมนูอาหาร</h2>
                <p class="menu-count">จำนวนเมนูทั้งหมด: ${listmenuFood.size()} เมนู</p>
            </div>
            <a href="gotoAddMenu" class="add-btn">
                <i class="bi bi-plus-lg"></i>
            </a>
        </div>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ลำดับ</th>
                        <th>รูปภาพ</th>
                        <th>ชื่อเมนู</th>
                        <th>ประเภท</th>
                        <th>ราคา (บาท)</th>
                        <th>แก้ไข</th>
                        <th>ลบ</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listmenuFood}" var="item" varStatus="status">
                        <tr>
                            <td>
                                ${status.index + 1}
                            </td>
                            <td>
                                <img src="${item.foodImage}" alt="Food Image" class="food-image" />
                            </td>
                            <td class="food-name">${item.foodname}</td>
                            <td class="food-type">${item.foodtype}</td>
                            <td class="food-price">฿${item.price}</td>
                            <td>
                                <a href="geteditMenufood?foodId=${item.foodId}" class="action-btn edit-btn">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                            </td>
                            <td>
                                <a href="#" onclick="deleteMenuFood('${item.foodId}')" class="action-btn delete-btn">
                                    <i class="bi bi-trash3-fill"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <c:if test="${not empty error_message}">
            <div class="error-message">${error_message}</div>
        </c:if>

        <div class="back-link-container">
            <a href="home" class="back-link">
                <i class="bi bi-house-fill me-2"></i>กลับหน้าหลัก
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteMenuFood(foodId) {
            if (confirm('คุณต้องการลบเมนูนี้หรือไม่?')) {
                fetch('deleteMenuFood', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'deleteMenuFood=' + encodeURIComponent(foodId)
                }).then(response => response.text())
                  .then(() => location.reload());
            }
        }
    </script>

</body>
</html>