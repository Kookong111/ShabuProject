<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <title>ข้อผิดพลาดการสั่งอาหาร</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Kanit', sans-serif; background-color: #f8f9fa; color: #343a40; text-align: center; padding-top: 100px; }
        .error-box { max-width: 600px; margin: 0 auto; padding: 40px; border-radius: 12px; background: #ffffff; box-shadow: 0 4px 12px rgba(0,0,0,0.1); }
        .icon-fail { font-size: 60px; color: #dc3545; margin-bottom: 20px; }
        h2 { margin-bottom: 20px; color: #dc3545; }
        p { margin-bottom: 25px; font-size: 16px; line-height: 1.6; }
        .action-link { display: inline-block; padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: 500; transition: background 0.3s; }
        .btn-reserve { background-color: #007bff; color: white; margin-right: 15px; }
        .btn-reserve:hover { background-color: #0056b3; }
        .btn-home { background-color: #6c757d; color: white; }
        .btn-home:hover { background-color: #5a6268; }
    </style>
</head>
<body>
    <div class="error-box">
        <div class="icon-fail"><i class="fas fa-exclamation-circle"></i></div>
        <h2>ไม่สามารถเริ่มสั่งอาหารได้</h2>
        <p>${errorMessage}</p>
        
        <p>หากคุณยังไม่ได้จองโต๊ะ กรุณาจองโต๊ะก่อนดำเนินการ:</p>
        
        <a href="listTable" class="action-link btn-reserve">
            <i class="fas fa-calendar-alt"></i> จองโต๊ะ
        </a>
        <a href="gotowelcomeCustomer" class="action-link btn-home">
            <i class="fas fa-home"></i> กลับหน้าหลัก
        </a>
    </div>
</body>
</html>