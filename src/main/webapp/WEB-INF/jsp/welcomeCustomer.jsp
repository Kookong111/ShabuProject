<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ShaBu Restaurant - Authentic Japanese Hot Pot</title>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+Thai:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-red: #d32f2f;
            --warm-red: #e57373;
            --soft-cream: #faf8f5;
            --warm-white: #ffffff;
            --charcoal: #2c2c2c;
            --soft-gray: #757575;
            --light-gray: #f5f5f5;
            --shadow-soft: 0 4px 20px rgba(0, 0, 0, 0.08);
            --shadow-medium: 0 8px 30px rgba(0, 0, 0, 0.12);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            --gold: #ffd700;
            --green: #28a745;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Noto Sans Thai', 'Inter', sans-serif;
            line-height: 1.6;
            color: var(--charcoal);
            background-color: var(--soft-cream);
            scroll-behavior: smooth;
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
            border-bottom: 1px solid rgba(211, 47, 47, 0.1);
            z-index: 1000;
            transition: var(--transition);
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            max-width: 1200px;
            margin: 0 auto;
        }

        .logo {
            font-size: 32px;
            font-weight: 700;
            color: var(--primary-red);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .logo::before {
            content: "🍲";
            font-size: 28px;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 40px;
            align-items: center;
        }

        .nav-menu a {
            color: var(--charcoal);
            text-decoration: none;
            font-weight: 500;
            padding: 8px 0;
            position: relative;
            transition: var(--transition);
        }

        .nav-menu a::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--primary-red);
            transition: var(--transition);
        }

        .nav-menu a:hover::after,
        .nav-menu a.active::after {
            width: 100%;
        }

        .nav-menu a:hover {
            color: var(--primary-red);
        }

        /* User Info in Navigation */
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 8px 16px;
            background: rgba(211, 47, 47, 0.1);
            border-radius: 20px;
            font-size: 14px;
            color: var(--primary-red);
            font-weight: 500;
        }

        .user-info .user-icon {
            font-size: 18px;
        }

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
            width: 25px;
            height: 3px;
            background: var(--charcoal);
            border-radius: 2px;
            transition: var(--transition);
        }

        /* Hero Section */
        .hero {
            height: 100vh;
            background: linear-gradient(135deg, rgba(211, 47, 47, 0.8), rgba(229, 115, 115, 0.6)),
                        url('<c:url value="/assets/images/shabu.jpg" />');
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at center, transparent 0%, rgba(0, 0, 0, 0.3) 100%);
        }

        .hero-content {
            position: relative;
            z-index: 2;
            max-width: 800px;
            padding: 0 20px;
            animation: fadeInUp 1s ease-out;
        }

        .hero-subtitle {
            font-size: 20px;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 300;
            margin-bottom: 16px;
            letter-spacing: 2px;
        }

        .hero-title {
            font-size: clamp(3rem, 8vw, 6rem);
            font-weight: 700;
            color: white;
            margin-bottom: 24px;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            line-height: 1.1;
        }

        .hero-description {
            font-size: 18px;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 40px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }

        /* Buttons */
        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 16px 32px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            border-radius: 50px;
            border: none;
            cursor: pointer;
            transition: var(--transition);
            position: relative;
            overflow: hidden;
        }

        .btn-primary {
            background: var(--primary-red);
            color: white;
            box-shadow: var(--shadow-medium);
        }

        .btn-primary:hover {
            background: #b71c1c;
            transform: translateY(-2px);
            box-shadow: 0 12px 40px rgba(211, 47, 47, 0.3);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
        }

        .btn-gold {
            background: linear-gradient(135deg, var(--gold), #ffb300);
            color: var(--charcoal);
            box-shadow: var(--shadow-medium);
        }

        .btn-gold:hover {
            background: linear-gradient(135deg, #ffb300, var(--gold));
            transform: translateY(-2px);
            box-shadow: 0 12px 40px rgba(255, 215, 0, 0.4);
        }

        .hero-buttons {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: wrap;
        }

        /* Quick Actions Section */
        .quick-actions {
            position: fixed;
            bottom: 30px;
            right: 30px;
            z-index: 999;
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .quick-action-btn {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            box-shadow: var(--shadow-medium);
            transition: var(--transition);
            text-decoration: none;
            position: relative;
        }

        .quick-action-btn:hover {
            transform: scale(1.1);
            box-shadow: 0 12px 40px rgba(0, 0, 0, 0.2);
        }

        .reservation-btn {
            background: linear-gradient(135deg, var(--green), #1e7e34);
            color: white;
        }

        .reservation-btn:hover {
            box-shadow: 0 12px 40px rgba(40, 167, 69, 0.4);
        }

        /* Tooltip for quick action buttons */
        .quick-action-btn::before {
            content: attr(data-tooltip);
            position: absolute;
            right: 70px;
            background: var(--charcoal);
            color: white;
            padding: 8px 12px;
            border-radius: 8px;
            font-size: 14px;
            white-space: nowrap;
            opacity: 0;
            visibility: hidden;
            transition: var(--transition);
            font-weight: 500;
        }

        .quick-action-btn:hover::before {
            opacity: 1;
            visibility: visible;
        }

        /* Features Section */
        .features {
            padding: 100px 5% 80px;
            background: var(--warm-white);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .section-header {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-title {
            font-size: 36px;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 16px;
        }

        .section-subtitle {
            font-size: 18px;
            color: var(--soft-gray);
            max-width: 600px;
            margin: 0 auto;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
            margin-top: 60px;
        }

        .feature-card {
            background: white;
            padding: 40px 30px;
            border-radius: 20px;
            box-shadow: var(--shadow-soft);
            text-align: center;
            transition: var(--transition);
            border: 1px solid rgba(211, 47, 47, 0.1);
        }

        .feature-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-medium);
        }

        .feature-icon {
            font-size: 48px;
            margin-bottom: 20px;
            display: block;
        }

        .feature-title {
            font-size: 24px;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 16px;
        }

        .feature-description {
            color: var(--soft-gray);
            line-height: 1.7;
        }

        /* Menu Preview */
        .menu-preview {
            padding: 100px 5%;
            background: linear-gradient(135deg, var(--soft-cream), rgba(211, 47, 47, 0.05));
        }

        .menu-items {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 60px;
        }

        .menu-item {
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: var(--shadow-soft);
            transition: var(--transition);
        }

        .menu-item:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-medium);
        }

        .menu-item-image {
            height: 200px;
            background: linear-gradient(45deg, var(--warm-red), var(--primary-red));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 48px;
            color: white;
        }

        .menu-item-content {
            padding: 24px;
        }

        .menu-item-title {
            font-size: 20px;
            font-weight: 600;
            color: var(--charcoal);
            margin-bottom: 8px;
        }

        .menu-item-price {
            font-size: 18px;
            font-weight: 600;
            color: var(--primary-red);
            margin-bottom: 12px;
        }

        .menu-item-description {
            color: var(--soft-gray);
            font-size: 14px;
            line-height: 1.6;
        }

        /* Footer */
        footer {
            background: var(--charcoal);
            color: white;
            padding: 60px 5% 30px;
            text-align: center;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
        }

        .footer-logo {
            font-size: 28px;
            font-weight: 700;
            color: var(--warm-red);
            margin-bottom: 20px;
        }

        .footer-text {
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 30px;
        }

        .footer-links {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .footer-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: var(--transition);
        }

        .footer-links a:hover {
            color: var(--warm-red);
        }

        .footer-copyright {
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.5);
            font-size: 14px;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .nav-menu {
                display: none;
            }

            .mobile-menu-btn {
                display: flex;
            }

            .hero-subtitle {
                font-size: 16px;
            }

            .hero-description {
                font-size: 16px;
            }

            .hero-buttons {
                flex-direction: column;
                align-items: center;
            }

            .features-grid {
                grid-template-columns: 1fr;
                gap: 30px;
            }

            .menu-items {
                grid-template-columns: 1fr;
            }

            .footer-links {
                flex-direction: column;
                gap: 15px;
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

            .quick-action-btn::before {
                right: 60px;
                font-size: 12px;
            }
        }

        /* Scroll animations */
        .fade-in {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.6s ease-out;
        }

        .fade-in.visible {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>
    <nav>
        <div class="nav-container">
            <a href="#" class="logo">ShaBu</a>
            <ul class="nav-menu">
                <li><a href="loginCustomer" class="active">Home</a></li>
                
                <li><a href="menurecomand">Menu</a></li>
                <li><a href="listTable">Table</a></li>
                <li><a href="<c:url value='/contact' />">Contact</a></li>
            </ul>
            
            <!-- แสดงข้อมูลผู้ใช้ถ้า login แล้ว -->
            <c:if test="${not empty user}">
                <div class="user-info">
                    <span class="user-icon">👤</span>
                    <span>สวัสดี, ${user.cusname}</span>
                </div>
            </c:if>
            
            <button class="mobile-menu-btn">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </nav>
    
    <section class="hero">
        <div class="hero-content">
            <div class="hero-subtitle">Authentic Japanese Experience</div>
            <h1 class="hero-title">ShaBu Buffet</h1>
            <p class="hero-description">
                เสพความอร่อยแบบญี่ปุ่นแท้ ด้วยชาบูพรีเมียม วัตถุดิบสด ๆ คุณภาพเยี่ยม 
                ในบรรยากาศอบอุ่นที่จะทำให้ทุกมื้ออาหารเป็นประสบการณ์พิเศษ
               
            </p>
            
            <div class="hero-buttons">
                <a href="<c:url value='viewmenu' />" class="btn btn-primary">
                    ดูเมนู 🍜
                </a>
                <a href="reserve&listTable" class="btn btn-secondary">
                    จองโต๊ะ 📅
                </a>
                <!-- เพิ่มปุ่มดูการจองของฉัน -->
                <c:if test="${not empty user}">
                    <a href="<c:url value='myReservess' />" class="btn btn-gold">
                        ดูการจองของฉัน 📋
                    </a>
                </c:if>
            </div>
        </div>
    </section>

    <!-- Quick Action Buttons -->
   							
    <div class="quick-actions">
        <c:if test="${not empty user}">
            <a href="<c:url value='myReservess' />" 
               class="quick-action-btn reservation-btn" 
               data-tooltip="ดูการจองของฉัน">
                📋
            </a>
        </c:if>
    </div>

    <footer>
        <div class="footer-content">
            <div class="footer-logo">🍲 ShaBu Restaurant</div>
            <p class="footer-text">
                ประสบการณ์ชาบูแท้ ๆ ที่จะทำให้ทุกมื้ออาหารเป็นความทรงจำดี ๆ
            </p>
            <div class="footer-links">
                <a href="loginCustomer">Home</a>
                <a href="reserve&listTable">Reserve</a>
                <a href="menurecomand">Menu</a>
                <a href="listTable">Table</a>
                <a href="<c:url value='/contact' />">Contact</a>
            </div>
            <div class="footer-copyright">
                <p>&copy; 2024 ShaBu Restaurant. All rights reserved. | Made with ❤️ in Thailand</p>
            </div>
        </div>
    </footer>

    <script>
        // Smooth scrolling for navigation links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({
                        behavior: 'smooth',
                        block: 'start'
                    });
                }
            });
        });

        // Fade in animation on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, observerOptions);

        document.querySelectorAll('.fade-in').forEach(el => {
            observer.observe(el);
        });

        // Mobile menu toggle
        const mobileMenuBtn = document.querySelector('.mobile-menu-btn');
        const navMenu = document.querySelector('.nav-menu');

        mobileMenuBtn?.addEventListener('click', () => {
            navMenu.style.display = navMenu.style.display === 'flex' ? 'none' : 'flex';
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