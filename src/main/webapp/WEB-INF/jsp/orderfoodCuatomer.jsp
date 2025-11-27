<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <title>เมนูอาหาร</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        /* === 1. Global & Variables (UI ต้นฉบับ) === */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            /* โทนสีเรียบง่าย สบายตา */
            --primary: #e57373;
            --primary-dark: #d32f2f;
            --primary-light: #ffebee;
            
            --text-dark: #2c3e50;
            --text-gray: #7f8c8d;
            --border: #ecf0f1;
            
            --white: #ffffff;
            --bg: #fafafa;
            
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.08);
            --shadow-md: 0 2px 6px rgba(0,0,0,0.1);
        }

        body {
            font-family: 'Kanit', sans-serif;
            background-color: var(--bg);
            color: var(--text-dark);
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: var(--white);
            min-height: 100vh;
            padding-bottom: 100px;
        }

        /* === 2. Header === */
        .header {
            background-color: #1a1a1a; /* Dark Header */
            border-bottom: 1px solid var(--border);
            padding: 16px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: var(--shadow-sm);
        }

        .table-info {
            font-size: 18px;
            font-weight: 600;
            color: var(--white);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .table-info i {
            display: none; 
        }
        
        .table-id {
             font-size: 1.2em; 
             font-weight: 700;
             color: var(--white);
             margin-left: 5px;
        }

        .back-btn {
            background-color: rgba(255,255,255,0.1);
            border: 1px solid rgba(255,255,255,0.3);
            color: var(--white);
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: all 0.2s ease;
        }
        
        .back-btn:hover {
            background-color: rgba(255,255,255,0.2);
            border-color: rgba(255,255,255,0.5);
        }
        
        /* VVVV สไตล์สำหรับปุ่มใหม่ VVVV */
        .btn-view-order {
            background-color: var(--primary-dark);
            color: var(--white);
            padding: 8px 10px; /* แก้ไขให้เล็กลง */
            border-radius: 50%; /* ทำให้เป็นวงกลม */
            font-size: 18px; /* เพิ่มขนาดไอคอน */
            font-weight: 500;
            cursor: pointer;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center; /* จัดไอคอนให้อยู่ตรงกลาง */
            width: 40px; /* กำหนดความกว้าง/สูงเท่ากัน */
            height: 40px;
            transition: all 0.2s ease;
        }
        
        .btn-view-order:hover {
             background-color: #aa2424;
             transform: scale(1.05);
        }
        
        .btn-view-order span {
            display: none; /* ซ่อนข้อความ */
        }
        
        .header-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }
        /* ^^^^ สิ้นสุดสไตล์สำหรับปุ่มใหม่ ^^^^ */

        /* === 3. Menu Container === */
        .menu-container {
            padding: 20px;
        }

        .foodtype-section {
            margin-bottom: 32px;
        }

        .foodtype-name {
            font-size: 22px;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 16px;
            padding: 12px 0;
        }
        
        .foodtype-name i {
            display: none;
        }

        /* === 4. Menu Item Card === */
        .menu-item {
            background-color: var(--white);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 16px;
            margin-bottom: 12px;
            transition: all 0.2s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
        }

        .menu-item:hover {
            box-shadow: var(--shadow-md);
            border-color: var(--primary);
        }

        .menu-content {
            display: flex;
            align-items: center;
            gap: 16px;
            flex-grow: 1;
            min-width: 0;
        }

        .menu-image {
            width: 75px;
            height: 75px;
            border-radius: 8px;
            object-fit: cover;
            border: 1px solid var(--border);
            flex-shrink: 0;
        }

        .menu-details {
            flex-grow: 1;
            min-width: 0;
        }

        .menu-name {
            font-size: 16px;
            font-weight: 600;
            color: var(--text-dark);
            margin-bottom: 6px;
            line-height: 1.3;
        }
        
        .menu-description {
            font-size: 13px;
            color: var(--text-gray);
            margin-bottom: 6px;
            line-height: 1.4;
        }

        .menu-price {
            font-size: 17px;
            color: var(--primary);
            font-weight: 700;
        }

        /* === 5. ส่วนควบคุมการสั่ง === */
        .item-actions {
            display: flex;
            align-items: center;
            gap: 8px;
            flex-shrink: 0;
        }
        
        .qty-control {
            display: flex;
            align-items: center;
            gap: 12px;
            background-color: var(--bg);
            padding: 6px 12px;
            border-radius: 20px;
            border: 1px solid var(--border);
        }

        .qty-btn {
            background: none;
            border: none;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            font-size: 16px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            color: var(--primary);
            font-weight: 600;
        }
        
        .qty-btn:hover {
            background-color: var(--primary-light);
        }
        
        .qty-btn:active {
            transform: scale(0.95);
        }

        .qty-number {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-dark);
            min-width: 24px;
            text-align: center;
        }
        
        .add-to-cart-form button {
            background-color: var(--primary);
            color: var(--white);
            border: none;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
            box-shadow: var(--shadow-sm);
        }
        
        .add-to-cart-form button:hover {
            background-color: var(--primary-dark);
            box-shadow: var(--shadow-md);
        }
        
        .add-to-cart-form button:active {
            transform: translateY(0);
        }

        /* เอฟเฟกต์เมื่อมีสินค้าในตะกร้า */
        .menu-item.has-items {
            background-color: var(--primary-light);
            border-color: var(--primary);
        }
        
        .menu-item.has-items .menu-image {
            border-color: var(--primary);
        }

        /* === 6. Sticky Cart Footer === */
        .sticky-cart-footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            z-index: 100;
            background-color: #1a1a1a;
            border-top: 1px solid #333;
            padding: 16px 20px;
            box-shadow: 0 -2px 8px rgba(0,0,0,0.2);
        }

        .cart-footer-content {
            max-width: 800px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
        }

        .cart-summary {
            font-size: 15px;
            color: var(--white);
            font-weight: 500;
        }
        
        .cart-summary .total-items {
            font-weight: 700;
            font-size: 20px;
            color: var(--white);
        }

        .view-cart-btn {
            background-color: #333333;
            color: var(--white);
            padding: 12px 32px;
            border: 1px solid #555555;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-shrink: 0;
        }
        
        .view-cart-btn:hover {
            background-color: #444444;
            border-color: #666666;
        }
        
        .view-cart-btn:active {
            transform: translateY(0);
        }

        /* === 7. Responsive === */
        @media (max-width: 600px) {
            .container {
                padding-bottom: 90px;
            }
            
            .header {
                padding: 12px 16px;
            }
            
            .table-info {
                font-size: 16px;
            }

            .back-btn span {
                display: none;
            }
            
            .menu-container {
                padding: 16px;
            }
            
            .foodtype-name {
                font-size: 18px;
                padding: 10px 14px;
            }
            
            .menu-item {
                flex-direction: column;
                align-items: stretch;
                gap: 12px;
                padding: 14px;
            }

            .menu-content {
                gap: 12px;
            }
            
            .menu-image {
                width: 70px;
                height: 70px;
            }
            
            .menu-name {
                font-size: 15px;
            }
            
            .menu-description {
                font-size: 12px;
            }
            
            .menu-price {
                font-size: 16px;
            }

            .item-actions {
                width: 100%;
                justify-content: space-between;
            }
            
            .qty-control {
                flex-grow: 1;
                justify-content: center;
            }
            
            .cart-footer-content {
                flex-direction: column;
                gap: 12px;
                align-items: stretch;
            }
            
            .cart-summary {
                text-align: center;
            }
            
            .view-cart-btn {
                width: 100%;
                justify-content: center;
                padding: 14px 32px;
            }
        }
        
        /* Loading animation */
        .container.loading {
            opacity: 0.6;
            pointer-events: none;
        }
        
        /* Message Display */
        .message-alert {
            position: fixed;
            top: 70px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 1000;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 15px;
            box-shadow: var(--shadow-md);
            max-width: 90%;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>
    <div class="container">
        <c:if test="${not empty orderSuccess}">
            <div class="message-alert success-message">${orderSuccess}</div>
            <c:remove var="orderSuccess" scope="session" />
        </c:if>
        
        <div class="header">
            <div class="table-info">
                โต๊ะ
                <c:if test="${not empty activeTable}">
                    <span class="table-id">${activeTable.tableid}</span>
                </c:if>
            </div>
            
            <div class="header-actions">
                
                <a href="viewCurrentOrder" class="btn-view-order">
                    <i class="fas fa-list-alt"></i> 
                    <span>รายการสั่งอาหาร</span>
                </a>
                
                <form action="gotowelcomeCustomer" method="get" style="display: inline;">
                    <button type="submit" class="back-btn">
                        <i class="fas fa-arrow-left"></i>
                        <span>กลับ</span>
                    </button>
                </form>
            </div>
        </div>

        <div class="menu-container">
            <c:set var="totalItems" value="${sessionScope.totalCartItems}" />
            
            <c:forEach var="foodType" items="${foodTypeList}">
                <c:if test="${foodType.foodtypeName != 'ต่อคน'}">
                    <div class="foodtype-section">
                        <div class="foodtype-name">
                            ${foodType.foodtypeName}
                        </div>
                        
                        <c:forEach var="menu" items="${menuList}">
                            <c:if test="${menu.foodtype.foodtypeId == foodType.foodtypeId}">
                                
                                <c:set var="currentQty" value="${sessionScope.cart[menu.foodId]}" />
                                <c:set var="currentQty" value="${currentQty == null ? 0 : currentQty}" />
                                
                                <div class="menu-item ${currentQty > 0 ? 'has-items' : ''}">
                                    <div class="menu-content">
                                        <img src="${menu.foodImage}" alt="${menu.foodname}" class="menu-image">
                                        
                                        <div class="menu-details">
                                            <div class="menu-name">${menu.foodname}</div>
                                            
                                            <div class="menu-price">
                                                ฿<fmt:formatNumber value="${menu.price}" type="number" minFractionDigits="0" maxFractionDigits="2" />
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="item-actions">
                                        <c:if test="${currentQty > 0}">
                                            <div class="qty-control">
                                                <form action="updateQuantity" method="post" style="display:inline;">
                                                    <input type="hidden" name="foodId" value="${menu.foodId}" />
                                                    <input type="hidden" name="action" value="decrease" />
                                                    <button type="submit" class="qty-btn">
                                                        <i class="fas fa-minus"></i>
                                                    </button>
                                                </form>
                                                
                                                <div class="qty-number">
                                                    <c:out value="${currentQty}" />
                                                </div>
                                                
                                                <form action="addToCart" method="post" style="display:inline;" class="add-to-cart-form">
                                                    <input type="hidden" name="foodId" value="${menu.foodId}" />
                                                    <button type="submit" class="qty-btn">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </c:if>

                                        <c:if test="${currentQty == 0}">
                                            <form action="addToCart" method="post" style="display:inline;" class="add-to-cart-form">
                                                <input type="hidden" name="foodId" value="${menu.foodId}" />
                                                <button type="submit">
                                                    <i class="fas fa-plus"></i> เพิ่ม
                                                </button>
                                            </form>
                                        </c:if>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        
    </div>
    
    <c:if test="${totalItems > 0}">
        <div class="sticky-cart-footer">
            <div class="cart-footer-content">
                <div class="cart-summary">
                    <span class="total-items">${totalItems}</span> รายการ
                </div>
                
                <form action="viewCart" method="get">
                    <button type="submit" class="view-cart-btn">
                        <i class="fas fa-shopping-cart"></i>
                        <span>ดูตะกร้า</span>
                    </button>
                </form>
            </div>
        </div>
    </c:if>

    <script>
        // Loading effect
        document.querySelectorAll('.container form').forEach(form => {
            form.addEventListener('submit', function(e) {
                document.querySelector('.container').classList.add('loading');
            });
        });

        window.addEventListener('load', function() {
            document.querySelector('.container').classList.remove('loading');
        });
        
        // Auto remove success message
        const successMessage = document.querySelector('.message-alert.success-message');
        if (successMessage) {
            setTimeout(() => {
                successMessage.style.transition = 'opacity 0.5s ease';
                successMessage.style.opacity = '0';
                setTimeout(() => successMessage.remove(), 500);
            }, 3000);
        }
    </script>
</body>
</html>