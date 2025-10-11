<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ติดต่อเรา | Contact Us</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --bg-primary: #f8f9fa;
            --bg-card: #ffffff;
            --text-primary: #1a1a1a;
            --text-secondary: #6c757d;
            --border: rgba(0, 0, 0, 0.08);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 16px 48px rgba(0, 0, 0, 0.12);
        }

        body {
            font-family: 'Kanit', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
            min-height: 100vh;
        }

        /* Animated Background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 30%, rgba(99, 102, 241, 0.05) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(139, 92, 246, 0.04) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
        }

        /* Header */
        .header-bar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border);
            position: sticky;
            top: 0;
            z-index: 1000;
            padding: 24px 0;
        }

        .header-content {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background: rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
            border-radius: 12px;
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 400;
            font-size: 0.95rem;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .back-link:hover {
            background: rgba(0, 0, 0, 0.08);
            border-color: rgba(0, 0, 0, 0.15);
            transform: translateX(-4px);
        }

        h1 {
            font-size: 2rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            color: var(--text-primary);
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 64px 32px;
            position: relative;
            z-index: 1;
        }

        .contact-wrapper {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            margin-top: 40px;
        }

        /* Contact Info Card */
        .contact-info {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 48px;
            box-shadow: var(--shadow-md);
        }

        .section-title {
            font-size: 1.75rem;
            font-weight: 500;
            margin-bottom: 32px;
            color: var(--text-primary);
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            gap: 20px;
            margin-bottom: 32px;
            padding: 20px;
            background: rgba(99, 102, 241, 0.03);
            border-radius: 16px;
            transition: all 0.3s ease;
        }

        .info-item:hover {
            background: rgba(99, 102, 241, 0.06);
            transform: translateX(8px);
        }

        .info-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.25rem;
            flex-shrink: 0;
        }

        .info-content h3 {
            font-size: 1.1rem;
            font-weight: 500;
            margin-bottom: 8px;
            color: var(--text-primary);
        }

        .info-content p {
            color: var(--text-secondary);
            font-size: 0.95rem;
            line-height: 1.6;
        }

        /* Social Media Card */
        .social-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 48px;
            box-shadow: var(--shadow-md);
            display: flex;
            flex-direction: column;
        }

        .social-grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 20px;
            margin-top: 32px;
        }

        .social-link {
            display: flex;
            align-items: center;
            gap: 20px;
            padding: 24px;
            background: var(--bg-primary);
            border: 2px solid var(--border);
            border-radius: 16px;
            text-decoration: none;
            color: var(--text-primary);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .social-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            transition: left 0.4s ease;
        }

        .social-link:hover::before {
            left: 0;
        }

        .social-link.facebook::before {
            background: linear-gradient(135deg, #1877f2 0%, #4267B2 100%);
        }

        .social-link.line::before {
            background: linear-gradient(135deg, #00B900 0%, #00C300 100%);
        }

        .social-link.discord::before {
            background: linear-gradient(135deg, #5865F2 0%, #7289DA 100%);
        }

        .social-link:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
            border-color: transparent;
            color: white;
        }

        .social-icon {
            width: 60px;
            height: 60px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.75rem;
            flex-shrink: 0;
            position: relative;
            z-index: 1;
            transition: all 0.3s ease;
        }

        .social-link.facebook .social-icon {
            background: linear-gradient(135deg, #1877f2 0%, #4267B2 100%);
            color: white;
        }

        .social-link.line .social-icon {
            background: linear-gradient(135deg, #00B900 0%, #00C300 100%);
            color: white;
        }

        .social-link.discord .social-icon {
            background: linear-gradient(135deg, #5865F2 0%, #7289DA 100%);
            color: white;
        }

        .social-link:hover .social-icon {
            transform: scale(1.1) rotate(5deg);
        }

        .social-content {
            flex: 1;
            position: relative;
            z-index: 1;
        }

        .social-content h3 {
            font-size: 1.3rem;
            font-weight: 500;
            margin-bottom: 6px;
            transition: color 0.3s ease;
        }

        .social-content p {
            font-size: 0.9rem;
            color: var(--text-secondary);
            transition: color 0.3s ease;
        }

        .social-link:hover .social-content p {
            color: rgba(255, 255, 255, 0.9);
        }

        .arrow {
            font-size: 1.5rem;
            color: var(--text-secondary);
            transition: all 0.3s ease;
            position: relative;
            z-index: 1;
        }

        .social-link:hover .arrow {
            transform: translateX(8px);
            color: white;
        }

        /* Map Section */
        .map-section {
            grid-column: 1 / -1;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 48px;
            box-shadow: var(--shadow-md);
            margin-top: 40px;
        }

        .map-container {
            width: 100%;
            height: 400px;
            border-radius: 16px;
            overflow: hidden;
            margin-top: 24px;
            background: var(--bg-primary);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-secondary);
        }

        /* Responsive */
        @media (max-width: 968px) {
            .contact-wrapper {
                grid-template-columns: 1fr;
                gap: 32px;
            }

            .contact-info,
            .social-card {
                padding: 32px;
            }

            .map-section {
                padding: 32px;
            }
        }

        @media (max-width: 768px) {
            .header-content {
                flex-direction: column;
                gap: 20px;
                align-items: flex-start;
            }

            h1 {
                font-size: 1.5rem;
            }

            .container {
                padding: 40px 20px;
            }

            .contact-info,
            .social-card,
            .map-section {
                padding: 24px;
            }

            .section-title {
                font-size: 1.5rem;
            }

            .info-item {
                padding: 16px;
            }

            .social-link {
                padding: 20px;
            }

            .social-icon {
                width: 50px;
                height: 50px;
                font-size: 1.5rem;
            }

            .map-container {
                height: 300px;
            }
        }

        @media (max-width: 480px) {
            .back-link {
                padding: 10px 18px;
                font-size: 0.9rem;
            }

            h1 {
                font-size: 1.3rem;
            }

            .social-content h3 {
                font-size: 1.1rem;
            }
        }
    </style>
</head>
<body>
    <div class="header-bar">
        <div class="header-content">
            <a href="Homecustomer" class="back-link">
                <i class="fas fa-arrow-left"></i>
                <span>กลับหน้าหลัก</span>
            </a>
            <h1>ติดต่อเรา</h1>
            <span style="width: 140px;"></span>
        </div>
    </div>

    <div class="container">
        <div class="contact-wrapper">
            <!-- Contact Information -->
            <div class="contact-info">
                <h2 class="section-title">ข้อมูลการติดต่อ</h2>
                
                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-map-marker-alt"></i>
                    </div>
                    <div class="info-content">
                        <h3>ที่อยู่</h3>
                        <p>123 ถนนตัวอย่าง แขวงตัวอย่าง<br>เขตตัวอย่าง กรุงเทพมหานคร 10110</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-phone"></i>
                    </div>
                    <div class="info-content">
                        <h3>เบอร์โทรศัพท์</h3>
                        <p>02-123-4567<br>081-234-5678</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="info-content">
                        <h3>อีเมล</h3>
                        <p>info@restaurant.com<br>contact@restaurant.com</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="info-content">
                        <h3>เวลาทำการ</h3>
                        <p>จันทร์ - ศุกร์: 10:00 - 22:00<br>เสาร์ - อาทิตย์: 09:00 - 23:00</p>
                    </div>
                </div>
            </div>

            <!-- Social Media Links -->
            <div class="social-card">
                <h2 class="section-title">ติดตามเราได้ที่</h2>
                
                <div class="social-grid">
                    <a href="https://www.facebook.com/" target="_blank" class="social-link facebook">
                        <div class="social-icon">
                            <i class="fab fa-facebook-f"></i>
                        </div>
                        <div class="social-content">
                            <h3>Facebook</h3>
                            <p>ติดตามข่าวสารและโปรโมชั่น</p>
                        </div>
                        <span class="arrow">→</span>
                    </a>

                    <a href="https://line.me/ti/p/" target="_blank" class="social-link line">
                        <div class="social-icon">
                            <i class="fab fa-line"></i>
                        </div>
                        <div class="social-content">
                            <h3>LINE Official</h3>
                            <p>สอบถามและจองโต๊ะผ่าน LINE</p>
                        </div>
                        <span class="arrow">→</span>
                    </a>

                    <a href="https://discord.gg/" target="_blank" class="social-link discord">
                        <div class="social-icon">
                            <i class="fab fa-discord"></i>
                        </div>
                        <div class="social-content">
                            <h3>Discord</h3>
                            <p>เข้าร่วมชุมชนของเรา</p>
                        </div>
                        <span class="arrow">→</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- Map Section -->
        <div class="map-section">
            <h2 class="section-title">แผนที่และการเดินทาง</h2>
            <div class="map-container">
                <iframe 
                    src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3875.5908419185897!2d100.5237!3d13.7465!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x0!2zMTPCsDQ0JzQ3LjQiTiAxMDDCsDMxJzI1LjMiRQ!5e0!3m2!1sth!2sth!4v1234567890"
                    width="100%" 
                    height="100%" 
                    style="border:0; border-radius: 16px;" 
                    allowfullscreen="" 
                    loading="lazy" 
                    referrerpolicy="no-referrer-when-downgrade">
                </iframe>
            </div>
        </div>
    </div>
</body>
</html>