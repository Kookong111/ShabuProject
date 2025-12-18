<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>จองโต๊ะ | ShaBu Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --bg-primary: #f5f7fb;
            --bg-card: #ffffff;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
            --accent: #1e293b;
            --accent-light: #4f46e5;
            --border: rgba(15, 23, 42, 0.1);
            --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.08);
            --shadow-lg: 0 20px 40px rgba(0, 0, 0, 0.12);
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
        }

        body {
            font-family: 'Kanit', sans-serif;
            background: linear-gradient(135deg, var(--bg-primary) 0%, #ffffff 100%);
            color: var(--text-primary);
            line-height: 1.6;
            overflow-x: hidden;
            min-height: 100vh;
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
            border-bottom: 1px solid var(--border);
            z-index: 1000;
            transition: transform 0.3s ease;
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            max-width: 1400px;
            margin: 0 auto;
        }

        .logo {
            font-size: 28px;
            font-weight: 600;
            color: var(--text-primary);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-menu {
            display: flex;
            list-style: none;
            gap: 40px;
            align-items: center;
        }

        .nav-menu a {
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 400;
            font-size: 15px;
            padding: 8px 0;
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

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 24px;
            background: rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border);
            border-radius: 12px;
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 400;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: rgba(0, 0, 0, 0.08);
            border-color: rgba(0, 0, 0, 0.15);
            transform: translateX(-4px);
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
            width: 24px;
            height: 2px;
            background: var(--text-primary);
            border-radius: 2px;
            transition: all 0.3s ease;
        }

        /* Header Section */
        .header-section {
            padding: 120px 5% 80px;
            text-align: center;
            max-width: 1400px;
            margin: 0 auto;
            background: linear-gradient(135deg, rgba(79, 70, 229, 0.05) 0%, rgba(168, 85, 247, 0.05) 100%);
            position: relative;
        }

        .back-button {
            position: absolute;
            left: 5%;
            top: 40px;
            padding: 12px 24px;
            background: linear-gradient(135deg, var(--accent-light), #7c3aed);
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(79, 70, 229, 0.2);
            font-family: inherit;
        }

        .back-button:hover {
            transform: translateX(-4px);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.3);
        }

        .back-button:active {
            transform: translateX(-2px) scale(0.98);
        }

        .page-title {
            font-size: 4rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 16px;
            letter-spacing: -1px;
        }

        .page-subtitle {
            font-size: 18px;
            color: var(--text-secondary);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.8;
            font-weight: 300;
        }

        /* Main Content */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 5%;
        }

        .controls {
            display: flex;
            gap: 20px;
            margin-bottom: 48px;
            flex-wrap: wrap;
            align-items: center;
        }

        .search-container {
            position: relative;
            flex: 1;
            min-width: 250px;
        }

        .search-input {
            width: 100%;
            padding: 14px 20px 14px 48px;
            border: 2px solid var(--border);
            border-radius: 16px;
            background: linear-gradient(135deg, var(--bg-card), rgba(79, 70, 229, 0.02));
            font-size: 15px;
            font-family: inherit;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            color: var(--text-primary);
        }

        .search-input::placeholder {
            color: var(--text-secondary);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--accent-light);
            box-shadow: 0 8px 25px rgba(79, 70, 229, 0.15);
            background: linear-gradient(135deg, var(--bg-card), rgba(79, 70, 229, 0.05));
        }

        .search-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 18px;
        }

        .filter-buttons {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .filter-button {
            padding: 12px 28px;
            border: 2px solid var(--border);
            border-radius: 16px;
            background: linear-gradient(135deg, var(--bg-card), rgba(79, 70, 229, 0.02));
            color: var(--text-primary);
            font-weight: 600;
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            font-size: 14px;
            white-space: nowrap;
            letter-spacing: 0.3px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .filter-button:hover {
            border-color: var(--accent-light);
            background: linear-gradient(135deg, rgba(79, 70, 229, 0.08), rgba(79, 70, 229, 0.02));
            box-shadow: 0 8px 20px rgba(79, 70, 229, 0.12);
            transform: translateY(-2px);
        }

        .filter-button.active {
            background: linear-gradient(135deg, var(--accent-light), #7c3aed);
            color: white;
            border-color: var(--accent-light);
            box-shadow: 0 12px 30px rgba(79, 70, 229, 0.25);
        }

        .filter-button.active:hover {
            transform: translateY(-4px);
            box-shadow: 0 15px 40px rgba(79, 70, 229, 0.3);
        }

        /* Stats Bar */
        .stats-bar {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 20px;
            margin-bottom: 60px;
        }

        .stat-item {
            background: linear-gradient(135deg, var(--bg-card) 0%, rgba(255, 255, 255, 0.5) 100%);
            padding: 32px 24px;
            border-radius: 20px;
            border: 1px solid var(--border);
            box-shadow: var(--shadow-md);
            text-align: center;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
        }

        .stat-item::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(79, 70, 229, 0.1), transparent);
            transition: left 0.6s ease;
        }

        .stat-item:hover::before {
            left: 100%;
        }

        .stat-item:hover {
            border-color: var(--accent-light);
            box-shadow: var(--shadow-lg);
            transform: translateY(-8px);
        }

        .stat-number {
            font-size: 3rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--accent-light), #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: block;
            margin-bottom: 8px;
        }

        .stat-label {
            font-size: 15px;
            color: var(--text-secondary);
            font-weight: 500;
            letter-spacing: 0.5px;
        }

        /* Table Grid */
        .table-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 24px;
            margin-bottom: 60px;
        }

        .table-card {
            background: linear-gradient(135deg, var(--bg-card) 0%, rgba(79, 70, 229, 0.02) 100%);
            border: 2px solid var(--border);
            border-radius: 20px;
            padding: 32px;
            text-align: center;
            cursor: pointer;
            transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08), inset 0 1px 0 rgba(255, 255, 255, 0.6);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 240px;
            position: relative;
            overflow: hidden;
        }

        .table-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(79, 70, 229, 0.08), transparent);
            transition: left 0.6s ease;
            pointer-events: none;
        }

        .table-card:hover::before {
            left: 100%;
        }

        .table-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 25px 50px rgba(79, 70, 229, 0.15), inset 0 1px 0 rgba(255, 255, 255, 0.8);
            border-color: var(--accent-light);
        }

        .table-card.table-free {
            border-left: 4px solid #10B981;
        }

        .table-card.table-free:hover {
            background: rgba(16, 185, 129, 0.05);
        }

        .table-card.table-reserved {
            border-left: 4px solid #F59E0B;
            opacity: 0.7;
            cursor: not-allowed;
        }

        .table-card.table-reserved:hover {
            transform: none;
            box-shadow: var(--shadow-sm);
        }

        .table-card.table-in-use {
            border-left: 4px solid #EF4444;
            opacity: 0.7;
            cursor: not-allowed;
        }

        .table-card.table-in-use:hover {
            transform: none;
            box-shadow: var(--shadow-sm);
        }

        .table-number {
            font-size: 3.2rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--accent-light), #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 12px;
            display: block;
        }

        .table-capacity {
            font-size: 15px;
            color: var(--text-secondary);
            margin-bottom: 20px;
            font-weight: 500;
            letter-spacing: 0.3px;
        }

        .table-status {
            display: inline-block;
            padding: 10px 20px;
            border-radius: 50px;
            font-size: 13px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            backdrop-filter: blur(10px);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .table-card.table-free .table-status {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.25), rgba(16, 185, 129, 0.1));
            color: #047857;
            border: 1.5px solid rgba(16, 185, 129, 0.4);
            box-shadow: 0 4px 15px rgba(16, 185, 129, 0.2);
        }

        .table-card.table-free .table-status:hover {
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.3);
        }

        .table-card.table-reserved .table-status {
            background: linear-gradient(135deg, rgba(245, 158, 11, 0.25), rgba(245, 158, 11, 0.1));
            color: #92400e;
            border: 1.5px solid rgba(245, 158, 11, 0.4);
            box-shadow: 0 4px 15px rgba(245, 158, 11, 0.2);
        }

        .table-card.table-in-use .table-status {
            background: linear-gradient(135deg, rgba(239, 68, 68, 0.25), rgba(239, 68, 68, 0.1));
            color: #991b1b;
            border: 1.5px solid rgba(239, 68, 68, 0.4);
            box-shadow: 0 4px 15px rgba(239, 68, 68, 0.2);
        }

        /* Legend */
        .legend {
            background: linear-gradient(135deg, var(--bg-card) 0%, rgba(79, 70, 229, 0.02) 100%);
            border: 2px solid var(--border);
            border-radius: 20px;
            padding: 32px;
            margin-bottom: 60px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08), inset 0 1px 0 rgba(255, 255, 255, 0.6);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .legend:hover {
            box-shadow: 0 20px 40px rgba(79, 70, 229, 0.1), inset 0 1px 0 rgba(255, 255, 255, 0.8);
        }

        .legend h3 {
            font-size: 20px;
            font-weight: 700;
            background: linear-gradient(135deg, var(--accent-light), #7c3aed);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 24px;
            letter-spacing: 0.5px;
        }

        .legend-items {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 24px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 15px;
            color: var(--text-primary);
            padding: 12px;
            background: rgba(79, 70, 229, 0.02);
            border-radius: 12px;
            transition: all 0.3s ease;
        }

        .legend-item:hover {
            background: rgba(79, 70, 229, 0.05);
            transform: translateX(4px);
        }

        .legend-color {
            width: 24px;
            height: 6px;
            border-radius: 3px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .legend-free { background: #10B981; }
        .legend-reserved { background: #F59E0B; }
        .legend-in-use { background: #EF4444; }

        /* Footer */
        footer {
            background: var(--text-primary);
            color: white;
            padding: 60px 5% 40px;
            margin-top: 100px;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            text-align: center;
        }

        .footer-text {
            color: rgba(255, 255, 255, 0.7);
            font-size: 14px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            nav {
                padding: 16px 20px;
            }

            .back-button {
                position: static;
                margin-bottom: 20px;
                width: auto;
            }

            .page-title {
                font-size: 2.5rem;
            }

            .controls {
                flex-direction: column;
                align-items: stretch;
            }

            .search-container {
                min-width: auto;
            }

            .filter-buttons {
                justify-content: center;
            }

            .table-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
                gap: 16px;
            }

            .mobile-menu-btn {
                display: flex;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav>
        <div class="nav-container">
            <a href="#" class="logo">
                <span>🍲</span>
                <span>ShaBu</span>
            </a>
            
            <ul class="nav-menu">
                <li><a href="gotowelcomeCustomer">หน้าแรก</a></li>
                <li><a href="menurecomand">เมนู</a></li>
                <li><a href="listTable" class="active">จองโต๊ะ</a></li>
                <li><a href="gotoContact">ติดต่อเรา</a></li>
            </ul>
            
            <button class="mobile-menu-btn">
                <span></span>
                <span></span>
                <span></span>
            </button>
        </div>
    </nav>

    <!-- Header Section -->
    <section class="header-section">
        <div class="container">
            <button class="back-button" onclick="goBack()">
                <i class="fas fa-arrow-left"></i>
                ย้อนกลับ
            </button>
            <h1 class="page-title">จองโต๊ะ</h1>
            <p class="page-subtitle">
                เลือกโต๊ะที่คุณต้องการจองและทำการจองหรือดูรายละเอียดเพิ่มเติม
            </p>
        </div>
    </section>

    <!-- Main Content -->
    <div class="container">
        <!-- Stats -->
        <div class="stats-bar">
            <div class="stat-item">
                <span class="stat-number" id="totalTables">0</span>
                <span class="stat-label">โต๊ะทั้งหมด</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" id="availableTables">0</span>
                <span class="stat-label">ว่างพร้อมใช้</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" id="occupiedTables">0</span>
                <span class="stat-label">ใช้งานอยู่</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" id="reservedTables">0</span>
                <span class="stat-label">ถูกจองแล้ว</span>
            </div>
        </div>

        <!-- Controls -->
        <div class="controls">
            <div class="search-container">
                <i class="fas fa-search search-icon"></i>
                <input type="text" class="search-input" placeholder="ค้นหาโต๊ะ..." id="searchInput">
            </div>
            <div class="filter-buttons">
                <button class="filter-button active" onclick="filterTables('all')">ทั้งหมด</button>
                <button class="filter-button" onclick="filterTables('free')">ว่าง</button>
                <button class="filter-button" onclick="filterTables('in-use')">ใช้งาน</button>
                <button class="filter-button" onclick="filterTables('reserved')">จองแล้ว</button>
            </div>
        </div>

        <!-- Table Grid -->
        <div class="table-grid" id="tableGrid">
            <c:forEach items="${tables}" var="table">
                <div class="table-card 
                    <c:choose>
                        <c:when test='${table.status == "Free"}'>table-free</c:when>
                        <c:when test='${table.status == "Occupied"}'>table-in-use</c:when>
                        <c:when test='${table.status == "Already reserved"}'>table-reserved</c:when>
                        <c:otherwise>table-free</c:otherwise>
                    </c:choose>"
                    onclick="navigateToTable('${table.tableid}')"
                    data-status="${table.status}"
                    data-capacity="${table.capacity}">
                    
                    <div class="table-number">โต๊ะ ${table.tableid}</div>
                    <div class="table-capacity">${table.capacity} ที่นั่ง</div>
                    <div class="table-status">
                        <c:choose>
                            <c:when test='${table.status == "Free"}'> ว่าง</c:when>
                            <c:when test='${table.status == "Occupied"}'> ใช้งาน</c:when>
                            <c:when test='${table.status == "Already reserved"}'> จองแล้ว</c:when>
                            <c:otherwise>${table.status}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- Legend -->
        <div class="legend">
            <h3>คำอธิบายสถานะโต๊ะ</h3>
            <div class="legend-items">
                <div class="legend-item">
                    <div class="legend-color legend-free"></div>
                    <span>✅ ว่าง - พร้อมจอง</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color legend-in-use"></div>
                    <span>🔴 ใช้งาน - มีผู้ใช้งาน</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color legend-reserved"></div>
                    <span>⏳ จองแล้ว - ถูกจองโดยลูกค้าคนอื่น</span>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        <div class="footer-content">
            <p class="footer-text">&copy; 2024 ShaBu Restaurant. All rights reserved.</p>
        </div>
    </footer>

    <script>
        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            updateStats();
            initializeSearch();
        });

        // Go back to previous page
        function goBack() {
            window.history.back();
        }

        // Update statistics
        function updateStats() {
            const tables = document.querySelectorAll('.table-card');
            const total = tables.length;
            let available = 0, occupied = 0, reserved = 0;

            tables.forEach(table => {
                const status = table.getAttribute('data-status');
                if (status === 'Free') available++;
                else if (status === 'Occupied') occupied++;
                else if (status === 'Already reserved') reserved++;
            });

            document.getElementById('totalTables').textContent = total;
            document.getElementById('availableTables').textContent = available;
            document.getElementById('occupiedTables').textContent = occupied;
            document.getElementById('reservedTables').textContent = reserved;
        }

        // Filter tables
        function filterTables(filterType) {
            document.querySelectorAll('.filter-button').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');

            const tables = document.querySelectorAll('.table-card');
            tables.forEach(table => {
                const status = table.getAttribute('data-status');
                let show = true;

                if (filterType === 'free' && status !== 'Free') show = false;
                if (filterType === 'in-use' && status !== 'Occupied') show = false;
                if (filterType === 'reserved' && status !== 'Already reserved') show = false;

                table.style.display = show ? 'flex' : 'none';
            });
        }

        // Search functionality
        function initializeSearch() {
            const searchInput = document.getElementById('searchInput');
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                const tables = document.querySelectorAll('.table-card');
                
                tables.forEach(table => {
                    const tableNumber = table.querySelector('.table-number').textContent.toLowerCase();
                    const capacity = table.querySelector('.table-capacity').textContent.toLowerCase();
                    const status = table.querySelector('.table-status').textContent.toLowerCase();
                    
                    const matches = tableNumber.includes(searchTerm) || 
                                  capacity.includes(searchTerm) || 
                                  status.includes(searchTerm);
                    
                    table.style.display = matches ? 'flex' : 'none';
                });
            });
        }

        // Navigate to table
        function navigateToTable(tableId) {
            const card = event.target.closest('.table-card');
            const status = card.getAttribute('data-status');
            
            // Allow navigation only for Free tables
            if (status === 'Free') {
                window.location.href = 'getdetailTable?tableid=' + tableId;
            } else {
                alert('❌ โต๊ะนี้ไม่สามารถจองได้ เนื่องจากมีสถานะ: ' + status);
            }
        }
    </script>
</body>
</html>
        
       

    <script>

     // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            updateStats();
            initializeSearch();
        });

        // Update statistics
        function updateStats() {
            const tables = document.querySelectorAll('.table-card');
            const total = tables.length;
            let available = 0, occupied = 0, reserved = 0;

            tables.forEach(table => {
                const status = table.getAttribute('data-status');
                if (status === 'Free') available++;
                else if (status === 'In use') occupied++;
                else if (status === 'Already reserved') reserved++;
            });

            // Animate numbers
            animateNumber('totalTables', total);
            animateNumber('availableTables', available);
            animateNumber('occupiedTables', occupied);
            animateNumber('reservedTables', reserved);
        }

        // Animate number counting
        function animateNumber(elementId, targetNumber) {
            const element = document.getElementById(elementId);
            element.textContent = targetNumber;
        }

        // Filter tables
        function filterTables(filterType) {
            // Update active button
            document.querySelectorAll('.filter-button').forEach(btn => {
                btn.classList.remove('active');
            });
            event.target.classList.add('active');

            const tables = document.querySelectorAll('.table-card');
            tables.forEach(table => {
                const status = table.getAttribute('data-status');
                let show = true;

                if (filterType === 'free' && status !== 'Free') show = false;
                if (filterType === 'in-use' && status !== 'In use') show = false;
                if (filterType === 'reserved' && status !== 'Already reserved') show = false;

                table.style.display = show ? 'flex' : 'none';
            });
        }

        // Search functionality
        function initializeSearch() {
            const searchInput = document.getElementById('searchInput');
            searchInput.addEventListener('input', function() {
                const searchTerm = this.value.toLowerCase();
                const tables = document.querySelectorAll('.table-card');
                
                tables.forEach(table => {
                    const tableNumber = table.querySelector('.table-number').textContent.toLowerCase();
                    const capacity = table.querySelector('.table-capacity').textContent.toLowerCase();
                    const status = table.querySelector('.table-status').textContent.toLowerCase();
                    
                    const matches = tableNumber.includes(searchTerm) || 
                                  capacity.includes(searchTerm) || 
                                  status.includes(searchTerm);
                    
                    table.style.display = matches ? 'flex' : 'none';
                });
            });
        }

        // Navigate to table
        function navigateToTable(tableId) {
            const card = event.target.closest('.table-card');
            const status = card.getAttribute('data-status');
            
            // Allow navigation only for Free tables
            if (status === 'Free') {
                window.location.href = 'getdetailTable?tableid=' + tableId;
            } else {
                alert('❌ โต๊ะนี้ไม่สามารถจองได้ เนื่องจากมีโต๊ะถูกจองแล้วหรือมีผู้ใช้งานเเล้ว');
            }
        }
    </script>
</body>
</html>