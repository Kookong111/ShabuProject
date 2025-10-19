<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>เมนูอาหาร</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f8f9fa; color: #333; }
        .container { max-width: 800px; margin: 0 auto; background-color: #ffffff; min-height: 100vh; box-shadow: 0 0 20px rgba(0,0,0,0.1); }
        .header { background-color: #fff; padding: 20px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 100; }
        .cart-icon-btn { background: none; border: none; cursor: pointer; font-size: 26px; color: #333; padding: 10px; border-radius: 50%; transition: all 0.2s ease; }
        .cart-icon-btn:hover { background-color: #f0f0f0; transform: scale(1.05); }
        .menu-container { padding: 0 30px 30px 30px; }
        .foodtype-name { font-size: 20px; font-weight: 700; color: #2c3e50; margin: 25px 0 15px 0; padding-bottom: 8px; border-bottom: 2px solid #e74c3c; }
        .menu-item { background-color: #fff; border-radius: 15px; padding: 20px; margin-bottom: 15px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); border: 1px solid #f0f0f0; transition: all 0.2s ease; }
        .menu-item:hover { transform: translateY(-2px); box-shadow: 0 4px 15px rgba(0,0,0,0.12); }
        .menu-content { display: flex; align-items: center; gap: 20px; }
        .menu-image { width: 90px; height: 90px; border-radius: 12px; object-fit: cover; border: 1px solid #eee; }
        .menu-details { flex-grow: 1; }
        .menu-name { font-size: 18px; font-weight: 600; color: #2c3e50; margin-bottom: 6px; }
        .menu-price { font-size: 16px; color: #e74c3c; font-weight: 600; }
        .qty-control { display: flex; align-items: center; gap: 15px; margin-top: 15px; justify-content: flex-end; }
        .qty-btn { background-color: #fff; border: 2px solid #e74c3c; color: #e74c3c; width: 40px; height: 40px; border-radius: 50%; font-size: 20px; font-weight: bold; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: all 0.2s ease; }
        .qty-btn:hover { background-color: #e74c3c; color: white; transform: scale(1.1); }
        .qty-number { font-size: 20px; font-weight: 600; color: #2c3e50; min-width: 35px; text-align: center; background-color: #f8f9fa; padding: 6px 12px; border-radius: 10px; border: 1px solid #dee2e6; }
        .menu-item.has-items { border-color: #e74c3c; background-color: #fdf2f0; }
        .menu-item.has-items .qty-number { background-color: #e74c3c; color: white; border-color: #e74c3c; }
        #total-price { text-align: right; font-size: 18px; font-weight: 600; color: #e74c3c; margin: 15px 30px 0 0; }
    </style>
</head>

<body>
<div class="container">
    <div class="header">
        <form action="viewCart" method="get">
            <button type="submit" class="cart-icon-btn" title="ดูตะกร้า">
                <i class="fas fa-shopping-cart"></i>
            </button>
        </form>
    </div>

    <div id="total-price">รวมทั้งหมด: <span id="sum">0</span> บาท</div>

    <div class="menu-container">
        <c:forEach var="foodType" items="${foodTypeList}">
            <c:if test="${foodType.foodtypeName != 'ต่อคน'}">
                <div class="foodtype-section">
                    <div class="foodtype-name">${foodType.foodtypeName}</div>
                    <c:forEach var="menu" items="${menuList}">
                        <c:if test="${menu.foodtype.foodtypeId == foodType.foodtypeId}">
                            <div class="menu-item" id="item-${menu.foodId}">
                                <div class="menu-content">
                                    <img src="${menu.foodImage}" alt="${menu.foodname}" class="menu-image">
                                    <div class="menu-details">
                                        <div class="menu-name">${menu.foodname}</div>
                                        <div class="menu-price">฿ ${menu.price}</div>
                                    </div>
                                </div>

                                <div class="qty-control">
                                    <button class="qty-btn" onclick="updateQuantity(${menu.foodId}, 'decrease', ${menu.price})">−</button>
                                    <div class="qty-number" id="qty-${menu.foodId}">
                                        <c:out value="${sessionScope.cart[menu.foodId]}" default="0"/>
                                    </div>
                                    <button class="qty-btn" onclick="updateQuantity(${menu.foodId}, 'increase', ${menu.price})">+</button>
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
function updateQuantity(foodId, action, price) {
    fetch('updateQuantityAjax', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'foodId=' + foodId + '&action=' + action
    })
    .then(response => response.json())
    .then(data => {
        const qtyElement = document.getElementById('qty-' + foodId);
        qtyElement.innerText = data.quantity;

        const itemDiv = document.getElementById('item-' + foodId);
        if (data.quantity > 0) {
            itemDiv.classList.add('has-items');
        } else {
            itemDiv.classList.remove('has-items');
        }

        document.getElementById('sum').innerText = data.totalPrice.toFixed(2);
    })
    .catch(error => console.error('Error:', error));
}
</script>
</body>
</html>
