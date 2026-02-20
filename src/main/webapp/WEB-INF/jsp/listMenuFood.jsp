<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายการเมนูอาหาร</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-purple: #6b46c1;
            --light-purple: #8b5cf6;
            --very-light-purple: #ede9fe;
            --purple-hover: #5b21b6;
            --text-dark: #374151;
            --border-light: #e5e7eb;
            --white: #ffffff;
            --success-green: #10b981;
            --danger-red: #ef4444;
            --purple-gradient: linear-gradient(135deg, #6b46c1 0%, #8b5cf6 100%);
        }
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            min-height: 100vh;
            padding: 20px 0;
        }
        .table-container {
            max-width: 1200px;
            margin: 0 auto;
            background: var(--white);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(107, 70, 193, 0.1);
            padding: 40px;
            border: 1px solid var(--border-light);
        }
        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 2px solid var(--very-light-purple);
        }
        .add-btn {
            background: var(--purple-gradient);
            padding: 10px 20px;
            border-radius: 12px;
            text-decoration: none;
            color: var(--white);
            font-weight: 600;
        }
        .table-wrapper { overflow-x: auto; border-radius: 12px; }
        table { width: 100%; border-collapse: separate; border-spacing: 0; }
        th { background: var(--purple-gradient); color: var(--white); padding: 20px; text-align: center; }
        td { padding: 15px; text-align: center; border-bottom: 1px solid var(--border-light); vertical-align: middle; }
        .food-image { width: 70px; height: 70px; object-fit: cover; border-radius: 10px; }
        .action-btn { display: inline-flex; align-items: center; justify-content: center; width: 35px; height: 35px; border-radius: 8px; }
        .edit-btn { background: rgba(16, 185, 129, 0.1); color: var(--success-green); text-decoration: none; }
        .edit-btn:hover { background: var(--success-green); color: white; }
    </style>
</head>
<body>
    <div class="table-container">
        <div class="header-section">
            <div class="title-section">
                <h2 style="color: var(--primary-purple); font-weight: 700;">รายการเมนูอาหาร</h2>
                <p>จำนวนเมนูทั้งหมด: ${listmenuFood.size()} เมนู</p>
            </div>
            <div class="btn-action-group">
                <button type="button" class="btn btn-outline-primary me-2" data-bs-toggle="modal" data-bs-target="#addTypeModal" style="border-radius: 10px;">
                    <i class="bi bi-tags-fill me-2"></i>ประเภทอาหาร
                </button>
                <a href="gotoAddMenu" class="add-btn">
                    <i class="bi bi-plus-lg me-2"></i>เพิ่มเมนูอาหาร
                </a>
            </div>
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
                        <th>สถานะ</th>
                        <th>จัดการ</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listmenuFood}" var="item" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td><img src="${item.foodImage}" class="food-image" /></td>
                            <td class="fw-bold">${item.foodname}</td>
                            <td><span class="badge bg-light text-dark">${item.foodtype}</span></td>
                            <td class="text-primary fw-bold">฿${item.price}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.status == 'พร้อมเสิร์ฟ'}">
                                        <span class="badge bg-success">พร้อมเสิร์ฟ</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-danger">${item.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="geteditMenufood?foodId=${item.foodId}" class="action-btn edit-btn">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <div class="text-center mt-4">
            <a href="home" class="btn btn-light" style="color: var(--primary-purple); font-weight: 600;">
                <i class="bi bi-house-fill me-2"></i>กลับหน้าหลัก
            </a>
        </div>
    </div>

    <div class="modal fade" id="addTypeModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header" style="background: var(--purple-gradient); color: white;">
                    <h5 class="modal-title">จัดการประเภทอาหาร</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="addFoodType" method="POST">
                        <div class="mb-3">
                            <label class="form-label fw-bold">ชื่อประเภทอาหาร</label>
                            <input type="text" name="foodtypeName" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100" style="background: var(--primary-purple); border: none;">บันทึก</button>
                    </form>
                    <hr>
                    <table class="table table-sm mt-3">
                        <c:forEach var="type" items="${foodTypes}">
                            <tr>
                                <td>${type.foodtypeName}</td>
                                <td class="text-end">
                                    <form action="deleteFoodType" method="post" style="display:inline;">
                                        <input type="hidden" name="foodtypeId" value="${type.foodtypeId}" />
                                        <button type="submit" class="btn btn-sm text-danger border-0"><i class="bi bi-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>