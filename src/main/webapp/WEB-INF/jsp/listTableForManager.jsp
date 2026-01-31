<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="com.springmvc.model.*" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>จัดการโต๊ะ</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary-purple: #7c3aed;
            --secondary-purple: #a855f7;
            --light-purple: #c4b5fd;
            --bg-purple: #f3f0ff;
            --accent-purple: #5b21b6;
            --purple-gradient: linear-gradient(135deg, #7c3aed 0%, #a855f7 100%);
            
            --neutral-50: #fafafa;
            --neutral-100: #f5f5f5;
            --neutral-200: #e5e5e5;
            --neutral-300: #d4d4d4;
            --neutral-600: #525252;
            --neutral-700: #404040;
            --neutral-800: #262626;
            --neutral-900: #171717;
            
            --success: #059669;
            --success-light: #ecfdf5;
            --danger: #dc2626;
            --danger-light: #fef2f2;
            --warning: #d97706;
            --warning-light: #fffbeb;
            
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow: 0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1);
            --shadow-md: 0 4px 6px -1px rgb(0 0 0 / 0.1), 0 2px 4px -2px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
            
            --radius-sm: 6px;
            --radius: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 20px;
        }

        * {
            box-sizing: border-box;
        }

        body {
            font-family: 'Kanit', sans-serif;
            background: linear-gradient(to bottom right, var(--bg-purple), var(--neutral-50));
            color: var(--neutral-800);
            min-height: 100vh;
            margin: 0;
            padding: 20px;
            line-height: 1.6;
        }

        .main-container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-xl);
            overflow: hidden;
            border: 1px solid var(--neutral-200);
        }

        .header-section {
            background: var(--purple-gradient);
            padding: 2rem;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .header-section::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 50%;
            transform: translate(100px, -100px);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            z-index: 1;
        }

        .title-section h1 {
            font-weight: 600;
            font-size: 2.25rem;
            margin: 0;
            letter-spacing: -0.025em;
        }

        .table-count {
            font-weight: 400;
            font-size: 1rem;
            margin: 0.5rem 0 0 0;
            opacity: 0.9;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .add-btn {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 60px;
            height: 60px;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            justify-content: center;
            text-decoration: none;
            color: white;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .add-btn::before {
            content: '';
            position: absolute;
            inset: 0;
            background: rgba(255, 255, 255, 0.1);
            border-radius: var(--radius-lg);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .add-btn:hover::before {
            opacity: 1;
        }

        .add-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.15);
            color: white;
        }

        .add-btn i {
            font-size: 1.5rem;
            position: relative;
            z-index: 1;
        }

        .content-section {
            padding: 2rem;
        }

        .tables-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .table-card {
            background: white;
            border: 1px solid var(--neutral-200);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .table-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--purple-gradient);
        }

        .table-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-xl);
            border-color: var(--light-purple);
        }

        .table-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1rem;
        }

        .table-number {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 48px;
            height: 48px;
            background: var(--purple-gradient);
            color: white;
            border-radius: var(--radius-md);
            font-size: 1.25rem;
            font-weight: 600;
            box-shadow: var(--shadow-md);
        }

        .table-status {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
            background: var(--success-light);
            color: var(--success);
            border: 1px solid rgba(5, 150, 105, 0.2);
        }

        .table-info {
            margin-bottom: 1.5rem;
        }

        .table-id {
            font-size: 1.125rem;
            font-weight: 600;
            color: var(--neutral-800);
            margin-bottom: 0.5rem;
        }

        .table-capacity {
            color: var(--neutral-600);
            font-weight: 400;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }

        .capacity-icon {
            width: 20px;
            height: 20px;
            background: var(--bg-purple);
            border-radius: var(--radius-sm);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-purple);
        }

        .table-actions {
            display: flex;
            gap: 0.5rem;
        }

        .action-btn {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 40px;
            border-radius: var(--radius);
            text-decoration: none;
            transition: all 0.2s ease;
            font-size: 0.875rem;
            font-weight: 500;
            border: 1px solid;
        }

        .edit-btn {
            background: var(--success-light);
            color: var(--success);
            border-color: rgba(5, 150, 105, 0.2);
        }

        .edit-btn:hover {
            background: var(--success);
            color: white;
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        .delete-btn {
            background: var(--danger-light);
            color: var(--danger);
            border-color: rgba(220, 38, 38, 0.2);
        }

        .delete-btn:hover {
            background: var(--danger);
            color: white;
            transform: translateY(-1px);
            box-shadow: var(--shadow-md);
        }

        .error-message {
            background: var(--danger-light);
            color: var(--danger);
            padding: 1rem;
            border-radius: var(--radius-md);
            text-align: center;
            margin: 1.5rem 0;
            font-weight: 500;
            border: 1px solid rgba(220, 38, 38, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .back-section {
            background: var(--neutral-50);
            padding: 2rem;
            text-align: center;
            border-top: 1px solid var(--neutral-200);
        }

        .back-link {
            color: var(--primary-purple);
            text-decoration: none;
            font-weight: 500;
            padding: 0.75rem 2rem;
            border-radius: var(--radius-md);
            background: white;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            border: 1px solid var(--neutral-200);
            box-shadow: var(--shadow-sm);
        }

        .back-link:hover {
            background: var(--primary-purple);
            color: white;
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            border-color: var(--primary-purple);
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--neutral-600);
        }

        .empty-state-icon {
            width: 80px;
            height: 80px;
            background: var(--bg-purple);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            color: var(--primary-purple);
        }

        .empty-state-icon i {
            font-size: 2rem;
        }

        .empty-state h3 {
            color: var(--neutral-800);
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .empty-state p {
            color: var(--neutral-600);
            margin: 0;
        }



        @media (max-width: 768px) {
            body {
                padding: 10px;
            }

            .main-container {
                border-radius: var(--radius-lg);
            }

            .header-section {
                padding: 1.5rem;
            }

            .header-content {
                flex-direction: column;
                text-align: center;
                gap: 1rem;
            }

            .title-section h1 {
                font-size: 1.75rem;
            }

            .content-section {
                padding: 1.5rem;
            }

            .tables-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .table-card {
                padding: 1.25rem;
            }



            .back-section {
                padding: 1.5rem;
            }
        }

        /* Smooth animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .table-card {
            animation: fadeInUp 0.6s ease forwards;
        }

        .table-card:nth-child(1) { animation-delay: 0.1s; }
        .table-card:nth-child(2) { animation-delay: 0.2s; }
        .table-card:nth-child(3) { animation-delay: 0.3s; }
        .table-card:nth-child(4) { animation-delay: 0.4s; }
    </style>
</head>

<body>

    <div class="main-container">
        <div class="header-section">
            <div class="header-content">
                <div class="title-section">
                    <h1>จัดการโต๊ะ</h1>
                    <p class="table-count">
                        <i class="bi bi-table"></i>
                        จำนวนโต๊ะทั้งหมด: ${listTable1.size()} โต๊ะ
                    </p>
                </div>
                <a href="gotoAddTable" class="add-btn" title="เพิ่มโต๊ะใหม่">
                    <i class="bi bi-plus-lg"></i>
                </a>
            </div>
        </div>

        <div class="content-section">

            <c:choose>
                <c:when test="${empty listTable1}">
                    <div class="empty-state">
                        <div class="empty-state-icon">
                            <i class="bi bi-table"></i>
                        </div>
                        <h3>ยังไม่มีโต๊ะ</h3>
                        <p>เริ่มต้นโดยการเพิ่มโต๊ะใหม่เพื่อเริ่มการจัดการร้านอาหาร</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="tables-grid">
                        <c:forEach items="${listTable1}" var="item" varStatus="status">
                            <div class="table-card">
                                <div class="table-header">
                                    <div class="table-number">
                                        ${item.tableid}
                                    </div>
                                    
                                </div>
                                
                                <div class="table-info">
                                    <div class="table-id">โต๊ะหมายเลข ${item.tableid}</div>
                                    <div class="table-capacity">
                                        <div class="capacity-icon">
                                            <i class="bi bi-people-fill"></i>
                                        </div>
                                        <span>รองรับ ${item.capacity} ที่นั่ง</span>
                                    </div>
                                </div>

                                <div class="table-actions">
                                    <a href="geteditTable?tableid=${item.tableid}" class="action-btn edit-btn" title="แก้ไขโต๊ะ">
                                        <i class="bi bi-pencil-square me-1"></i> แก้ไข
                                    </a>
                                    <a href="#" onclick="deleteTable('${item.tableid}')" class="action-btn delete-btn" title="ลบโต๊ะ">
                                        <i class="bi bi-trash3-fill me-1"></i> ลบ
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

            <c:if test="${not empty error_message}">
                <div class="error-message">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    ${error_message}
                </div>
            </c:if>
        </div>

        <div class="back-section">
            <a href="home" class="back-link">
                <i class="bi bi-house-fill"></i>
                กลับหน้าหลัก
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function deleteTable(tableid) {
            if (confirm('คุณต้องการลบโต๊ะหมายเลข ' + tableid + ' หรือไม่?\n\nการกระทำนี้ไม่สามารถยกเลิกได้')) {
                // Show loading state
                const deleteBtn = event.target.closest('.delete-btn');
                const originalContent = deleteBtn.innerHTML;
                deleteBtn.innerHTML = '<i class="bi bi-hourglass-split me-1"></i> กำลังลบ...';
                deleteBtn.style.pointerEvents = 'none';
                
                fetch('deleteTable', {
    method: 'POST',
    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
    body: 'empusername=' + encodeURIComponent(tableid)
})
.then(response => response.text())
.then(data => {
    if (data.trim() === "success") {
        // ถ้า Backend ส่ง success กลับมา ค่อยทำ Animation และ Reload
        const card = deleteBtn.closest('.table-card');
        card.style.opacity = '0';
        card.style.transform = 'translateY(-20px)';
        setTimeout(() => location.reload(), 300);
    } else {
        throw new Error("Delete failed on server");
    }
})
.catch(error => {
    console.error('Error:', error);
    deleteBtn.innerHTML = originalContent;
    deleteBtn.style.pointerEvents = 'auto';
    alert('เกิดข้อผิดพลาดในการลบโต๊ะ หรือระบบไม่ตอบสนอง');
});
            }
        }

        // Add smooth scroll behavior
        document.documentElement.style.scrollBehavior = 'smooth';
    </script>

</body>
</html>