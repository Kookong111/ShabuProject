<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.springmvc.model.*" %>
<%
    Date currentDate = new Date();
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
    String formattedDate = dateFormat.format(currentDate);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Home | Manager</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free/css/all.css">
    <!-- Google Fonts: Poppins -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --purple-main: #7b2cbf;
            --purple-deep: #4c1874;
            --purple-light: #cbb7f6;
            --purple-bg: #ede6f6;
            --card-bg: #f6f3fa;
            --shadow: 0 8px 32px 0 rgba(123,44,191,0.11);
        }
        body {
            background: linear-gradient(110deg, #e5e2ee 0%, #efeafd 100%);
            font-family: 'Poppins', sans-serif;
            color: var(--purple-deep);
            min-height: 100vh;
        }
        .purple-navbar {
            background: linear-gradient(90deg, var(--purple-deep) 0%, var(--purple-main) 90%);
            box-shadow: 0 2px 14px rgba(123,44,191,0.10);
            padding: 1.2rem 0.5rem;
            border-radius: 0 0 18px 18px;
        }
        .navbar-brand {
            color: #fff !important;
            font-weight: 700;
            letter-spacing: 1px;
            font-size: 1.18rem;
        }
        .welcome-card {
            background: var(--card-bg);
            border-radius: 18px;
            box-shadow: var(--shadow);
            padding: 34px 24px 22px 24px;
            display: flex;
            align-items: center;
            margin-top: -30px;
            margin-bottom: 16px;
        }
        .avatar {
            width: 74px;
            height: 74px;
            background: linear-gradient(135deg, var(--purple-main), var(--purple-deep) 90%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: #fff;
            margin-right: 22px;
        }
        .welcome-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--purple-deep);
            margin-bottom: 3px;
            letter-spacing: 0.5px;
        }
        .last-login {
            color: var(--purple-main);
            font-size: 1.01rem;
            display: flex;
            align-items: center;
            font-weight: 500;
        }
        .divider {
            height: 2.5px;
            background: linear-gradient(90deg, var(--purple-main) 35%, #fff 90%);
            border-radius: 4px;
            margin: 22px 0 30px 0;
            opacity: 0.32;
        }
        .title-main {
            color: var(--purple-main);
            font-size: 1.7rem;
            font-weight: 700;
            letter-spacing: 0.9px;
        }
        /* Card Grid - 3x2 */
        .btn-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 36px 34px;
            margin: 0 auto 60px auto;
            max-width: 1100px;
        }
        .action-btn {
            background: linear-gradient(135deg, #f4f0fa 68%, #e6d5f7 100%);
            border-radius: 24px;
            box-shadow: 0 8px 28px 0 rgba(123,44,191,0.10);
            padding: 56px 10px 28px 10px;
            text-align: center;
            min-height: 210px;
            min-width: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: box-shadow .19s, transform .17s, background .21s;
            cursor: pointer;
            border: none;
            outline: none;
        }
        .action-btn:hover, .action-btn:focus {
            background: linear-gradient(120deg,#e0c3fc 75%, #cbb7f6 100%);
            box-shadow: 0 18px 44px 0 rgba(76,24,116,0.15), 0 3px 8px rgba(120,30,220,0.07);
            transform: translateY(-7px) scale(1.035);
        }
        .action-btn i {
            font-size: 3.2rem;
            color: var(--purple-main);
            margin-bottom: 20px;
            transition: color .18s;
        }
        .action-btn:hover i {
            color: var(--purple-deep);
        }
        .action-btn p {
            margin: 0;
            color: var(--purple-deep);
            font-size: 1.28rem;
            font-weight: 600;
            letter-spacing: 0.35px;
        }
        a.text-decoration-none {
            text-decoration: none !important;
        }
        /* Responsive */
        @media (max-width: 1199px) {
            .btn-grid { gap: 30px 20px; }
            .action-btn { padding: 44px 5px 20px 5px; min-height: 160px;}
            .action-btn i { font-size: 2.5rem; margin-bottom: 15px;}
            .action-btn p { font-size: 1.10rem;}
        }
        @media (max-width: 991px) {
            .btn-grid { grid-template-columns: repeat(2,1fr); gap: 24px 15px; }
        }
        @media (max-width: 767px) {
            .welcome-card { flex-direction: column; padding: 15px 7px 10px 7px; text-align: center; }
            .avatar { margin-bottom: 11px; margin-right: 0; width: 56px; height: 56px; font-size: 1.4rem;}
            .title-main { font-size: 1.1rem; }
            .btn-grid { grid-template-columns: 1fr; gap: 18px;}
            .action-btn { min-height: 90px; padding: 22px 4px 10px 4px;}
            .action-btn i { font-size: 1.5rem; margin-bottom: 8px;}
            .action-btn p { font-size: 0.98rem;}
        }
    </style>
</head>
<body>
    <!-- Purple Navbar -->
    <div class="purple-navbar shadow-sm mb-4">
        <div class="container d-flex align-items-center justify-content-between">
            <span class="navbar-brand mb-0"><i class="fas fa-home me-2"></i>Manager Dashboard</span>
        </div>
    </div>
    <div class="container">
        <!-- Welcome Card -->
        <div class="welcome-card shadow-sm">
            <div class="avatar"><i class="fas fa-user"></i></div>
            <div>
                <div class="welcome-title">สวัสดี, ผู้ดูแลระบบ!</div>
                <div class="last-login">
                    <i class="fas fa-clock me-2"></i>
                    เข้าสู่ระบบล่าสุด: <%= formattedDate %>
                </div>
            </div>
        </div>
        <div class="divider"></div>
        <!-- Main Content -->
        <div class="text-center mb-4">
            <div class="title-main mb-2">จัดการข้อมูล</div>
        </div>
        <div class="btn-grid">
            <a href="ManagerEmployee" class="text-decoration-none">
                <div class="action-btn" tabindex="0">
                    <i class="fas fa-users-cog"></i>
                    <p>จัดการข้อมูลพนักงาน</p>
                </div>
            </a>
            <a href="ListAllMenuFood" class="text-decoration-none">
                <div class="action-btn" tabindex="0">
                    <i class="fas fa-utensils"></i>
                    <p>จัดการข้อมูลอาหาร</p>
                </div>
            </a>
            <a href="ManageTable" class="text-decoration-none">
                <div class="action-btn" tabindex="0">
                    <i class="fas fa-chair"></i>
                    <p>จัดการข้อมูลโต๊ะ</p>
                </div>
            </a>
            <a href="listuser" class="text-decoration-none">
                <div class="action-btn" tabindex="0">
                    <i class="fas fa-file-invoice-dollar"></i>
                    <p>ดูรายการบิล</p>
                </div>
            </a>
            <a href="Addcoursepage" class="text-decoration-none">
                <div class="action-btn" tabindex="0">
                    <i class="fas fa-clipboard-check"></i>
                    <p>จัดการข้อมูลการสั่งอาหาร</p>
                </div>
            </a>
            <a href="logoutmanager" class="text-decoration-none">
                <div class="action-btn" tabindex="0">
                    <i class="fas fa-sign-out-alt"></i>
                    <p>ออกจากระบบ</p>
                </div>
            </a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
