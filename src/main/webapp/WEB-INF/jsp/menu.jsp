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
        * { margin: 0; padding: 0; box-sizing: border-box; }
        
        :root {
            --bg-page: #f2f3f7;
            --primary: #1e293b;
            --secondary: #64748b;
            --border: #e2e8f0;
            --radius: 20px;
            --accent: #4f46e5;
            --white: #ffffff;
            --success: #10b981;
        }

        body {
            font-family: 'Kanit', sans-serif;
            background-color: var(--bg-page);
            color: var(--primary);
            padding-bottom: 40px;
            padding-top: 110px; 
        }

        nav { 
            background: #fff; 
            padding: 15px 0; 
            border-bottom: 1px solid var(--border);
            position: fixed;
            top: 0; left: 0; right: 0;
            z-index: 1000;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
        }
        
        .nav-container { max-width: 1200px; margin: 0 auto; display: flex; justify-content: center; }
        .container { max-width: 1200px; margin: 0 auto; padding: 0 20px; }

        /* --- Filter Section --- */
        .filter-section {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            margin-top: 10px;
            flex-wrap: wrap;
        }
        
        .search-wrapper, .select-wrapper { position: relative; flex: 1; min-width: 280px; }
        
        .search-wrapper input, .select-wrapper select {
            width: 100%; 
            padding: 16px 15px 16px 50px;
            border-radius: 14px;
            border: 1px solid var(--border); 
            background: var(--white); 
            font-family: 'Kanit';
            font-size: 1rem;
            outline: none;
            transition: all 0.3s ease;
        }
        
        .search-wrapper input:focus, .select-wrapper select:focus {
            border-color: var(--accent);
            box-shadow: 0 4px 12px rgba(79, 70, 229, 0.1);
        }

        .search-icon { 
            position: absolute; top: 50%; left: 20px;
            transform: translateY(-50%); 
            color: var(--secondary); 
        }

        /* --- Grid & Items (ปรับแต่งการแสดงผลในคอม) --- */
        .menu-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); 
            gap: 30px;
        }
        
        .menu-item {
            background: var(--white); 
            border-radius: var(--radius); 
            display: flex;
            flex-direction: column; 
            padding: 20px; 
            min-height: 520px; /* ปรับความสูงให้พอดีกับรูปและการชิดของข้อความ */
            height: 100%;
            transition: transform 0.3s cubic-bezier(0.34, 1.56, 0.64, 1), box-shadow 0.3s ease; 
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
        }
        
        .menu-item:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
        }

        .image-container {
            width: 100%; 
            height: 320px; /* ความสูงบล็อกรูปภาพในจอคอม */
            background: #f8fafc; 
            border-radius: 15px; 
            overflow: hidden; 
            display: flex; 
            align-items: center; 
            justify-content: center; 
            margin-bottom: 20px;
            position: relative;
        }
        
        .menu-item img { 
            width: 100%; 
            height: 100%; 
            object-fit: cover; 
            transition: transform 0.6s ease;
        }

        .menu-item:hover img { transform: scale(1.1); }

        .item-details { 
            display: flex; 
            flex-direction: column; 
            flex-grow: 1; 
        }

        .food-type { 
            font-size: 0.85rem; 
            color: var(--accent); 
            font-weight: 600; 
            margin-bottom: 5px; 
        }
        
        /* แก้ไขให้ชื่ออาหารชิดราคามากขึ้น */
        .item-details h2 { 
            font-size: 1.25rem; 
            margin-bottom: 5px; /* ลด margin-bottom ให้เหลือ 5px */
            color: var(--primary); 
            line-height: 1.3; 
            font-weight: 500;
            min-height: 2.6em; /* ปรับขนาดพื้นที่ชื่อให้เล็กลงเล็กน้อย */
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        /* แก้ไขให้ส่วนราคาขยับขึ้นมาชิดชื่อ */
        .price-container { 
            margin-top: 5px; /* ลด margin-top ให้เหลือ 5px */
            padding-top: 10px; 
            border-top: 1px solid #f1f5f9; 
            display: flex;
            align-items: baseline;
        }
        
        .price { font-size: 1.8rem; font-weight: 700; color: var(--primary); }
        .currency { font-size: 1rem; color: var(--secondary); margin-left: 5px; }
        .free-buffet-label { font-size: 1.2rem; color: var(--success); font-weight: 600; }

        /* --- Mobile Responsive --- */
        @media (max-width: 600px) {
            body { padding-top: 100px; } 
            .menu-grid { grid-template-columns: repeat(2, 1fr); gap: 12px; }
            .menu-item { min-height: 360px; padding: 12px; }
            .image-container { height: 180px; margin-bottom: 12px; }
            .item-details h2 { font-size: 1rem; min-height: 2.6em; margin-bottom: 5px; }
            .price { font-size: 1.2rem; }
            .free-buffet-label { font-size: 1rem; }
        }
    </style>
</head>
<body>
    <nav>
        <div class="nav-container">
            <%@ include file="/WEB-INF/jsp/include/navbar.jsp" %>
        </div>
    </nav>

    <div class="container">
        <div class="filter-section">
            <div class="search-wrapper">
                <i class="fas fa-search search-icon"></i>
                <input type="text" id="searchInput" placeholder="ค้นหาเมนูอาหาร..." onkeyup="filterMenu()">
            </div>
            
            <div class="select-wrapper">
                <i class="fas fa-filter search-icon"></i> 
                <select id="categorySelect" onchange="filterMenu()">
                    <option value="all">ประเภทอาหารทั้งหมด</option>
                    <c:set var="addedTypes" value="" />
                    <c:forEach items="${menuItems}" var="item">
                        <c:if test="${!addedTypes.contains(item.foodtype.foodtypeName) && !item.foodtype.foodtypeName.contains('ต่อคน')}">
                            <option value="${item.foodtype.foodtypeName}">${item.foodtype.foodtypeName}</option>
                            <c:set var="addedTypes" value="${addedTypes},${item.foodtype.foodtypeName}" />
                        </c:if>
                    </c:forEach>
                </select>
            </div>
        </div>
        
        <div class="menu-grid" id="mainGrid">
            <c:forEach items="${menuItems}" var="item">
                <c:if test="${!item.foodname.contains('บุฟเฟต์') && !item.foodname.contains('ต่อคน')}">
                    <div class="menu-item" data-name="${item.foodname.toLowerCase()}" data-category="${item.foodtype.foodtypeName}">
                        <div class="image-container">
                            <c:choose>
                                <c:when test="${not empty item.foodImage}">
                                    <img src="${item.foodImage}" alt="${item.foodname}" loading="lazy">
                                </c:when>
                                <c:otherwise>
                                    <div style="display: flex; flex-direction: column; align-items: center; color: #cbd5e1;">
                                        <i class="fas fa-image" style="font-size: 3rem; margin-bottom: 10px;"></i>
                                        <span style="font-size: 0.8rem;">ไม่มีรูปภาพ</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="item-details">
                            <span class="food-type">${item.foodtype.foodtypeName}</span>
                            <h2>${item.foodname}</h2>
                            <div class="price-container">
                                <c:choose>
                                    <c:when test="${item.price == 0 || empty item.price}">
                                        <span class="free-buffet-label">รวมในบุฟเฟต์</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="price"><fmt:formatNumber value="${item.price}" pattern="#,##0" /></span>
                                        <span class="currency">บาท</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>

        <div id="noDataMessage" style="display:none; text-align:center; padding: 120px 20px; color: var(--secondary);">
            <i class="fas fa-search" style="font-size: 4rem; margin-bottom: 20px; opacity: 0.2;"></i>
            <p style="font-size: 1.2rem; font-weight: 300;">ขออภัย ไม่พบเมนูที่คุณกำลังมองหา</p>
            <button onclick="resetFilters()" style="margin-top: 15px; background: none; border: 1px solid var(--accent); color: var(--accent); padding: 8px 20px; border-radius: 8px; cursor: pointer;">ล้างการค้นหา</button>
        </div>
    </div>

    <script>
        function filterMenu() {
            const searchInput = document.getElementById('searchInput').value.toLowerCase().trim();
            const categorySelect = document.getElementById('categorySelect').value;
            const menuItems = document.querySelectorAll('.menu-item');
            const noDataMessage = document.getElementById('noDataMessage');
            const mainGrid = document.getElementById('mainGrid');
            
            let visibleCount = 0;

            menuItems.forEach(item => {
                const name = item.getAttribute('data-name');
                const category = item.getAttribute('data-category');
                
                const matchesSearch = name.includes(searchInput);
                const matchesCategory = (categorySelect === 'all' || category === categorySelect);

                if (matchesSearch && matchesCategory) {
                    item.style.display = 'flex';
                    visibleCount++;
                } else {
                    item.style.display = 'none';
                }
            });

            if (visibleCount === 0) {
                mainGrid.style.display = 'none';
                noDataMessage.style.display = 'block';
            } else {
                mainGrid.style.display = 'grid';
                noDataMessage.style.display = 'none';
            }
        }

        function resetFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('categorySelect').value = 'all';
            filterMenu();
        }

        window.onload = filterMenu;
    </script>
</body>
</html>