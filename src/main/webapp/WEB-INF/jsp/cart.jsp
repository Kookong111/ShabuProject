<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>ตะกร้าอาหาร</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        /* === 1. Global & Variables (Red/Dark Style - ตรงกับ orderfoodCuatomer.jsp) === */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Kanit', sans-serif;
        }

        :root {
            /* โทนสีเรียบง่าย สบายตา (จาก orderfoodCuatomer.jsp) */
            --primary: #e57373;
            --primary-dark: #d32f2f;
            --primary-light: #ffebee;
            
            --text-dark: #2c3e50;
            --text-gray: #7f8c8d;
            --border: #ecf0f1;
            
            --white: #ffffff;
            --bg: #fafafa; /* พื้นหลังของเมนู items */
            --bg-page: #f8f9fa; /* พื้นหลังของหน้า */
            --header-dark: #1a1a1a;
            
            --shadow-sm: 0 1px 3px rgba(0,0,0,0.08);
            --shadow-md: 0 2px 6px rgba(0,0,0,0.1);
        }

        body {
            background-color: var(--bg-page);
            color: var(--text-dark);
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 800px;
            margin: 30px auto;
            background-color: var(--white);
            min-height: 85vh;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            border-radius: 12px;
            padding: 30px;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        /* === Header === */
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-bottom: 20px;
            border-bottom: 3px solid var(--primary); /* เส้นแบ่งสีแดง */
            margin-bottom: 25px;
        }

        .header h1 {
            font-size: 28px;
            font-weight: 800;
            color: var(--primary-dark); /* สีแดงเข้ม */
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .back-btn {
            background-color: #fff;
            color: var(--text-dark);
            font-weight: 600;
            text-decoration: none;
            border: 1px solid var(--border);
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .back-btn:hover {
            background-color: var(--bg);
            color: var(--primary);
        }

        /* === Cart Items === */
        .cart-items {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .cart-item {
            display: flex;
            background-color: var(--white);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 15px;
            box-shadow: var(--shadow-sm);
        }
        
        .item-img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 15px;
            border: 2px solid var(--border);
            flex-shrink: 0;
        }

        .item-details {
            display: grid;
            grid-template-columns: 2fr 1fr;
            align-items: center;
            flex-grow: 1;
        }

        .item-name {
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 4px;
            color: var(--text-dark);
        }

        .price-per-unit {
            font-size: 14px;
            font-weight: 400;
            color: var(--text-gray);
        }
        
        .subtotal {
            grid-column: 1 / 2;
            margin-top: 8px;
            font-size: 18px;
            color: var(--primary-dark); /* สีแดงเข้ม */
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 8px;
        }
        
        .subtotal i {
            color: var(--primary);
        }

        /* === Quantity Control === */
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 8px;
            justify-self: end;
        }

        .qty-form {
            display: inline-flex;
        }

        .qty-btn {
            background-color: var(--primary); /* สีแดงอ่อน */
            border: none;
            color: white;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: var(--shadow-sm);
        }

        .qty-btn:hover {
            background-color: var(--primary-dark);
        }

        .qty-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            background-color: var(--text-muted);
            box-shadow: none;
        }

        .qty-number {
            font-size: 18px;
            font-weight: 700;
            padding: 5px 12px;
            min-width: 30px;
            text-align: center;
            color: var(--text-dark);
        }

        /* === Summary Bar & Actions === */
        .summary-bar {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid var(--primary); /* เส้นแบ่งสีแดง */
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-price {
            font-size: 24px;
            font-weight: 800;
            color: var(--text-dark);
        }

        .confirm-btn {
            background-color: var(--primary-dark); /* สีแดงเข้ม */
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 800;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 4px 10px rgba(211, 47, 47, 0.4);
        }

        .confirm-btn:hover {
            background-color: #aa2424;
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(211, 47, 47, 0.6);
        }
        
        /* === Empty State === */
        .empty-cart-state {
            text-align: center;
            padding: 50px 0;
            margin-top: 30px;
            border: 2px dashed var(--border);
            border-radius: 12px;
            color: var(--text-muted);
        }
        
        .empty-cart-state i {
            font-size: 40px;
            margin-bottom: 15px;
            color: var(--primary);
        }
        
        .empty-cart-state p {
            font-size: 18px;
            margin-bottom: 20px;
            font-weight: 500;
        }
        
        .action-btn {
            background-color: var(--primary);
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: background-color 0.2s;
        }
        
        .action-btn:hover {
            background-color: var(--primary-dark);
        }

        /* === Responsive === */
        @media (max-width: 520px) {
            .container {
                padding: 15px;
                margin: 0;
                border-radius: 0;
                box-shadow: none;
            }

            .header h1 {
                font-size: 24px;
            }

            .cart-item {
                flex-wrap: wrap;
                gap: 10px;
                padding: 10px;
            }
            
            .item-img {
                width: 60px;
                height: 60px;
                margin-right: 10px;
            }

            .item-details {
                grid-template-columns: 1fr;
                gap: 5px;
                padding: 5px 0;
            }
            
            .subtotal {
                grid-column: 1 / 2;
                margin-top: 0;
                font-size: 16px;
            }
            
            .quantity-control {
                justify-content: flex-start;
                margin-top: 10px;
                width: 100%;
            }

            .summary-bar {
                flex-direction: column;
                gap: 15px;
            }
            
            .total-price {
                order: 2;
            }
            
            .confirm-btn {
                order: 1;
                width: 100%;
                text-align: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class=""></i> ตะกร้าอาหาร</h1>
        <a href="viewmenu" class="back-btn"><i class="fas fa-arrow-left"></i> กลับไปเมนู</a>
    </div>

    <c:if test="${not empty error}">
        <div class="alert-danger">${error}</div>
    </c:if>
    
    <c:if test="${not empty cartItemsList and cartItemsList.size() > 0}">
        <div class="cart-items">
            <c:forEach items="${cartItemsList}" var="item">
                <div class="cart-item">
                    <img src="${item.menufood.foodImage}" alt="${item.menufood.foodname}" class="item-img" />
                    <div class="item-details">
                        <div class="item-name">
                            ${item.menufood.foodname} 
                            <span class="price-per-unit">(฿<fmt:formatNumber value="${item.priceAtTime}" type="number" minFractionDigits="2" maxFractionDigits="2" />/หน่วย)</span>
                        </div>
                        
                        <c:set var="qty" value="${item.quantity}" />
                        <c:set var="subtotal" value="${item.totalPrice}" />
                        
                        <div class="subtotal">
                            <i class=""></i>
                            รวม: <span class="subtotal-price">฿<fmt:formatNumber value="${subtotal}" type="number" minFractionDigits="2" maxFractionDigits="2" /></span>
                        </div>
                        
                        <div class="quantity-control">
                            <form action="updateQuantity" method="post" class="qty-form">
                                <input type="hidden" name="foodId" value="${item.menufood.foodId}" />
                                <input type="hidden" name="action" value="decrease" />
                                <button class="qty-btn" ${qty <= 1 ? 'disabled' : ''}>−</button>
                            </form>

                            <div class="qty-number">${qty}</div>

                            <form action="updateQuantity" method="post" class="qty-form">
                                <input type="hidden" name="foodId" value="${item.menufood.foodId}" />
                                <input type="hidden" name="action" value="increase" />
                                <button class="qty-btn">+</button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="summary-bar">
            <div class="total-price">
                ราคารวม: ฿<fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2" />
            </div>
            <form action="confirmOrder" method="post">
                <button type="submit" class="confirm-btn">ยืนยันคำสั่งซื้อ</button>
            </form>
        </div>
    </c:if>
    <c:if test="${empty cartItemsList or cartItemsList.size() == 0}">
         <div class="empty-cart-state">
            <i class="fas fa-box-open"></i>
            <p>ตะกร้าสินค้าว่างเปล่า</p>
            <a href="viewmenu" class="action-btn">ไปสั่งอาหาร</a>
        </div>
    </c:if>
</div>
</body>
</html>