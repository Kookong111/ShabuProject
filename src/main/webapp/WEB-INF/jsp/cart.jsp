<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>ตะกร้าอาหาร</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- Font Awesome CDN -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

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
            padding: 20px 30px 60px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 1px solid #ddd;
        }

        .header h2 {
            font-size: 24px;
            font-weight: 700;
        }

        .cart-container {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin-top: 30px;
        }

        .cart-item {
            display: flex;
            align-items: center;
            background-color: #fff;
            border: 1px solid #f0f0f0;
            border-radius: 15px;
            padding: 15px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
            transition: all 0.2s ease;
        }

        .cart-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .cart-item img {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 12px;
            margin-right: 20px;
            border: 1px solid #eee;
        }

        .cart-info {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
        }

        .cart-info .name {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 6px;
            color: #2c3e50;
        }

        .cart-info .price,
        .cart-info .quantity {
            font-size: 16px;
            color: #555;
            margin-bottom: 4px;
        }

        .cart-info .subtotal {
            margin-top: 8px;
            font-size: 16px;
            color: #e67e22;
            font-weight: 600;
        }

        .cart-info .subtotal i {
            margin-right: 6px;
        }

        .qty-control {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 12px;
        }

        .qty-btn {
            background-color: #fff;
            border: 2px solid #e74c3c;
            color: #e74c3c;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            font-size: 20px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .qty-btn:hover {
            background-color: #e74c3c;
            color: white;
            transform: scale(1.1);
        }

        .qty-btn:disabled {
            opacity: 0.4;
            cursor: not-allowed;
        }

        .qty-number {
            font-size: 18px;
            font-weight: 600;
            padding: 5px 12px;
            background-color: #f0f0f0;
            border-radius: 10px;
            border: 1px solid #ddd;
            min-width: 30px;
            text-align: center;
        }

        .summary-bar {
            position: sticky;
            bottom: 0;
            background: #fff;
            border-top: 1px solid #eee;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 -2px 10px rgba(0, 0, 0, 0.05);
            z-index: 100;
        }

        .total-price {
            font-size: 18px;
            font-weight: bold;
            color: #2c3e50;
        }

        .confirm-btn {
            background-color: #e74c3c;
            color: white;
            padding: 10px 20px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: bold;
            transition: all 0.2s ease;
        }

        .confirm-btn:hover {
            background-color: #c0392b;
        }

        .back-button {
            background-color: transparent;
            color: #e74c3c;
            font-weight: bold;
            text-decoration: none;
            border: 2px solid #e74c3c;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .back-button:hover {
            background-color: #e74c3c;
            color: #fff;
        }

        @media (max-width: 520px) {
            .container {
                padding: 15px;
            }

            .cart-item {
                flex-direction: column;
                align-items: flex-start;
            }

            .cart-item img {
                margin-bottom: 10px;
            }

            .summary-bar {
                flex-direction: column;
                gap: 10px;
                align-items: flex-start;
            }

            .confirm-btn {
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h2><i class="fas fa-shopping-cart"></i> ตะกร้าอาหาร</h2>
        <a href="viewmenu" class="back-button"><i class="fas fa-arrow-left"></i> กลับเมนู</a>
    </div>

    <c:if test="${empty cartItems}">
        <p style="margin-top: 30px; font-size: 18px; color: #777;">
            <i class="fas fa-box-open"></i> ยังไม่มีรายการในตะกร้า
        </p>
    </c:if>

    <c:if test="${not empty cartItems}">
        <c:set var="total" value="0" />
        <div class="cart-container">
            <c:forEach var="entry" items="${cartItems}">
                <c:set var="qty" value="${entry.key.value}" />
                <c:set var="price" value="${entry.value.price}" />
                <c:set var="subtotal" value="${qty * price}" />
                <c:set var="total" value="${total + subtotal}" />

                <div class="cart-item">
                    <img src="${entry.value.foodImage}" alt="${entry.value.foodname}" />
                    <div class="cart-info">
                        <div class="name">${entry.value.foodname}</div>
                        <div class="price">฿<fmt:formatNumber value="${price}" type="number" /></div>

                        <div class="qty-control">
                            <form action="updateQuantity" method="post">
                                <input type="hidden" name="foodId" value="${entry.value.foodId}" />
                                <input type="hidden" name="action" value="decrease" />
                                <button class="qty-btn" ${qty <= 0 ? 'disabled' : ''}>−</button>
                            </form>

                            <div class="qty-number">${qty}</div>

                            <form action="updateQuantity" method="post">
                                <input type="hidden" name="foodId" value="${entry.value.foodId}" />
                                <input type="hidden" name="action" value="increase" />
                                <button class="qty-btn">+</button>
                            </form>
                        </div>

                        <div class="subtotal">
                            <i class="fas fa-coins"></i>
                            รวม: <span class="subtotal-price">฿<fmt:formatNumber value="${subtotal}" type="number" /></span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="summary-bar">
            <div class="total-price">
                ราคารวม: ฿<fmt:formatNumber value="${total}" type="number" />
            </div>
            <a href="confirmOrder" class="confirm-btn">ยืนยันคำสั่งซื้อ</a>
        </div>
    </c:if>
</div>
</body>
</html>
