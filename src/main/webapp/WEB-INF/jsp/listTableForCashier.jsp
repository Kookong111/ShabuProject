<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>รายการออเดอร์</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

                <style>
                    :root {
                        --primary: #1976d2;
                        --primary-dark: #115293;
                        --gray-bg: #f7f8fa;
                        --gray-card: #fff;
                        --gray-border: #e5e7eb;
                        --gray-text: #222;
                        --gray-label: #888;
                        --success: #2ecc71;
                        --warning: #f7b731;
                        --danger: #e74c3c;
                        --table-header-bg: #f3f6fa;
                        --table-header-border: #e5e7eb;
                        --table-row-hover: #f5f7fa;
                        --empty-bg: #f3f6fa;
                        --empty-icon-bg: #e3e8ee;
                    }
                    html, body {
                        font-family: 'Kanit', sans-serif;
                        background: var(--gray-bg);
                        min-height: 100vh;
                        margin: 0;
                        padding: 0;
                        color: var(--gray-text);
                    }
                    body {
                        padding: 32px 0;
                    }
                    .container {
                        max-width: 1100px;
                        margin: 0 auto;
                        padding: 0 16px;
                    }
                    .page-header {
                        background: var(--gray-card);
                        border-radius: 16px;
                        padding: 28px 22px 18px 22px;
                        margin-bottom: 28px;
                        box-shadow: 0 2px 12px rgba(30,40,60,0.06);
                        border: 1px solid var(--gray-border);
                    }
                    .page-title {
                        font-size: 1.5rem;
                        font-weight: 700;
                        color: var(--primary-dark);
                        margin-bottom: 0.5rem;
                        display: block;
                    }
                    .page-subtitle {
                        color: var(--gray-label);
                        font-size: 1rem;
                        margin-bottom: 0.5rem;
                    }
                    .order-count {
                        display: inline-block;
                        background: var(--empty-bg);
                        padding: 0.45rem 1.1rem;
                        border-radius: 30px;
                        font-size: 0.98rem;
                        font-weight: 600;
                        color: var(--primary-dark);
                        margin-top: 0.7rem;
                    }
                    .table-responsive {
                        width: 100%;
                        overflow-x: auto;
                        background: var(--gray-card);
                        border-radius: 12px;
                        box-shadow: 0 2px 8px rgba(30,40,60,0.06);
                        margin-bottom: 16px;
                    }
                    .order-table {
                        width: 100%;
                        border-collapse: separate;
                        border-spacing: 0;
                        min-width: 900px;
                        background: var(--gray-card);
                    }
                    .order-table th, .order-table td {
                        padding: 13px 16px;
                        text-align: left;
                        border-bottom: 1px solid var(--gray-border);
                        font-size: 1rem;
                    }
                    .order-table th {
                        background: var(--table-header-bg);
                        color: var(--primary-dark);
                        font-weight: 700;
                        font-size: 1.01rem;
                        border-bottom: 2px solid var(--table-header-border);
                        position: sticky;
                        top: 0;
                        z-index: 2;
                    }
                    .order-table tr {
                        transition: background 0.15s;
                    }
                    .order-table tr:hover {
                        background: var(--table-row-hover);
                    }
                    .order-table td {
                        vertical-align: middle;
                        color: var(--gray-text);
                    }
                    .order-table td:last-child, .order-table th:last-child {
                        text-align: center;
                    }
                    .order-table th, .order-table td {
                        border-right: 1px solid var(--gray-border);
                    }
                    .order-table th:last-child, .order-table td:last-child {
                        border-right: none;
                    }
                    .status-badge {
                        display: inline-block;
                        padding: 5px 14px;
                        border-radius: 12px;
                        font-size: 0.97rem;
                        font-weight: 600;
                        background: var(--empty-bg);
                        color: var(--gray-label);
                        letter-spacing: 0.01em;
                        text-transform: uppercase;
                    }
                    .status-badge.completed {
                        background: var(--success);
                        color: #fff;
                    }
                    .status-badge.pending {
                        background: var(--warning);
                        color: #fff;
                    }
                    .status-badge.open {
                        background: #e3e8ee;
                        color: var(--primary-dark);
                    }
                    .btn-primary-action {
                        background: var(--primary);
                        color: #fff;
                        padding: 7px 18px;
                        border-radius: 7px;
                        text-decoration: none;
                        font-weight: 600;
                        font-size: 0.97rem;
                        transition: background 0.18s, color 0.18s;
                        border: none;
                        box-shadow: 0 1px 4px rgba(30,40,60,0.06);
                        display: inline-block;
                        margin-right: 6px;
                    }
                    .btn-primary-action:hover {
                        background: var(--primary-dark);
                        color: #fff;
                    }
                    .btn-secondary-action {
                        background: var(--empty-bg);
                        color: var(--primary-dark);
                        border: 1px solid var(--gray-border);
                        padding: 7px 18px;
                        border-radius: 7px;
                        font-weight: 600;
                        font-size: 0.97rem;
                        transition: background 0.18s, color 0.18s;
                        box-shadow: 0 1px 4px rgba(30,40,60,0.04);
                        display: inline-block;
                    }
                    .btn-secondary-action:hover {
                        background: var(--primary);
                        color: #fff;
                    }
                    .empty-state {
                        background: var(--empty-bg);
                        border-radius: 14px;
                        padding: 3.5rem 1.5rem;
                        text-align: center;
                        box-shadow: 0 2px 8px rgba(30,40,60,0.06);
                        border: 1px solid var(--gray-border);
                    }
                    .empty-icon {
                        width: 90px;
                        height: 90px;
                        margin: 0 auto 1.2rem;
                        background: var(--empty-icon-bg);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        font-size: 2.2rem;
                        color: var(--primary-dark);
                    }
                    .empty-title {
                        font-size: 1.2rem;
                        font-weight: 700;
                        color: var(--primary-dark);
                        margin-bottom: 0.4rem;
                    }
                    .empty-text {
                        color: var(--gray-label);
                        font-size: 1rem;
                    }
                    .home-btn-container {
                        text-align: center;
                        margin-top: 2.2rem;
                    }
                    .home-btn {
                        display: inline-flex;
                        align-items: center;
                        gap: 0.7rem;
                        padding: 0.9rem 2.2rem;
                        background: var(--primary);
                        color: #fff;
                        border-radius: 30px;
                        font-weight: 600;
                        font-size: 1rem;
                        text-decoration: none;
                        box-shadow: 0 2px 8px rgba(30,40,60,0.06);
                        transition: background 0.18s, color 0.18s, box-shadow 0.18s, transform 0.18s;
                    }
                    .home-btn:hover {
                        background: var(--primary-dark);
                        color: #fff;
                        box-shadow: 0 6px 18px rgba(30,40,60,0.10);
                        transform: translateY(-2px) scale(1.01);
                    }
                    @media (max-width: 700px) {
                        .container {
                            padding: 0;
                        }
                        .table-responsive {
                            border-radius: 7px;
                        }
                        .order-table th, .order-table td {
                            padding: 10px 7px;
                            font-size: 0.97rem;
                        }
                        .page-header {
                            padding: 22px 10px 16px 10px;
                        }
                        .order-table {
                            min-width: 600px;
                        }
                    }
                </style>
