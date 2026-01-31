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
            --primary-purple: #6b46c1; /* [cite: 36] */
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
            --purple-gradient: linear-gradient(135deg, #6b46c1 0%, #8b5cf6 100%);
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%); /* [cite: 39] */
            color: var(--text-dark);
            min-height: 100vh;
            margin: 0;
            padding: 20px 0;
        }

        .table-container {
            max-width: 1200px;
            margin: 0 auto;
            background: var(--white);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(107, 70, 193, 0.1);
            padding: 40px;
            border: 1px solid var(--border-light); /* [cite: 41, 42] */
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 2px solid var(--very-light-purple); /* [cite: 43] */
        }

        .title-section h2 {
            color: var(--primary-purple);
            font-weight: 700;
            font-size: 2rem;
            margin: 0;
        }

        /* ปุ่มจัดการเมนู */
        .btn-action-group {
            display: flex;
            gap: 10px;
        }

        .add-btn {
            background: var(--purple-gradient);
            border: none;
            padding: 10px 20px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            text-decoration: none;
            color: var(--white);
            transition: all 0.3s ease;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(107, 70, 193, 0.3); /* [cite: 47, 48] */
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(107, 70, 193, 0.4);
            color: var(--white);
        }

        .btn-type {
            border: 2px solid var(--primary-purple);
            color: var(--primary-purple);
            background: transparent;
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-type:hover {
            background: var(--very-light-purple);
            color: var(--purple-hover);
        }

        /* ตารางข้อมูล */
        .table-wrapper {
            overflow-x: auto;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(107, 70, 193, 0.05); /* [cite: 53] */
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }

        th {
            background: var(--purple-gradient);
            color: var(--white);
            padding: 20px 16px;
            text-align: center;
            font-weight: 600; /* [cite: 57, 58] */
        }

        td {
            padding: 20px 16px;
            text-align: center;
            border-bottom: 1px solid var(--border-light);
            vertical-align: middle; /* [cite: 61, 62] */
        }

        .food-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 12px;
            border: 3px solid var(--very-light-purple); /* [cite: 65, 66] */
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 40px;
            height: 40px;
            border-radius: 10px;
            text-decoration: none;
            margin: 0 4px; /* [cite: 68, 69] */
        }

        .edit-btn { background: rgba(16, 185, 129, 0.1); color: var(--success-green); }
        .edit-btn:hover { background: var(--success-green); color: var(--white); }
        .delete-btn { background: rgba(239, 68, 68, 0.1); color: var(--danger-red); }
        .delete-btn:hover { background: var(--danger-red); color: var(--white); }

        /* Modal Styles */
        .modal-content { border-radius: 16px; border: none; }
        .modal-header { background: var(--purple-gradient); color: white; border-top-left-radius: 16px; border-top-right-radius: 16px; }
    </style>
</head>

<body>

    <div class="table-container">
        <div class="header-section">
            <div class="title-section">
                <h2>รายการเมนูอาหาร</h2>
                <p class="menu-count">จำนวนเมนูทั้งหมด: ${listmenuFood.size()} เมนู</p> </div>
            
            <div class="btn-action-group">
                <button type="button" class="btn-type" data-bs-toggle="modal" data-bs-target="#addTypeModal">
                    <i class="bi bi-tags-fill me-2"></i>เพิ่มประเภทอาหาร
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
                        <th>แก้ไข</th>
                        <th>ลบ</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${listmenuFood}" var="item" varStatus="status">
                        <tr>
                            <td>${status.index + 1}</td>
                            <td>
                                <img src="${item.foodImage}" alt="Food" class="food-image" /> </td>
                            <td class="fw-bold">${item.foodname}</td>
                            <td><span class="badge bg-light text-dark">${item.foodtype}</span></td>
                            <td class="text-primary fw-bold">฿${item.price}</td>
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
            <div class="alert alert-warning text-center mt-3">${error_message}</div>
        </c:if>

        <div class="text-center mt-5">
            <a href="home" class="btn btn-light px-4 py-2" style="border-radius: 10px; font-weight: 600; color: var(--primary-purple);">
                <i class="bi bi-house-fill me-2"></i>กลับหน้าหลัก
            </a>
        </div>
    </div>

    <div class="modal fade" id="addTypeModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content shadow-lg">
            <div class="modal-header">
                <h5 class="modal-title"><i class="bi bi-tag-plus me-2"></i>จัดการประเภทอาหาร</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">
                <form action="addFoodType" method="POST">
                    <div class="mb-3">
                        <label class="form-label fw-bold">ชื่อประเภทอาหารใหม่</label>
                        <input type="text" name="foodtypeName" class="form-control" placeholder="เช่น ของหวาน, เครื่องดื่ม" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-bold">รายละเอียด (ถ้ามี)</label>
                        <textarea name="description" class="form-control" rows="2" placeholder="ระบุรายละเอียดเพิ่มเติม..."></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary w-100 mb-3" style="background: var(--primary-purple); border: none;">บันทึกข้อมูล</button>
                </form>

                <hr>

                <div class="mb-2">
                    <label class="form-label fw-bold">รายการที่มีอยู่/ลบประเภทอาหาร</label>
                    <div style="max-height:180px; overflow-y:auto;">
                        <table class="table table-sm table-bordered align-middle mb-0">
                            <thead>
                                <tr style="background:var(--very-light-purple)"><th>ชื่อประเภท</th><th class="text-center">ลบ</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="type" items="${foodTypes}">
                                    <tr>
                                        <td>${type.foodtypeName}</td>
                                        <td class="text-center">
                                            <form action="deleteFoodType" method="post" style="display:inline;" onsubmit="return confirm('ต้องการลบประเภทอาหารนี้หรือไม่?');">
                                                <input type="hidden" name="foodtypeId" value="${type.foodtypeId}" />
                                                <button type="submit" class="btn btn-sm btn-outline-danger border-0"><i class="bi bi-trash"></i></button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">ปิดหน้าต่าง</button>
            </div>
        </div>
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
                }).then(response => {
                    if(response.ok) location.reload();
                });
            }
        }
    </script>
</body>
</html>