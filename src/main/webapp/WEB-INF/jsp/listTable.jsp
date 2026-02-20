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
        /* --- CSS ส่วนเดิมของคุณ (คงไว้ทั้งหมด) --- */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --bg-primary: #f5f7fb; --bg-card: #ffffff; --text-primary: #0f172a;
            --text-secondary: #64748b; --accent: #1e293b; --accent-light: #4f46e5;
            --border: rgba(15, 23, 42, 0.1); --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.08); --shadow-lg: 0 20px 40px rgba(0, 0, 0, 0.12);
            --success: #10b981; --warning: #f59e0b; --danger: #ef4444;
        }
        body { font-family: 'Kanit', sans-serif; background: linear-gradient(135deg, var(--bg-primary) 0%, #ffffff 100%); color: var(--text-primary); min-height: 100vh; }
        nav { position: fixed; top: 0; left: 0; width: 100%; padding: 20px 5%; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); border-bottom: 1px solid var(--border); z-index: 1000; }
        .nav-container { display: flex; align-items: center; justify-content: center; max-width: 1400px; margin: 0 auto; }
        .header-section { padding: 120px 5% 80px; text-align: center; max-width: 1400px; margin: 0 auto; background: linear-gradient(135deg, rgba(79, 70, 229, 0.05) 0%, rgba(168, 85, 247, 0.05) 100%); }
        .page-title { font-size: 4rem; font-weight: 700; margin-bottom: 16px; letter-spacing: -1px; }
        .page-subtitle { font-size: 18px; color: var(--text-secondary); max-width: 600px; margin: 0 auto; font-weight: 300; }
        .container { max-width: 1400px; margin: 0 auto; padding: 0 5%; }
        .stats-bar { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 20px; margin-bottom: 60px; }
        .stat-item { background: #fff; padding: 32px 24px; border-radius: 20px; border: 1px solid var(--border); text-align: center; transition: 0.4s; }
        .stat-number { font-size: 3rem; font-weight: 700; background: linear-gradient(135deg, var(--accent-light), #7c3aed); -webkit-background-clip: text; -webkit-text-fill-color: transparent; }
        .controls { display: flex; gap: 20px; margin-bottom: 48px; flex-wrap: wrap; }
        .search-container { position: relative; flex: 1; }
        .search-input { width: 100%; padding: 14px 48px; border: 2px solid var(--border); border-radius: 16px; }
        .search-icon { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); }
        .filter-buttons { display: flex; gap: 12px; }
        .filter-button { padding: 12px 28px; border: 2px solid var(--border); border-radius: 16px; cursor: pointer; font-weight: 600; }
        .filter-button.active { background: var(--accent-light); color: white; border-color: var(--accent-light); }
        
        /* Table Cards Style */
        .table-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 24px; }
        .table-card { background: #fff; border: 2px solid var(--border); border-radius: 20px; padding: 32px; text-align: center; cursor: pointer; transition: 0.5s; min-height: 240px; display: flex; flex-direction: column; justify-content: center; align-items: center; }
        .table-card:hover { transform: translateY(-10px); border-color: var(--accent-light); }
        .table-card.table-free { border-left: 5px solid var(--success); }
        .table-card.table-reserved { border-left: 5px solid var(--warning); opacity: 0.85; }
        .table-card.table-in-use { border-left: 5px solid var(--danger); opacity: 0.85; }
        .table-number { font-size: 2.5rem; font-weight: 700; margin-bottom: 8px; color: var(--text-primary); }
        .table-status { padding: 8px 16px; border-radius: 50px; font-size: 13px; font-weight: 700; margin-top: 15px; }
        
        .table-free .table-status { background: rgba(16, 185, 129, 0.1); color: var(--success); }
        .table-reserved .table-status { background: rgba(245, 158, 11, 0.1); color: var(--warning); }
        .table-in-use .table-status { background: rgba(239, 68, 68, 0.1); color: var(--danger); }
        
        .legend { background: #fff; padding: 30px; border-radius: 20px; border: 1px solid var(--border); margin-top: 50px; }
        footer { background: var(--text-primary); color: white; padding: 40px; text-align: center; margin-top: 50px; }
    </style>
</head>
<body>
    <nav>
        <div class="nav-container">
            <%@ include file="/WEB-INF/jsp/include/navbar.jsp" %>
        </div>
    </nav>

    <section class="header-section">
        <div class="container">
            <h1 class="page-title">จองโต๊ะ</h1>
            <p class="page-subtitle">เลือกโต๊ะที่ว่างเพื่อทำการจองในเวลาที่คุณต้องการ</p>
        </div>
    </section>

    <div class="container">
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
                <span class="stat-label">จองแล้ว (ใกล้เวลา)</span>
            </div>
        </div>

        <div class="controls">
            <div class="search-container">
                <i class="fas fa-search search-icon"></i>
                <input type="text" class="search-input" placeholder="ค้นหาโต๊ะ..." id="searchInput">
            </div>
            <div class="filter-buttons">
                <button class="filter-button active" onclick="filterTables('all')">ทั้งหมด</button>
                <button class="filter-button" onclick="filterTables('Free')">ว่าง</button>
                <button class="filter-button" onclick="filterTables('Occupied')">ใช้งาน</button>
                <button class="filter-button" onclick="filterTables('Reserved')">จองแล้ว</button>
            </div>
        </div>

        <div class="table-grid" id="tableGrid">
            <c:forEach items="${tables}" var="table">
                <%-- ✅ ดึงสถานะที่คำนวณจาก TimeZone และ Buffer Time ใน Controller --%>
                <c:set var="currentStatus" value="${statusMap[table.tableid]}" />
                
                <div class="table-card 
                    <c:choose>
                        <c:when test='${currentStatus == "Free"}'>table-free</c:when>
                        <c:when test='${currentStatus == "Occupied"}'>table-in-use</c:when>
                        <c:when test='${currentStatus == "Reserved"}'>table-reserved</c:when>
                        <c:otherwise>table-free</c:otherwise>
                    </c:choose>"
                    onclick="navigateToTable('${table.tableid}')"
                    data-status="${currentStatus}"
                    data-capacity="${table.capacity}">
                    
                    <div class="table-number">โต๊ะ ${table.tableid}</div>
                    <div class="table-capacity"><i class="fas fa-users"></i> ${table.capacity} ที่นั่ง</div>
                    <div class="table-status">
                        <c:choose>
                            <c:when test='${currentStatus == "Free"}'><i class="fas fa-check-circle"></i> ว่าง</c:when>
                            <c:when test='${currentStatus == "Occupied"}'><i class="fas fa-utensils"></i> ใช้งานอยู่</c:when>
                            <c:when test='${currentStatus == "Reserved"}'><i class="fas fa-clock"></i> จองแล้ว</c:when>
                            <c:otherwise>${currentStatus}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="legend">
            <h3><i class="fas fa-info-circle"></i> คำอธิบายสถานะโต๊ะ</h3>
            <div class="legend-items">
                <div class="legend-item">
                    <div class="legend-color legend-free"></div>
                    <span><b>ว่าง:</b> สามารถจองหรือใช้งานได้ทันที</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color legend-in-use"></div>
                    <span><b>ใช้งาน:</b> มีลูกค้ากำลังใช้บริการ</span>
                </div>
                <div class="legend-item">
                    <div class="legend-color legend-reserved"></div>
                    <span><b>จองแล้ว:</b> มีคิวจองภายใน 60 นาทีนี้</span>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 ShaBu Restaurant. เวลาประเทศไทย (GMT+7)</p>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            updateStats();
            initializeSearch();
        });

        function updateStats() {
            const tables = document.querySelectorAll('.table-card');
            let free = 0, occupied = 0, reserved = 0;

            tables.forEach(table => {
                const status = table.getAttribute('data-status');
                if (status === 'Free') free++;
                else if (status === 'Occupied') occupied++;
                else if (status === 'Reserved') reserved++;
            });

            document.getElementById('totalTables').textContent = tables.length;
            document.getElementById('availableTables').textContent = free;
            document.getElementById('occupiedTables').textContent = occupied;
            document.getElementById('reservedTables').textContent = reserved;
        }

        function filterTables(filterType) {
            document.querySelectorAll('.filter-button').forEach(btn => btn.classList.remove('active'));
            event.currentTarget.classList.add('active');

            const tables = document.querySelectorAll('.table-card');
            tables.forEach(table => {
                const status = table.getAttribute('data-status');
                table.style.display = (filterType === 'all' || status === filterType) ? 'flex' : 'none';
            });
        }

        function initializeSearch() {
            const searchInput = document.getElementById('searchInput');
            searchInput.addEventListener('input', function() {
                const term = this.value.toLowerCase();
                document.querySelectorAll('.table-card').forEach(table => {
                    const text = table.innerText.toLowerCase();
                    table.style.display = text.includes(term) ? 'flex' : 'none';
                });
            });
        }

        function navigateToTable(tableId) {
            const card = event.currentTarget;
            const status = card.getAttribute('data-status');
            
            if (status === 'Free') {
                window.location.href = 'getdetailTable?tableid=' + tableId;
            } else {
                const msg = status === 'Occupied' ? 'มีลูกค้ากำลังใช้งาน' : 'มีลูกค้าจองไว้ใกล้ถึงเวลาแล้ว';
                alert('❌ ไม่สามารถจองโต๊ะ ' + tableId + ' ได้ในขณะนี้เนื่องจาก' + msg);
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            // รีเฟรชหน้าจอทุกๆ 1 นาที (60,000 มิลลิวินาที)
            setInterval(function() {
                console.log("กำลังอัปเดตสถานะโต๊ะอัตโนมัติ...");
                window.location.reload(); 
            }, 60000); 
        });
    </script>
</body>
</html>