</head>

<body>
    <div class="container">
        <div class="page-header">
            <h1 class="page-title">
                รายการออเดอร์
            </h1>
            <p class="page-subtitle">
                แสดงออเดอร์ทั้งหมดที่รอการชำระเงิน หรืออยู่ในสถานะกำลังดำเนินการ
            </p>
            <div class="order-count">
                <i class="fas fa-list-ul"></i>
                <span>จำนวนออเดอร์: <c:out value="${ordersList.size()}" default="0"/> รายการ</span>
            </div>
        </div>

                <!-- Search Bar -->
                <div class="row mb-3" style="max-width: 400px; margin: 0 0 18px 0;">
                    <div class="col-12">
                        <input type="text" id="tableSearchInput" class="form-control" placeholder="ค้นหาเลขโต๊ะ..." style="font-size:1.05rem; border-radius: 8px; border: 1.5px solid #e5e7eb;">
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty ordersList}">
                        <div class="table-responsive">
                            <table class="order-table" id="orderTable">
                                <thead>
                                    <tr>
                                        <th>รหัสออเดอร์</th>
                                        <th>โต๊ะ</th>
                                        <th>วันที่</th>                                       
                                        <th>ยอดรวม (฿)</th>
                                        <th>จัดการ</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${ordersList}" var="order">
                                        <c:choose>
                                            <c:when test="${order.status == 'เสร็จสิ้น'}">
                                                <c:set var="statusClass" value="completed" />
                                            </c:when>
                                            <c:when test="${order.status == 'Open'}">
                                                <c:set var="statusClass" value="open" />
                                            </c:when>
                                            <c:otherwise>
                                                <c:set var="statusClass" value="pending" />
                                            </c:otherwise>
                                        </c:choose>
                                        <tr data-table="${order.table.tableid}">
                                            <td>#${order.oderId}</td>
                                            <td>${order.table.tableid}</td>
                                            <td>${order.orderDate}</td>
                                            
                                            <td><span style="font-weight:700; color:var(--primary);">฿<c:out value="${order.totalPeice}" default="0.00"/></span></td>
                                            <td>
                                                <a href="checkbill-page?orderId=${order.oderId}" class="btn-primary-action">
                                                    <i class="fas fa-money-check-alt"></i> ชำระเงิน
                                                </a>
                                                <a href="geteditOrderStatus?oderId=${order.oderId}" class="btn-secondary-action">
                                                    <i class="fas fa-edit"></i> แก้ไข
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-icon">
                                <i class="fas fa-inbox"></i>
                            </div>
                            <h3 class="empty-title">ไม่พบรายการออเดอร์</h3>
                            <p class="empty-text">ไม่มีออเดอร์ที่รอดำเนินการในขณะนี้</p>
                        </div>
                    </c:otherwise>
                </c:choose>

        <div class="home-btn-container">
            <a href="homecashier" class="home-btn">
                <i class="fas fa-home"></i>
                กลับหน้าหลัก
            </a>
        </div>
    </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    // Search/filter table by table number (for table layout)
                    document.addEventListener('DOMContentLoaded', function() {
                        const searchInput = document.getElementById('tableSearchInput');
                        const orderRows = document.querySelectorAll('#orderTable tbody tr');
                        if (!searchInput) return;
                        searchInput.addEventListener('input', function() {
                            const val = this.value.trim();
                            if (!val) {
                                orderRows.forEach(row => row.style.display = '');
                                return;
                            }
                            orderRows.forEach(row => {
                                const tableNum = row.getAttribute('data-table') || '';
                                if (tableNum.includes(val)) {
                                    row.style.display = '';
                                } else {
                                    row.style.display = 'none';
                                }
                            });
                        });
                    });
                </script>
</body>
</html>