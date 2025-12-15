<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>เมนูอาหารพรีเมียม | The Premium Menu</title>
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
            --bg-secondary: #ffffff;
            --bg-card: #ffffff;
            --text-primary: #1a1a1a;
            --text-secondary: #6c757d;
            --accent: #1a1a1a;
            --border: rgba(0, 0, 0, 0.08);
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.06);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 16px 48px rgba(0, 0, 0, 0.12);
        }

        body {
            font-family: 'Kanit', -apple-system, BlinkMacSystemFont, sans-serif;
            background: var(--bg-primary);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
        }

        /* Subtle animated background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 30%, rgba(99, 102, 241, 0.03) 0%, transparent 50%),
                radial-gradient(circle at 80% 70%, rgba(139, 92, 246, 0.02) 0%, transparent 50%);
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
            max-width: 1400px;
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

        .back-link i {
            font-size: 0.85rem;
        }

        h1 {
            font-size: 2rem;
            font-weight: 500;
            letter-spacing: 0.5px;
            color: var(--text-primary);
        }

        /* Container */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 64px 32px;
            position: relative;
            z-index: 1;
        }

        /* Menu Grid */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(340px, 1fr));
            gap: 32px;
        }

        /* Menu Card */
        .menu-item {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
        }

        .menu-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.03) 0%, transparent 100%);
            opacity: 0;
            transition: opacity 0.5s ease;
            pointer-events: none;
            z-index: 1;
        }

        .menu-item:hover {
            transform: translateY(-12px);
            box-shadow: var(--shadow-lg);
            border-color: rgba(99, 102, 241, 0.2);
        }

        .menu-item:hover::before {
            opacity: 1;
        }

        /* Image Container */
        .image-container {
            width: 100%;
            height: 280px;
            overflow: hidden;
            background: #ffffff;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 16px;
        }

        .menu-item img {
            max-width: 100%;
            max-height: 100%;
            width: auto;
            height: auto;
            object-fit: contain;
            object-position: center;
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            filter: brightness(0.95) contrast(1.05);
            display: block;
        }

        .menu-item:hover img {
            transform: scale(1.05);
            filter: brightness(1) contrast(1.1);
        }

        .no-image {
            width: 100%;
            height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 12px;
            color: var(--text-secondary);
        }

        .no-image i {
            font-size: 2.5rem;
            opacity: 0.3;
        }

        .no-image span {
            font-size: 0.9rem;
            opacity: 0.5;
        }

        /* Item Details */
        .item-details {
            padding: 28px;
            position: relative;
            z-index: 2;
        }

        .item-details h2 {
            font-size: 1.5rem;
            font-weight: 500;
            color: var(--text-primary);
            margin-bottom: 12px;
            letter-spacing: 0.3px;
        }

        .food-type {
            display: inline-block;
            padding: 6px 14px;
            background: rgba(99, 102, 241, 0.08);
            border: 1px solid rgba(99, 102, 241, 0.15);
            border-radius: 20px;
            font-size: 0.85rem;
            color: #6366f1;
            margin-bottom: 20px;
            font-weight: 400;
        }

        .price-container {
            display: flex;
            align-items: baseline;
            gap: 6px;
            padding-top: 20px;
            border-top: 1px solid var(--border);
        }

        .price {
            font-size: 1.75rem;
            font-weight: 600;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }

        .currency {
            font-size: 1rem;
            color: var(--text-secondary);
            font-weight: 300;
        }

        /* Empty State */
        .empty-message {
            text-align: center;
            padding: 80px 32px;
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 24px;
            max-width: 600px;
            margin: 60px auto;
        }

        .empty-message i {
            font-size: 3rem;
            color: var(--text-secondary);
            opacity: 0.3;
            margin-bottom: 20px;
        }

        .empty-message p {
            color: var(--text-secondary);
            font-size: 1.1rem;
            line-height: 1.8;
        }

        /* Responsive */
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

            .menu-grid {
                grid-template-columns: 1fr;
                gap: 24px;
            }

            .image-container {
                height: 240px;
            }

            .item-details {
                padding: 24px;
            }

            .item-details h2 {
                font-size: 1.3rem;
            }

            .price {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .header-bar {
                padding: 16px 0;
            }

            .header-content {
                padding: 0 20px;
            }

            .back-link {
                padding: 10px 18px;
                font-size: 0.9rem;
            }

            h1 {
                font-size: 1.3rem;
            }
        }

        /* Loading animation for images */
        @keyframes shimmer {
            0% {
                background-position: -1000px 0;
            }
            100% {
                background-position: 1000px 0;
            }
        }

        .menu-item img[src=""] {
            background: linear-gradient(
                90deg,
                #1a1a1a 0%,
                #2a2a2a 50%,
                #1a1a1a 100%
            );
            background-size: 1000px 100%;
            animation: shimmer 2s infinite;
        }
    </style>
