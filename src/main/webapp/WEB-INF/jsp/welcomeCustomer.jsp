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
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-md);
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

        /* Quick Actions */
        .quick-actions {
            position: fixed;
            bottom: 40px;
            right: 40px;
            z-index: 999;
        }

        .quick-action-btn {
            width: 60px;
            height: 60px;
            background: var(--text-primary);
            color: white;
            border-radius: 50%;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            box-shadow: var(--shadow-md);
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .quick-action-btn:hover {
            transform: scale(1.1);
            box-shadow: var(--shadow-lg);
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

        .footer-section h3 {
            font-size: 16px;
            font-weight: 500;
            margin-bottom: 20px;
        }

        .footer-links {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: color 0.3s ease;
            font-size: 15px;
        }

        .footer-links a:hover {
            color: white;
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
                width: 50px;
                height: 50px;
                font-size: 20px;
            }
        }
    </style>
</head>
<body>
    <nav>
        <div class="nav-container">
            <a href="#" class="logo">
                <span>🍲</span>
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
                <div class="hero-subtitle">Authentic Japanese Experience</div>
                <h1 class="hero-title">ShaBu Buffet</h1>
                <p class="hero-description">
                    เสพความอร่อยแบบญี่ปุ่นแท้ ด้วยชาบูพรีเมียม วัตถุดิบสด ๆ คุณภาพเยี่ยม 
                    ในบรรยากาศอบอุ่นที่จะทำให้ทุกมื้อเป็นประสบการณ์พิเศษ
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
                        <span>⭐</span>
                        <span>Premium Quality</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    

    <c:if test="${not empty user}">
        <div class="quick-actions">
            <a href="myReservess" class="quick-action-btn" title="ดูการจองของฉัน">
                <i class="fas fa-list"></i>
            </a>
        </div>
    </c:if>

    <footer>
        
            

            <div class="footer-bottom">
                <p>&copy; 2024 ShaBu Restaurant. All rights reserved.</p>
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