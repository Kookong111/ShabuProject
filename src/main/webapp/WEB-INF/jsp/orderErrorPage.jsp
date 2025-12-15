<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ข้อผิดพลาดการสั่งอาหาร</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-red: #dc3545;
                --primary-blue: #007bff;
                --primary-gray: #6c757d;
                --bg-gradient: #fff;
                --box-shadow: none;
                --border-radius: 18px;
                --font-main: 'Kanit', 'Poppins', Arial, sans-serif;
            }
            body {
                font-family: var(--font-main);
                background: #fff;
                color: #343a40;
                min-height: 100vh;
                min-width: 100vw;
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                overflow-x: hidden;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .error-box {
                width: 100%;
                max-width: 400px;
                margin: 0 auto;
                padding: 32px 20px 24px 20px;
                border-radius: var(--border-radius);
                background: #fff;
                box-shadow: none;
                display: flex;
                flex-direction: column;
                align-items: center;
                position: relative;
                z-index: 1;
                overflow-y: auto;
                top: 0;
            }
            .icon-fail {
                font-size: 48px;
                color: var(--primary-red);
                margin-bottom: 14px;
                filter: drop-shadow(0 2px 8px rgba(220,53,69,0.10));
            }
            h2 {
                margin-bottom: 14px;
                color: var(--primary-red);
                font-size: 1.4rem;
                font-weight: 700;
                letter-spacing: 0.01em;
                text-align: center;
            }
            p {
                margin-bottom: 18px;
                font-size: 1.01rem;
                line-height: 1.6;
                color: #444;
                text-align: center;
            }
            .action-link {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                padding: 11px 18px;
                border-radius: 8px;
                text-decoration: none;
                font-weight: 600;
                font-size: 1rem;
                margin-bottom: 10px;
                margin-right: 0;
                box-shadow: 0 2px 8px rgba(0,0,0,0.04);
                border: none;
                transition: all 0.18s cubic-bezier(.4,0,.2,1);
                gap: 8px;
                min-width: 120px;
                max-width: 90vw;
            }
            .action-link i {
                font-size: 1em;
                margin-right: 6px;
            }
            .btn-reserve {
                background: #fff;
                color: var(--primary-blue);
                margin-right: 8px;
                border: 2px solid var(--primary-blue);
            }
            .btn-reserve:hover {
                background: var(--primary-blue);
                color: #fff;
                border-color: var(--primary-blue);
            }
            .btn-home {
                background: #fff;
                color: var(--primary-gray);
                border: 2px solid var(--primary-gray);
            }
            .btn-home:hover {
                background: var(--primary-gray);
                color: #fff;
                border-color: var(--primary-gray);
            }

            /* Tablet */
            @media (max-width: 1024px) {
                .error-box {
                    max-width: 95vw;
                    padding: 24px 10vw 18px 10vw;
                    margin-top: 18px;
                }
                h2 {
                    font-size: 1.15rem;
                }
                .action-link {
                    font-size: 0.97rem;
                    padding: 10px 10px;
                }
            }
            /* Mobile */
            @media (max-width: 600px) {
                body {
                    padding: 0;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                .error-box {
                    width: 100vw;
                    max-width: 98vw;
                    min-width: 0;
                    margin: 0 auto;
                    padding: 16px 2vw 16px 2vw;
                    border-radius: 10px;
                    box-shadow: none;
                }
                .icon-fail {
                    font-size: 28px;
                }
                h2 {
                    font-size: 0.98rem;
                }
                p {
                    font-size: 0.93rem;
                }
                .action-link {
                    font-size: 0.91rem;
                    padding: 8px 4px;
                    width: 94vw;
                    max-width: 260px;
                }
            }
            /* Extra Small Mobile */
            @media (max-width: 400px) {
                .error-box {
                    padding: 5px 1vw 5px 1vw;
                    border-radius: 5px;
                    margin-top: 4px;
                }
                h2 {
                    font-size: 0.85rem;
                }
                .action-link {
                    font-size: 0.81rem;
                    padding: 6px 2px;
                    max-width: 99vw;
                }
            }
        </style>
</head>
<body>
    <div class="error-box">
        <div class="icon-fail"><i class="fas fa-exclamation-circle"></i></div>
        <h2>ไม่สามารถสั่งอาหารได้</h2>
        <p>${errorMessage}</p>
        <p>หากคุณยังไม่ได้จองโต๊ะ กรุณาจองโต๊ะก่อนดำเนินการ</p>
        <a href="listTable" class="action-link btn-reserve">
            <i class="fas fa-calendar-alt"></i> จองโต๊ะ
        </a>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <a href="gotowelcomeCustomer" class="action-link btn-home">
                    <i class="fas fa-home"></i> กลับหน้าหลัก
                </a>
            </c:when>
            <c:otherwise>
                <a href="gotologin" class="action-link btn-home">
                    <i class="fas fa-sign-in-alt"></i> กลับเข้าสู่ระบบ
                </a>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>