</head>
<body>
    <div class="header-bar">
        <div class="header-content">
            <c:choose>
                <c:when test="${not empty user}">
                    <a href="gotohomecustomer" class="back-link">
                        <i class="fas fa-arrow-left"></i>
                        <span>กลับหน้าหลัก</span>
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="gotowelcomeCustomer" class="back-link">
                        <i class="fas fa-arrow-left"></i>
                        <span>กลับหน้าหลัก</span>
                    </a>
                </c:otherwise>
            </c:choose>
            <h1>THE SIGNATURE MENU</h1>
            <span style="width: 140px;"></span>
        </div>
    </div>

    <div class="container">
        <div class="menu-grid">
            <c:forEach items="${menuItems}" var="item">
                <div class="menu-item">
                    <div class="image-container">
                        <c:choose>
                            <c:when test="${not empty item.foodImage}">
                                <img src="${item.foodImage}" alt="${item.foodname}" loading="lazy">
                            </c:when>
                            <c:otherwise>
                                <div class="no-image">
                                    <i class="fas fa-utensils"></i>
                                    <span>No Image Available</span>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div class="item-details">
                        <h2>${item.foodname}</h2>
                        <div class="food-type">${item.foodtype.foodtypeName}</div>
                        <div class="price-container">
                            <span class="price">
                                <fmt:formatNumber value="${item.price}" pattern="#,##0.00" />
                            </span>
                            <span class="currency">บาท</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        
        <c:if test="${empty menuItems}">
            <div class="empty-message">
                <i class="fas fa-inbox"></i>
                <p>ขณะนี้ยังไม่มีรายการอาหารในเมนู<br>กรุณาตรวจสอบอีกครั้งในภายหลัง</p>
            </div>
        </c:if>
    </div>

    <script>
        // ซ่อนเมนูที่มีชื่อว่า "บุฟเฟต์"
        document.addEventListener('DOMContentLoaded', function() {
            const menuItems = document.querySelectorAll('.menu-item');
            
            menuItems.forEach(function(item) {
                const foodName = item.querySelector('.item-details h2');
                if (foodName && foodName.textContent.includes('บุฟเฟต์')) {
                    item.style.display = 'none';
                }
            });

            // ตรวจสอบว่ามีเมนูที่แสดงอยู่หรือไม่
            const visibleItems = document.querySelectorAll('.menu-item:not([style*="display: none"])');
            const emptyMessage = document.querySelector('.empty-message');
            
            if (visibleItems.length === 0 && !emptyMessage) {
                // ถ้าไม่มีเมนูเลย ให้แสดงข้อความ
                const container = document.querySelector('.container');
                const emptyDiv = document.createElement('div');
                emptyDiv.className = 'empty-message';
                emptyDiv.innerHTML = '<i class="fas fa-inbox"></i><p>ขณะนี้ยังไม่มีรายการอาหารในเมนู<br>กรุณาตรวจสอบอีกครั้งในภายหลัง</p>';
                container.appendChild(emptyDiv);
                
                // ซ่อน grid
                const menuGrid = document.querySelector('.menu-grid');
                if (menuGrid) {
                    menuGrid.style.display = 'none';
                }
            }
        });
    </script>
</body>
</html>