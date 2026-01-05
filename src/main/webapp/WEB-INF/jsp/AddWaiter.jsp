<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>เพิ่มพนักงาน</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-purple: #7047eb;
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
        .btn-primary {
            background-color: var(--primary-purple);
            border: none;
            border-radius: 10px;
            font-size: 1.05rem;
            font-weight: 600;
            padding: 12px;
            width: 100%;
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
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2><i class="fas fa-user-plus"></i> เพิ่มพนักงานเสิร์ฟ</h2>
        <c:if test="${not empty add_result}">
            <div class="result-message">
                <div class="success-message">${add_result}</div>
            </div>
        </c:if>
        <form action="Add_Waiter" method="post">
            <div class="mb-3">
                <label for="empusername" class="form-label"><i class="fas fa-user"></i>ชื่อผู้ใช้งาน</label>
                <input type="text" class="form-control" id="empusername" name="empusername" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label"><i class="fas fa-lock"></i>รหัสผ่าน</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="mb-3">
                <label for="empname" class="form-label"><i class="fas fa-id-card"></i>ชื่อ - นามสกุล</label>
                <input type="text" class="form-control" id="empname" name="empname" required>
            </div>
            <div class="mb-3">
                <label for="age" class="form-label"><i class="fas fa-calendar"></i>อายุ</label>
                <input type="number" class="form-control" id="age" name="age" required>
            </div>
            <div class="mb-3">
                <label for="position" class="form-label"><i class="fas fa-briefcase"></i>ตำแหน่ง</label>
                <select class="form-control form-control-select" id="position" name="position">
                    <option>พนักงานเสิร์ฟ</option>
                    <option>แคชเชียร์</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="url" class="form-label"><i class="fas fa-image"></i>URL รูปภาพ</label>
                <input type="url" class="form-control" id="url" name="url" required>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-plus-circle"></i> เพิ่มพนักงาน
            </button>
        </form>
        <hr>
        <div class="form-links">
            <a href="listwaiter"><i class="fas fa-arrow-left"></i> กลับหน้าหลัก</a>
        </div>
    </div>
</body>
</html>
