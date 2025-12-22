<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        

        .logo {
            font-size: 28px;
            font-weight: 600;
            color: var(--text-primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        

        /* Auth Buttons */
        .auth-buttons {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .auth-buttons a {
            padding: 10px 24px;
            background: var(--text-primary);
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .auth-buttons a:last-child {
            background: white;
            color: var(--text-primary);
            border: 1px solid var(--border);
        }

        .auth-buttons a:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
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
        }

        .hero-badge {
            position: absolute;
            bottom: 20px;
            right: 20px;
            background: white;
            padding: 12px 20px;
            border-radius: 50px;
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: var(--shadow-lg);
            font-weight: 600;
        }

        /* Features Section */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 40px;
        }

        .feature-card {
            padding: 40px;
            background: white;
            border: 1px solid var(--border);
            border-radius: 16px;
            transition: all 0.3s ease;
            text-align: center;
            box-shadow: var(--shadow-sm);
        }

        .feature-card:hover {
            border-color: rgba(0, 0, 0, 0.2);
            box-shadow: var(--shadow-md);
            transform: translateY(-4px);
        }

        .feature-card h3 {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 12px;
            color: var(--text-primary);
        }

        .feature-description {
            color: var(--text-secondary);
            line-height: 1.7;
            font-size: 15px;
        }

        /* Footer */
        footer {
            background: linear-gradient(135deg, #1a1a1a 0%, #2c2c2c 100%);
            color: white;
            padding: 80px 5% 40px;
            margin-top: 100px;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 60px;
            margin-bottom: 60px;
        }

        .footer-section h4 {
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 20px;
            color: white;
        }

        .footer-section p {
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 12px;
        }

        .footer-links {
            list-style: none;
            padding: 0;
        }

        .footer-links li {
            margin-bottom: 12px;
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
            

            

            .mobile-menu-btn {
                display: flex;
            }

            .auth-buttons {
                flex-direction: column;
                width: 100%;
                gap: 8px;
            }

            .auth-buttons a {
                width: 100%;
                text-align: center;
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
            .nav-menu {
            display: flex;
            list-style: none;
            gap: 48px;
            align-items: center;
            white-space: nowrap;
            font-size: 1.35rem;
        }
.nav-menu a {
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 500;
            font-size: 1.15em;
            padding: 10px 0;
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
.nav-menu {
                gap: 18px;
                font-size: 14px;
            }
.nav-menu a {
                font-size: 14px;
            }
.nav-container {
            display: flex;
            align-items: center;
            justify-content: center;
            max-width: 1400px;
            margin: 0 auto;
            flex-wrap: nowrap;
            gap: 0;
        }
        }
    </style>
</head>
<body>
      <nav>
        <div class="nav-container" style="justify-content: center;">
            <%@ include file="/WEB-INF/jsp/include/navbar.jsp" %>
        </div>
    </nav>
    
    <section class="hero">
        <div class="hero-content">
            <div class="hero-text">
                <div class="hero-subtitle">🍲 ชาบูญี่ปุ่นแท้ 100% - Premium Hot Pot Experience</div>
                <h1 class="hero-title">ยินดีต้อนรับสู่ ShaBu</h1>
                <p class="hero-description">
                    เสพความอร่อยแบบญี่ปุ่นแท้ ด้วยชาบูพรีเมียม วัตถุดิบสด ๆ คุณภาพเยี่ยม 
                    ในบรรยากาศอบอุ่นที่จะทำให้ทุกมื้อเป็นประสบการณ์พิเศษ
                </p>
                
                <div class="hero-buttons">
                    <a href="menurecomand" class="btn btn-primary">
                        <i class="fas fa-utensils"></i>
                        <span>สำรวจเมนู</span>
                    </a>
                    <a href="listTable" class="btn btn-secondary">
                        <i class="fas fa-calendar-alt"></i>
                        <span>จองโต๊ะ</span>
                    </a>
                </div>
            </div>

            <div class="hero-image">
                <div class="hero-image-container">
                    <img src="<c:url value='/image/sss.jpg' />" alt="ShaBu Restaurant Premium" />
                    <div class="hero-badge">
                        <span>⭐⭐⭐⭐⭐</span>
                        <span>ชาบูพรีเมียม</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section style="padding: 100px 5%; background: white;">
        <div style="max-width: 1400px; margin: 0 auto;">
            <div style="text-align: center; margin-bottom: 80px;">
                <h2 style="font-size: 3rem; font-weight: 600; margin-bottom: 16px; color: #1a1a1a;">ทำไมต้องเลือก ShaBu</h2>
                <p style="font-size: 18px; color: #6c757d; max-width: 600px; margin: 0 auto;">
                    เรามอบประสบการณ์การรับประทานอาหารที่สุดยอด พร้อมบริการที่ดีเยี่ยมและราคาที่ยุติธรรม
                </p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div style="font-size: 48px; margin-bottom: 24px;">🥩</div>
                    <h3>วัตถุดิบสดใหม่</h3>
                    <p class="feature-description">
                        เลือกวัตถุดิบสดใหม่ทุกวัน จากผู้จัดส่งที่มีความเชี่ยวชาญ เพื่อให้ได้รสชาติที่ดีที่สุด
                    </p>
                </div>

                <div class="feature-card">
                    <div style="font-size: 48px; margin-bottom: 24px;">👨‍🍳</div>
                    <h3>เชฟมืออาชีพ</h3>
                    <p class="feature-description">
                        ทีมเชฟที่มีประสบการณ์สูงจากญี่ปุ่น พร้อมให้คำแนะนำเรื่องการหุงและวิธีการรับประทาน
                    </p>
                </div>

                <div class="feature-card">
                    <div style="font-size: 48px; margin-bottom: 24px;">🏡</div>
                    <h3>บรรยากาศอบอุ่น</h3>
                    <p class="feature-description">
                        ห้องพักดำรมที่ออกแบบมาเพื่อให้นั่งสบาย อบอุ่น และสวยงาม เหมาะสำหรับทุกโอกาส
                    </p>
                </div>

                <div class="feature-card">
                    <div style="font-size: 48px; margin-bottom: 24px;">💰</div>
                    <h3>ราคาพิเศษ</h3>
                    <p class="feature-description">
                        บุฟเฟต์อร่อย ราคาสมเหตุสมผล พร้อมโปรโมชั่นพิเศษและสิทธิสำหรับสมาชิกประจำ
                    </p>
                </div>

                <div class="feature-card">
                    <div style="font-size: 48px; margin-bottom: 24px;">⏰</div>
                    <h3>ไม่มีเวลาจำกัด</h3>
                    <p class="feature-description">
                        บุฟเฟต์นั่งเท่านั้นที่ไม่มีเวลาจำกัด เพลิดเพลินกับการรับประทานอย่างสบายใจ
                    </p>
                </div>

                <div class="feature-card">
                    <div style="font-size: 48px; margin-bottom: 24px;">🎉</div>
                    <h3>ส่วนลดพิเศษ</h3>
                    <p class="feature-description">
                        ส่วนลดสำหรับการจองกลุ่ม การเฉลิมฉลองวันเกิด และโปรแกรมเพื่อน
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <div class="footer-grid">
                <!-- Company Info -->
                <div class="footer-section">
                    <h3 style="font-size: 20px; font-weight: 600; margin-bottom: 20px; color: white;">ShaBu Restaurant</h3>
                    <p>
                        ชาบูญี่ปุ่นแท้ที่ดีที่สุด ด้วยบรรยากาศและบริการที่ไม่มีใครเทียบ
                    </p>
                    <div style="display: flex; gap: 12px; margin-top: 20px;">
                        <a href="#" style="width: 40px; height: 40px; background: rgba(255, 255, 255, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; transition: all 0.3s;"><i class="fab fa-facebook"></i></a>
                        <a href="#" style="width: 40px; height: 40px; background: rgba(255, 255, 255, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; transition: all 0.3s;"><i class="fab fa-twitter"></i></a>
                        <a href="#" style="width: 40px; height: 40px; background: rgba(255, 255, 255, 0.1); border-radius: 50%; display: flex; align-items: center; justify-content: center; color: white; transition: all 0.3s;"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>

                <!-- Quick Links -->
                <div class="footer-section">
                    <h4>ลิงค์ด่วน</h4>
                    <ul class="footer-links">
                        <li><a href="menurecomand">📋 เมนูอาหาร</a></li>
                        <li><a href="reservetable">📅 จองโต๊ะ</a></li>
                        <li><a href="conTact">📞 ติดต่อเรา</a></li>
                        <li><a href="gotologin">🔐 เข้าสู่ระบบ</a></li>
                    </ul>
                </div>

                <!-- Contact Info -->
                <div class="footer-section">
                    <h4>ติดต่อเรา</h4>
                    <p>
                        <i class="fas fa-map-marker-alt" style="margin-right: 8px;"></i>
                        123 ถนนสุขุมวิท กรุงเทพฯ
                    </p>
                    <p>
                        <i class="fas fa-phone" style="margin-right: 8px;"></i>
                        02-123-4567
                    </p>
                    <p>
                        <i class="fas fa-envelope" style="margin-right: 8px;"></i>
                        contact@shabu.com
                    </p>
                    <p>
                        <i class="fas fa-clock" style="margin-right: 8px;"></i>
                        เปิด: 11:00 - 22:00 น.
                    </p>
                </div>

                <!-- Newsletter -->
                <div class="footer-section">
                    <h4>รับข่าวสาร</h4>
                    <p style="margin-bottom: 16px;">
                        สมัครรับโปรโมชั่นและข่าวสารพิเศษจาก ShaBu
                    </p>
                    <div style="display: flex; gap: 8px;">
                        <input type="email" placeholder="อีเมลของคุณ" style="flex: 1; padding: 12px; border: none; border-radius: 8px; background: rgba(255, 255, 255, 0.1); color: white; border: 1px solid rgba(255, 255, 255, 0.2);" />
                        <button style="padding: 12px 20px; background: #1a1a1a; color: white; border: none; border-radius: 8px; cursor: pointer; transition: all 0.3s;">ส่ง</button>
                    </div>
                </div>
            </div>

            <div class="footer-bottom">
                <p>&copy; 2024 ShaBu Restaurant. All rights reserved. | <a href="#" style="color: rgba(255, 255, 255, 0.5); text-decoration: none;">Privacy Policy</a> | <a href="#" style="color: rgba(255, 255, 255, 0.5); text-decoration: none;">Terms of Service</a></p>
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