<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ระบบจัดการพนักงาน - ShaBu Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Kanit', sans-serif;
        }

        :root {
            --primary-color: #5d00a8; /* ม่วงเข้ม */
            --secondary-color: #f7f3ff; /* ม่วงอ่อน */
            --text-color: #333;
            --white: #ffffff;
            --shadow-light: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        body {
            background-color: var(--secondary-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        .container {
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background: var(--white);
            border-radius: 15px;
            box-shadow: var(--shadow-light);
        }

        /* Header / User Info */
        .user-header {
            text-align: center;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 3px solid var(--secondary-color);
        }

        .welcome-title {
            font-size: 2.2rem;
            color: var(--primary-color);
            margin-bottom: 10px;
            font-weight: 700;
        }

        .user-info p {
            font-size: 1.1rem;
            color: #666;
            margin: 5px 0;
            font-weight: 500;
        }
        
        /* Action Grid */
        .action-grid {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 25px;
            margin-top: 30px;
        }
        
        .action-grid form {
            display: inline-block;
        }

        .action-card {
            background-color: var(--primary-color);
            color: var(--white);
            padding: 30px;
            border-radius: 12px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            text-decoration: none;
            box-shadow: 0 6px 15px rgba(93, 0, 168, 0.4);
            cursor: pointer;
            border: none;
            font-size: 1rem;
            min-width: 250px;
        }

        .action-card:hover {
            transform: translateY(-8px);
            background-color: #7b00e0;
            box-shadow: 0 10px 20px rgba(93, 0, 168, 0.6);
        }

        .action-icon {
            font-size: 3rem;
            margin-bottom: 15px;
            color: var(--secondary-color);
        }

        .action-title {
            font-size: 1.4rem;
            font-weight: 600;
        }
        
        /* Form styling */
        form {
            margin: 0;
        }
        
        /* Logout Button */
        .logout-container {
            text-align: right;
            margin-top: 40px;
        }
        
        .logout-btn {
            background: #e0e0e0;
            color: var(--text-color);
            padding: 10px 20px;
            border-radius: 20px;
            text-decoration: none;
            font-weight: 500;
            transition: background 0.3s;
        }
        
        .logout-btn:hover {
            background: #c0c0c0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="user-header">
            <h1 class="welcome-title">👋 ยินดีต้อนรับ</h1>
            
            <div class="user-info">
                <%-- VVVV แก้ไข: ดึงข้อมูลจาก cashierUser โดยตรง VVVV --%>
                <p>รหัสพนักงาน: <strong>${user.empUsername}</strong></p>
                <p>ชื่อ: <strong>${user.empname}</strong></p>
                <p>ตำแหน่ง: <strong>${user.position}</strong></p>
                <%-- ^^^^ สิ้นสุดการแก้ไข ^^^^ --%>
            </div>
            
        </div>

        <h2 style="text-align: center; margin-bottom: 25px; font-weight: 600; color: var(--primary-color);">
            <i class="fas fa-tasks"></i> งาน
        </h2>

        <div class="action-grid">
            
            <%-- ปุ่มรายการออเดอร์ ถูกจัดให้อยู่ตรงกลางแล้ว --%>
            <form action="listTableReserveForCashierv2" method="POST">
                <button type="submit" class="action-card">
                    <div class="action-icon"><i class="fas fa-receipt"></i></div>
                    <div class="action-title">รายการออเดอร์</div>
                </button>
            </form>

        </div>

        <div class="logout-container">
            <a href="logoutmanager" class="logout-btn"><i class="fas fa-sign-out-alt"></i> ออกจากระบบ</a>
        </div>
    </div>
</body>
</html>