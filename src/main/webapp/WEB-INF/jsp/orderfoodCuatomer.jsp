<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>เมนูอาหาร</title>
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #ffffff;
            min-height: 100vh;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }

        .header {
            background-color: #fff;
            padding: 20px 30px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .table-info {
            font-size: 20px;
            font-weight: 600;
            color: #333;
        }

        .header-actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .back-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            color: white;
            padding: 10px 20px;
            border-radius: 25px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .back-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .back-btn:active {
            transform: translateY(0);
        }

        .cart-icon-btn {
            background: none;
            border: none;
            cursor: pointer;
            font-size: 26px;
            color: #333;
            padding: 10px;
            border-radius: 50%;
            transition: all 0.2s ease;
        }

        .cart-icon-btn:hover {
            background-color: #f0f0f0;
            transform: scale(1.05);
        }

        .menu-container {
            padding: 0 30px 30px 30px;
        }

        .foodtype-section {
            margin-bottom: 30px;
        }

        .foodtype-name {
            font-size: 20px;
            font-weight: 700;
            color: #2c3e50;
            margin: 25px 0 15px 0;
            padding-bottom: 8px;
            border-bottom: 2px solid #e74c3c;
            position: relative;
        }

        .foodtype-name:first-child {
            margin-top: 15px;
        }

        .menu-item {
            background-color: #fff;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            border: 1px solid #f0f0f0;
            transition: all 0.2s ease;
        }

        .menu-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.12);
        }

        .menu-content {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .menu-image {
            width: 90px;
            height: 90px;
            border-radius: 12px;
            object-fit: cover;
            border: 1px solid #eee;
            flex-shrink: 0;
        }

        .menu-details {
            flex-grow: 1;
            min-width: 0;
        }

        .menu-name {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 6px;
            line-height: 1.3;
        }

        .menu-price {
            font-size: 16px;
            color: #e74c3c;
            font-weight: 600;
        }

        .qty-control {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-top: 15px;
            justify-content: flex-end;
        }

        .qty-btn {
            background-color: #fff;
            border: 2px solid #e74c3c;
            color: #e74c3c;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }

        .qty-btn:hover {
            background-color: #e74c3c;
            color: white;
            transform: scale(1.1);
        }

        .qty-btn:active {
            transform: scale(0.95);
        }

        .qty-number {
            font-size: 20px;
            font-weight: 600;
            color: #2c3e50;
            min-width: 35px;
            text-align: center;
            background-color: #f8f9fa;
            padding: 6px 12px;
            border-radius: 10px;
            border: 1px solid #dee2e6;
        }

        /* เอฟเฟกต์เมื่อมีสินค้าในตะกร้า */
        .menu-item.has-items {
            border-color: #e74c3c;
            background-color: #fdf2f0;
        }

        .menu-item.has-items .qty-number {
            background-color: #e74c3c;
            color: white;
            border-color: #e74c3c;
        }

        /* Responsive */
        @media (max-width: 520px) {
            .container {
                max-width: 100%;
            }
            
            .menu-container {
                padding: 0 15px 20px 15px;
            }
            
            .header {
                padding: 12px 15px;
            }

            .back-btn {
                padding: 8px 16px;
                font-size: 14px;
            }

            .back-btn span {
                display: none;
            }

            .table-info {
                font-size: 16px;
            }
        }

        /* Loading animation */
        .loading {
            opacity: 0.7;
            pointer-events: none;
        }

        /* เอฟเฟกต์ปุ่ม */
        .qty-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="table-info">
                <i class="fas fa-utensils"></i> เมนูอาหาร
            </div>
            
            <div class="header-actions">
                <form action="viewCart" method="get" style="display: inline;">
                    <button type="submit" class="cart-icon-btn" title="ดูตะกร้า">
                        <i class="fas fa-shopping-cart"></i>
                    </button>
                </form>
                
                <form action="gotowelcomeCustomer" method="get" style="display: inline;">
                    <button type="submit" class="back-btn" title="กลับหน้าหลัก">
                        <i class="fas fa-arrow-left"></i>
                        <span>กลับ</span>
                    </button>
                </form>
            </div>
        </div>

        <!-- Menu Container -->
        <div class="menu-container">
            <c:forEach var="foodType" items="${foodTypeList}">
                <c:if test="${foodType.foodtypeName != 'ต่อคน'}">
                    <div class="foodtype-section">
                        <div class="foodtype-name">
                            ${foodType.foodtypeName}
                        </div>
                        
                        <c:forEach var="menu" items="${menuList}">
                            <c:if test="${menu.foodtype.foodtypeId == foodType.foodtypeId}">
                                <div class="menu-item ${sessionScope.cart[menu.foodId] > 0 ? 'has-items' : ''}">
                                    <div class="menu-content">
                                        <img src="${menu.foodImage}" alt="${menu.foodname}" class="menu-image">
                                        
                                        <div class="menu-details">
                                            <div class="menu-name">${menu.foodname}</div>
                                            <div class="menu-price">฿ ${menu.price}</div>
                                        </div>
                                    </div>
                                    
                                    <div class="qty-control">
                                        <form action="updateQuantity" method="post" style="display:inline;">
                                            <input type="hidden" name="foodId" value="${menu.foodId}" />
                                            <input type="hidden" name="action" value="decrease" />
                                            <button type="submit" class="qty-btn" ${sessionScope.cart[menu.foodId] <= 0 ? 'disabled' : ''}>
                                                −
                                            </button>
                                        </form>
                                        
                                        <div class="qty-number">
                                            <c:out value="${sessionScope.cart[menu.foodId]}" default="0"/>
                                        </div>
                                        
                                        <form action="updateQuantity" method="post" style="display:inline;">
                                            <input type="hidden" name="foodId" value="${menu.foodId}" />
                                            <input type="hidden" name="action" value="increase" />
                                            <button type="submit" class="qty-btn">
                                                +
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>

    <script>
        // เพิ่ม JavaScript สำหรับ UX ที่ดีขึ้น
        document.querySelectorAll('.qty-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                // เพิ่มเอฟเฟกต์ loading
                this.style.opacity = '0.5';
                setTimeout(() => {
                    this.style.opacity = '1';
                }, 300);
            });
        });

        // เพิ่ม smooth scroll สำหรับ category
        document.querySelectorAll('.foodtype-name').forEach(category => {
            category.style.cursor = 'pointer';
            category.addEventListener('click', function() {
                this.scrollIntoView({ behavior: 'smooth', block: 'start' });
            });
        });
    </script>
</body>
</html>