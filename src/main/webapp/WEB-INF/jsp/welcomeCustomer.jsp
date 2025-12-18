<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShaBu Restaurant - Authentic Japanese Hot Pot</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --bg-primary: #fafafa;
            --bg-card: #ffffff;
            --text-primary: #1a1a1a;
            --text-secondary: #6c757d;
            --accent: #2c2c2c;
            --border: rgba(0, 0, 0, 0.08);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.06);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 16px 48px rgba(0, 0, 0, 0.12);
            --quick-action-color: #FF6F61; 
            --quick-action-shadow: rgba(255, 111, 97, 0.4);
        }

        body {
            font-family: 'Kanit', sans-serif;
            line-height: 1.6;
            color: var(--text-primary);
            background: var(--bg-primary);
            overflow-x: hidden;
        }

        /* Navigation */
        nav {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            padding: 20px 5%;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border);
            z-index: 1000;
            transition: transform 0.3s ease;
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            max-width: 1400px;
            margin: 0 auto;
        }

        .logo {
            font-size: 28px;
            font-weight: 600;
            color: var(--text-primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 40px;
            align-items: center;
        }

        .nav-menu a {
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 400;
            font-size: 15px;
            padding: 8px 0;
            position: relative;
            transition: all 0.3s ease;
        }

        .nav-menu a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--text-primary);
            transition: width 0.3s ease;
        }

        .nav-menu a:hover::after,
        .nav-menu a.active::after {
            width: 100%;
        }

        .nav-menu a:hover {
            color: var(--accent);
        }

        /* User Actions */
        .user-actions {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 16px;
            background: rgba(0, 0, 0, 0.04);
            border-radius: 24px;
            font-size: 14px;
            color: var(--text-primary);
            font-weight: 400;
        }

        .user-icon {
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 14px;
        }

        .logout-btn {
            padding: 8px 20px;
            background: rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
            border-radius: 24px;
            color: var(--text-primary);
            text-decoration: none;
            font-size: 14px;
            font-weight: 400;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logout-btn:hover {
            background: rgba(0, 0, 0, 0.08);
            border-color: rgba(0, 0, 0, 0.15);
        }

        /* Mobile Menu */
        .mobile-menu-btn {
            display: none;
            flex-direction: column;
            gap: 4px;
            background: none;
            border: none;
            cursor: pointer;
            padding: 8px;
        }

        .mobile-menu-btn span {
            width: 24px;
            height: 2px;
            background: var(--text-primary);
            border-radius: 2px;
            transition: all 0.3s ease;
        }

        /* Hero Section */
        .hero {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 120px 5% 80px;
            background: linear-gradient(135deg, #fafafa 0%, #f0f0f0 100%);
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 30%, rgba(102, 126, 234, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(118, 75, 162, 0.05) 0%, transparent 50%);
            pointer-events: none;
        }

        .hero-content {
            max-width: 1400px;
            width: 100%;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 80px;
            align-items: center;
            position: relative;
            z-index: 1;
        }

        .hero-text {
            animation: fadeInLeft 1s ease-out;
        }

        .hero-subtitle {
            font-size: 14px;
            color: var(--text-secondary);
            font-weight: 400;
            margin-bottom: 16px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .hero-title {
            font-size: clamp(3rem, 6vw, 5rem);
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 24px;
            line-height: 1.1;
        }

        .hero-description {
            font-size: 18px;
            color: var(--text-secondary);
            margin-bottom: 40px;
            line-height: 1.8;
            max-width: 540px;
        }

        .hero-buttons {
            display: flex;
            gap: 16px;
            flex-wrap: wrap;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 16px 32px;
            font-size: 15px;
            font-weight: 500;
            text-decoration: none;
            border-radius: 12px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            font-family: 'Kanit', sans-serif;
        }

        .btn-primary {
            background: var(--text-primary);
            color: white;
            box-shadow: var(--shadow-md);
        }

        .btn-primary:hover {
            background: var(--accent);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: white;
            color: var(--text-primary);
            border: 1px solid var(--border);
            box-shadow: var(--shadow-sm);
        }

        .btn-secondary:hover {
            background: rgba(0, 0, 0, 0.02);
            border-color: rgba(0, 0, 0, 0.15);
        }

        /* Hero Image */
        .hero-image {
            position: relative;
            animation: fadeInRight 1s ease-out;
        }

        .hero-image-container {
            width: 100%;
            height: 500px;
            background: white;
            border-radius: 24px;
            overflow: hidden;
            box-shadow: var(--shadow-lg);
            position: relative;
        }

        .hero-image-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            filter: brightness(0.95) contrast(1.05);
        }

        .hero-badge {
            position: absolute;
            top: 30px;
            right: 30px;
            background: white;
            padding: 12px 24px;
            border-radius: 50px;
            box-shadow: var(--shadow-md);
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        /* Features Section */
        .features {
            padding: 100px 5%;
            background: white;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .section-header {
            text-align: center;
            margin-bottom: 80px;
        }

        .section-subtitle {
            font-size: 14px;
            color: var(--text-secondary);
            font-weight: 400;
            margin-bottom: 12px;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .section-title {
            font-size: 42px;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 16px;
        }

        .section-description {
            font-size: 18px;
            color: var(--text-secondary);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.8;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
            gap: 32px;
        }

        .feature-card {
            background: var(--bg-primary);
            padding: 48px 32px;
            border-radius: 20px;
            text-align: center;
            transition: all 0.4s ease;
            border: 1px solid var(--border);
            box-shadow: var(--shadow-sm); /* เพิ่ม box-shadow สำหรับ Feature Card */
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-md);
            border-color: rgba(0, 0, 0, 0.2); /* เพิ่ม border-color สำหรับ hover */
        }

        .feature-icon {
            font-size: 56px;
            margin-bottom: 24px;
            display: block;
        }

        .feature-title {
            font-size: 22px;
            font-weight: 500;
            color: var(--text-primary);
            margin-bottom: 12px;
        }

        .feature-description {
            color: var(--text-secondary);
            line-height: 1.7;
            font-size: 15px;
        }
        
        /* Footer adjustments for better styling */
        .footer-logo {
            font-size: 28px;
            font-weight: 600;
            margin-bottom: 16px;
        }

        .footer-text {
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.8;
            margin-bottom: 24px;
        }

        .footer-section h4 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 20px;
        }

        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 12px;
            list-style: none;
            padding: 0;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: all 0.3s ease;
            font-size: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .footer-links a:hover {
            color: white;
            margin-left: 4px;
        }

        /* --- Quick Actions (แสดงข้อความเสมอ) --- */
        .quick-actions {
            position: fixed;
            bottom: 40px;
            right: 40px;
            z-index: 999;
        }

        .quick-action-btn {
            /* แสดงทั้งไอคอนและข้อความตลอดเวลา */
            height: 60px;
            width: auto; /* ปรับตามเนื้อหา */
            
            /* สีดำ */
            background: #1a1a1a;
            color: white;
            
            border-radius: 30px; /* รูปทรงแคปซูล */
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: flex-start;
            font-size: 24px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            text-decoration: none;
            transition: all 0.3s ease;
            padding: 0 24px 0 18px; /* padding ทั้งซ้ายและขวา */
            white-space: nowrap;
            gap: 10px;
        }

        .quick-action-btn:hover {
            transform: scale(1.05); /* ขยายเล็กน้อยเมื่อ hover */
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.5);
            background: #2c2c2c;
        }

        .quick-action-btn .btn-text {
            /* แสดงข้อความตลอดเวลา */
            font-size: 15px;
            font-weight: 500;
            opacity: 1; /* แสดงเสมอ */
            line-height: 1;
        }

        /* Footer */
        footer {
            background: var(--text-primary);
            color: white;
            padding: 80px 5% 40px;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 60px;
            margin-bottom: 60px;
        }

        .footer-bottom {
            padding-top: 40px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center;
            color: rgba(255, 255, 255, 0.5);
            font-size: 14px;
        }

        /* Animations */
        @keyframes fadeInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes fadeInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Responsive */
        @media (max-width: 1200px) {
             .footer-grid {
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            }
        }
        
        @media (max-width: 968px) {
            .hero-content {
                grid-template-columns: 1fr;
                gap: 60px;
            }

            .hero-image-container {
                height: 400px;
            }

            .footer-grid {
                grid-template-columns: 1fr 1fr;
                gap: 40px;
            }
        }

        @media (max-width: 768px) {
            .nav-menu {
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: white;
                flex-direction: column;
                gap: 0;
                padding: 20px;
                box-shadow: var(--shadow-md);
                display: none;
            }

            .nav-menu.active {
                display: flex;
            }

            .mobile-menu-btn {
                display: flex;
            }

            .user-actions {
                flex-direction: column;
                align-items: flex-start;
                width: 100%;
                gap: 12px;
            }

            .hero {
                padding: 100px 5% 60px;
            }

            .hero-title {
                font-size: 2.5rem;
            }

            .features-grid {
                grid-template-columns: 1fr;
            }

            .footer-grid {
                grid-template-columns: 1fr;
                gap: 40px;
            }

            .quick-actions {
                bottom: 20px;
                right: 20px;
            }

            .quick-action-btn {
                height: 50px;
                font-size: 20px;
                padding: 0 18px 0 14px;
            }
            
            .quick-action-btn .btn-text {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <nav>
        <div class="nav-container">
            <a href="#" class="logo">
                <span></span>
                <span>ShaBu</span>
            </a>
            
            <ul class="nav-menu">
                <li><a href="gotowelcomeCustomer" class="active">หน้าแรก</a></li>
                <li><a href="menurecomand">เมนู</a></li>
                <li><a href="listTable">โต๊ะ</a></li>
                <li><a href="gotoContact">ติดต่อเรา</a></li>
            </ul>
           
            <div class="user-actions">
                <c:if test="${not empty user}">
                    <div class="user-info">
                        <div class="user-icon">
                            <i class="fas fa-user"></i>
                        </div>
                        <span>${user.cusname}</span>
                    </div>
                    <a href="logoutCustomer" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>ออกจากระบบ</span>
                    </a>
                </c:if>
            </div>
   
            <button class="mobile-menu-btn">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </nav>
    
    <section class="hero">
        <div class="hero-content">
            <div class="hero-text">
                <div class="hero-subtitle">🍲 ชาบูญี่ปุ่นแท้ 100% - Premium Hot Pot Experience</div>
                <h1 class="hero-title">ยินดีต้อนรับสู่ ShaBu</h1>
                <p class="hero-description">
                    เสพความอร่อยแบบญี่ปุ่นแท้ ด้วยชาบูพรีเมียม วัตถุดิบสด ๆ คุณภาพเยี่ยม 
                    ในบรรยากาศอบอุ่นที่จะทำให้ทุกมื้อเป็นประสบการณ์พิเศษ ที่คุณจะจำได้นาน
                </p>
                
                <div class="hero-buttons">
                    <a href="viewmenu" class="btn btn-primary">
                        <span>ดูเมนู</span>
                        <i class="fas fa-arrow-right"></i>
                    </a>
                    <a href="reserve&listTable" class="btn btn-secondary">
                        <i class="fas fa-calendar"></i>
                        <span>จองโต๊ะ</span>
                    </a>
                </div>
            </div>

            <div class="hero-image">
                <div class="hero-image-container">
                    <img src="<c:url value='https://image.makewebeasy.net/makeweb/m_1920x0/Ommd4Syoj/DefaultData/%E0%B9%80%E0%B8%A1%E0%B8%99%E0%B8%B9_%E0%B8%99%E0%B9%89%E0%B8%B3%E0%B8%8B%E0%B8%B8%E0%B8%9B%E0%B8%8A%E0%B8%B2%E0%B8%9A%E0%B8%B9_%E0%B9%92%E0%B9%91%E0%B9%90%E0%B9%95%E0%B9%91%E0%B9%91_18.jpg?v=202012190947' />" alt="ShaBu Restaurant" />
                    <div class="hero-badge">
                        <span>⭐⭐⭐⭐⭐</span>
                        <span>Premium Quality</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="features">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title" style="font-size: 3rem;">ทำไมต้องเลือก ShaBu</h2>
                <p class="section-description">
                    เรามอบประสบการณ์การรับประทานอาหารที่สุดยอด พร้อมบริการที่ดีเยี่ยมและราคาที่ยุติธรรม
                </p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">🥩</div>
                    <h3 class="feature-title">วัตถุดิบสดใหม่</h3>
                    <p class="feature-description">
                        เลือกวัตถุดิบสดใหม่ทุกวัน จากผู้จัดส่งที่มีความเชี่ยวชาญ เพื่อให้ได้รสชาติที่ดีที่สุด
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">👨‍🍳</div>
                    <h3 class="feature-title">เชฟมืออาชีพ</h3>
                    <p class="feature-description">
                        ทีมเชฟที่มีประสบการณ์สูงจากญี่ปุ่น พร้อมให้คำแนะนำเรื่องการหุงและวิธีการรับประทาน
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">🏡</div>
                    <h3 class="feature-title">บรรยากาศอบอุ่น</h3>
                    <p class="feature-description">
                        ห้องพักดำรมที่ออกแบบมาเพื่อให้นั่งสบาย อบอุ่น และสวยงาม เหมาะสำหรับทุกโอกาส
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">💰</div>
                    <h3 class="feature-title">ราคาพิเศษ</h3>
                    <p class="feature-description">
                        บุฟเฟต์อร่อย ราคาสมเหตุสมผล พร้อมโปรโมชั่นพิเศษและสิทธิสำหรับสมาชิกประจำ
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">⏰</div>
                    <h3 class="feature-title">ไม่มีเวลาจำกัด</h3>
                    <p class="feature-description">
                        บุฟเฟต์นั่งเท่านั้นที่ไม่มีเวลาจำกัด เพลิดเพลินกับการรับประทานอย่างสบายใจ
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">🎉</div>
                    <h3 class="feature-title">ส่วนลดพิเศษ</h3>
                    <p class="feature-description">
                        ส่วนลดสำหรับการจองกลุ่ม การเฉลิมฉลองวันเกิด และโปรแกรมเพื่อน
                    </p>
                </div>
            </div>
        </div>
    </section>

    <c:if test="${not empty user}">
        <div class="quick-actions">
            <a href="myReservess" class="quick-action-btn" title="ดูการจองของฉัน">
                <i class="fas fa-list"></i>
                <span class="btn-text">รายการจองของฉัน</span>
            </a>
        </div>
    </c:if>

    <footer style="background: linear-gradient(135deg, var(--text-primary) 0%, var(--accent) 100%); margin-top: 100px;">
        <div class="footer-content">
            <div class="footer-grid">
                <div class="footer-section">
                    <h3 class="footer-logo">ShaBu Restaurant</h3>
                    <p class="footer-text">
                        ชาบูญี่ปุ่นแท้ที่ดีที่สุด ด้วยบรรยากาศและบริการที่ไม่มีใครเทียบ
                    </p>
                    <div style="display: flex; gap: 12px;">
                        <a href="#" style="width: 40px; height: 40px; background: rgba(255, 255, 255, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; transition: all 0.3s;"><i class="fab fa-facebook"></i></a>
                        <a href="#" style="width: 40px; height: 40px; background: rgba(255, 255, 255, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; transition: all 0.3s;"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="width: 40px; height: 40px; background: rgba(255, 255, 255, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; transition: all 0.3s;"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>

                <div class="footer-section">
                    <h4 class="footer-section-title" style="color: white;">ลิงค์ด่วน</h4>
                    <ul class="footer-links">
                        <li><a href="menurecomand"><i class="fas fa-clipboard-list"></i> เมนูอาหาร</a></li>
                        <li><a href="listTable"><i class="fas fa-calendar-alt"></i> จองโต๊ะ</a></li>
                        <li><a href="gotoContact"><i class="fas fa-phone-alt"></i> ติดต่อเรา</a></li>
                        <li><a href="myReservess"><i class="fas fa-ticket-alt"></i> การจองของฉัน</a></li>
                    </ul>
                </div>

                <div class="footer-section">
                    <h4 class="footer-section-title" style="color: white;">ติดต่อเรา</h4>
                    <p class="footer-text" style="margin-bottom: 12px;">
                        <i class="fas fa-map-marker-alt" style="margin-right: 8px;"></i>
                        123 ถนนสุขุมวิท กรุงเทพฯ
                    </p>
                    <p class="footer-text" style="margin-bottom: 12px;">
                        <i class="fas fa-phone" style="margin-right: 8px;"></i>
                        02-123-4567
                    </p>
                    <p class="footer-text" style="margin-bottom: 12px;">
                        <i class="fas fa-envelope" style="margin-right: 8px;"></i>
                        contact@shabu.com
                    </p>
                    <p class="footer-text">
                        <i class="fas fa-clock" style="margin-right: 8px;"></i>
                        เปิด: 11:00 - 22:00 น.
                    </p>
                </div>

                <div class="footer-section">
                    <h4 class="footer-section-title" style="color: white;">รับข่าวสาร</h4>
                    <p class="footer-text">
                        สมัครรับโปรโมชั่นและข่าวสารพิเศษจาก ShaBu
                    </p>
                    <div style="display: flex; gap: 8px;">
                        <input type="email" placeholder="อีเมลของคุณ" style="flex: 1; padding: 12px; border: none; border-radius: 8px; background: rgba(255, 255, 255, 0.1); color: white; border: 1px solid rgba(255, 255, 255, 0.2);" />
                        <button class="btn btn-primary" style="padding: 12px 20px; border-radius: 8px; font-weight: 500;">ส่ง</button>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2024 ShaBu Restaurant. All rights reserved. | <a href="#" style="color: rgba(255, 255, 255, 0.5); text-decoration: none; margin-left: 10px;">Privacy Policy</a> | <a href="#" style="color: rgba(255, 255, 255, 0.5); text-decoration: none; margin-left: 10px;">Terms of Service</a></p>
            </div>
        </div>
    </footer>

    <script>
        // Mobile menu toggle
        const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
        const navMenu = document.querySelector('.nav-menu');

        mobileMenuBtn?.addEventListener('click', () => {
            navMenu.classList.toggle('active');
        });

        // Hide navigation on scroll down, show on scroll up
        let lastScrollTop = 0;
        const nav = document.querySelector('nav');

        window.addEventListener('scroll', () => {
            const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
            
            if (scrollTop > lastScrollTop && scrollTop > 100) {
                nav.style.transform = 'translateY(-100%)';
            } else {
                nav.style.transform = 'translateY(0)';
            }
            
            lastScrollTop = scrollTop;
        });
    </script>
</body>
</html>