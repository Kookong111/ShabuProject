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
        /* --- ใช้ CSS เดิมของคุณทั้งหมด --- */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        :root {
            --bg-primary: #f5f7fb; --bg-card: #ffffff; --text-primary: #0f172a;
            --text-secondary: #64748b; --accent: #1e293b; --accent-light: #4f46e5;
            --border: rgba(15, 23, 42, 0.1); --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
            --shadow-md: 0 4px 12px rgba(0, 0, 0, 0.08); --shadow-lg: 0 20px 40px rgba(0, 0, 0, 0.12);
            --success: #10b981; --warning: #f59e0b; --danger: #ef4444;
        }
        body { font-family: 'Kanit', sans-serif; background: linear-gradient(135deg, var(--bg-primary) 0%, #ffffff 100%); color: var(--text-primary); line-height: 1.6; overflow-x: hidden; min-height: 100vh; }
        nav { position: fixed; top: 0; left: 0; width: 100%; padding: 20px 5%; background: rgba(255, 255, 255, 0.95); backdrop-filter: blur(20px); border-bottom: 1px solid var(--border); z-index: 1000; transition: transform 0.3s ease; }
        .nav-container { display: flex; align-items: center; justify-content: center; max-width: 1400px; margin: 0 auto; flex-wrap: nowrap; gap: 0; }
        .header-section { padding: 120px 5% 60px; text-align: center; max-width: 1400px; margin: 0 auto; background: linear-gradient(135deg, rgba(79, 70, 229, 0.05) 0%, rgba(168, 85, 247, 0.05) 100%); position: relative; }
        .page-title { font-size: 4rem; font-weight: 700; color: var(--text-primary); margin-bottom: 16px; letter-spacing: -1px; }
        .page-subtitle { font-size: 18px; color: var(--text-secondary); max-width: 600px; margin: 0 auto; line-height: 1.8; font-weight: 300; }
        .container { max-width: 1400px; margin: 0 auto; padding: 0 5%; }
        
        /* Stats & Cards & Controls - CSS เดิม */
        .stats-bar { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px, 1fr)); gap: 20px; margin-bottom: 40px; }
        .stat-item { background: linear-gradient(135deg, var(--bg-card) 0%, rgba(255, 255, 255, 0.5) 100%); padding: 32px 24px; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-md); text-align: center; transition: all 0.4s; }
        .stat-number { font-size: 3rem; font-weight: 700; background: linear-gradient(135deg, var(--accent-light), #7c3aed); -webkit-background-clip: text; -webkit-text-fill-color: transparent; display: block; margin-bottom: 8px; }
        .stat-label { font-size: 15px; color: var(--text-secondary); font-weight: 500; }
        
        .controls { display: flex; gap: 20px; margin-bottom: 48px; flex-wrap: wrap; align-items: center; }
        .search-container { position: relative; flex: 1; min-width: 250px; }
        .search-input { width: 100%; padding: 14px 20px 14px 48px; border: 2px solid var(--border); border-radius: 16px; background: #fff; font-size: 15px; }
        .search-icon { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); }
        
        .filter-buttons { display: flex; gap: 12px; flex-wrap: wrap; }
        .filter-button { padding: 12px 28px; border: 2px solid var(--border); border-radius: 16px; background: #fff; color: var(--text-primary); font-weight: 600; cursor: pointer; transition: 0.3s; font-size: 14px; }
        .filter-button.active { background: linear-gradient(135deg, var(--accent-light), #7c3aed); color: white; border-color: var(--accent-light); }
        
        .table-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 24px; margin-bottom: 60px; }
        .table-card { background: #fff; border: 2px solid var(--border); border-radius: 20px; padding: 32px; text-align: center; cursor: pointer; transition: 0.5s; min-height: 240px; display: flex; flex-direction: column; justify-content: center; align-items: center; position: relative; overflow: hidden; }
        .table-card:hover { transform: translateY(-10px); border-color: var(--accent-light); }
        .table-card.table-free { border-left: 4px solid #10B981; }
        .table-card.table-reserved { border-left: 4px solid #F59E0B; opacity: 0.7; }
        .table-card.table-in-use { border-left: 4px solid #EF4444; opacity: 0.7; }
        .table-number { font-size: 3.2rem; font-weight: 700; background: linear-gradient(135deg, var(--accent-light), #7c3aed); -webkit-background-clip: text; -webkit-text-fill-color: transparent; margin-bottom: 12px; }
        .table-capacity { font-size: 15px; color: var(--text-secondary); margin-bottom: 20px; font-weight: 500; }
        .table-status { display: inline-block; padding: 10px 20px; border-radius: 50px; font-size: 13px; font-weight: 700; text-transform: uppercase; }
        
        .table-free .table-status { background: rgba(16, 185, 129, 0.25); color: #047857; }
        .table-reserved .table-status { background: rgba(245, 158, 11, 0.25); color: #92400e; }
        .table-in-use .table-status { background: rgba(239, 68, 68, 0.25); color: #991b1b; }
        
        .time-slots-section { margin-bottom: 40px; padding: 30px; background: #fff; border-radius: 20px; border: 1px solid var(--border); text-align: center; }
        .legend { background: #fff; border: 2px solid var(--border); border-radius: 20px; padding: 32px; margin-bottom: 60px; }
        footer { background: var(--text-primary); color: white; padding: 60px 5% 40px; margin-top: 100px; text-align: center; }
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
            <p class="page-subtitle">เช็คสถานะโต๊ะว่างแบบ Real-time ตามวันและเวลาที่คุณต้องการ</p>
        </div>
    </section>

    <div class="container">
        <div class="time-slots-section">
            <div style="margin-bottom: 30px;">
                <h3 style="margin-bottom: 15px; color: var(--text-primary);">
                    <i class="far fa-calendar-alt"></i> เลือกวันที่
                </h3>
                <div class="filter-buttons" style="justify-content: center;">
                    <button class="filter-button ${selectedDate != tomorrowDate ? 'active' : ''}" 
                            onclick="window.location.href='listTable?date=${selectedDate == tomorrowDate ? '' : selectedDate}&timeSlot=${currentTimeSlot}'">
                        วันนี้
                    </button>
                    <button class="filter-button ${selectedDate == tomorrowDate ? 'active' : ''}" 
                            onclick="window.location.href='listTable?date=${tomorrowDate}&timeSlot=${currentTimeSlot}'">
                        พรุ่งนี้
                    </button>
                </div>
            </div>

            <div>
                <h3 style="margin-bottom: 20px; color: var(--text-primary);">
                    <i class="far fa-clock"></i> เลือกรอบเวลาเข้าใช้บริการ
                </h3>
                <div class="filter-buttons" style="justify-content: center;">
                    <c:forEach items="09:00,11:00,13:00,15:00,17:00,19:00,21:00" var="slot">
                        <button class="filter-button ${currentTimeSlot == slot ? 'active' : ''}" 
                                onclick="window.location.href='listTable?date=${selectedDate}&timeSlot=${slot}'">
                            ${slot} น.
                        </button>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="stats-bar">
            <div class="stat-item">
                <span class="stat-number" id="totalTables">0</span>
                <span class="stat-label">โต๊ะทั้งหมด</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" id="availableTables" style="color: #10B981;">0</span>
                <span class="stat-label">ว่างในรอบนี้</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" id="reservedTables" style="color: #F59E0B;">0</span>
                <span class="stat-label">ติดจอง</span>
            </div>
            <div class="stat-item">
                <span class="stat-number" id="occupiedTables" style="color: #EF4444;">0</span>
                <span class="stat-label">มีการใช้งานอยู่</span>
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
                <button class="filter-button" onclick="filterTables('Reserved')">ไม่ว่าง</button>
            </div>
        </div>

        <div class="table-grid" id="tableGrid">
            <c:forEach items="${tables}" var="table">
                <c:set var="currentStatus" value="${statusMap[table.tableid]}" />
                <div class="table-card 
                    <c:choose>
                        <c:when test='${currentStatus == "Free"}'>table-free</c:when>
                        <c:when test='${currentStatus == "Occupied"}'>table-in-use</c:when>
                        <c:when test='${currentStatus == "Reserved"}'>table-reserved</c:when>
                        <c:otherwise>table-free</c:otherwise>
                    </c:choose>"
                    onclick="navigateToTable('${table.tableid}', '${currentStatus}')"
                    data-status="${currentStatus}">
                    
                    <div class="table-number">โต๊ะ ${table.tableid}</div>
                    <div class="table-capacity"><i class="fas fa-users"></i> ${table.capacity} ที่นั่ง</div>
                    <div class="table-status">
                        <c:choose>
                            <c:when test='${currentStatus == "Free"}'>ว่าง</c:when>
                            <c:when test='${currentStatus == "Occupied"}'>ใช้งานอยู่</c:when>
                            <c:when test='${currentStatus == "Reserved"}'>ติดจอง</c:when>
                            <c:otherwise>${currentStatus}</c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div class="legend">
            <h3 style="margin-bottom: 24px;"><i class="fas fa-info-circle"></i> ข้อมูลสถานะโต๊ะ</h3>
            <div style="display: flex; gap: 30px; flex-wrap: wrap;">
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width: 30px; height: 5px; background: #10B981; border-radius: 3px;"></div>
                    <span><b>ว่าง:</b> พร้อมให้บริการในรอบนี้</span>
                </div>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width: 30px; height: 5px; background: #F59E0B; border-radius: 3px;"></div>
                    <span><b>ติดจอง:</b> มีคิวจอง/Buffer 2 ชม.</span>
                </div>
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width: 30px; height: 5px; background: #EF4444; border-radius: 3px;"></div>
                    <span><b>ใช้งานอยู่:</b> มีลูกค้ากำลังนั่งโต๊ะ</span>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>&copy; 2026 ShaBu Restaurant. All rights reserved.</p>
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            updateStats();
            initializeSearch();
            setInterval(() => window.location.reload(), 60000);
        });

        function updateStats() {
            const tables = document.querySelectorAll('.table-card');
            let f = 0, o = 0, r = 0;
            tables.forEach(t => {
                const s = t.getAttribute('data-status');
                if (s === 'Free') f++;
                else if (s === 'Occupied') o++;
                else if (s === 'Reserved') r++;
            });
            document.getElementById('totalTables').textContent = tables.length;
            document.getElementById('availableTables').textContent = f;
            document.getElementById('occupiedTables').textContent = o;
            document.getElementById('reservedTables').textContent = r;
        }

        function filterTables(type) {
            document.querySelectorAll('.filter-button').forEach(b => b.classList.remove('active'));
            event.currentTarget.classList.add('active');
            document.querySelectorAll('.table-card').forEach(t => {
                const s = t.getAttribute('data-status');
                t.style.display = (type === 'all' || s === type) ? 'flex' : 'none';
            });
        }

        function initializeSearch() {
            document.getElementById('searchInput').addEventListener('input', function() {
                const term = this.value.toLowerCase();
                document.querySelectorAll('.table-card').forEach(t => {
                    t.style.display = t.innerText.toLowerCase().includes(term) ? 'flex' : 'none';
                });
            });
        }

        function navigateToTable(id, status) {
            const time = '${currentTimeSlot}';
            const date = '${selectedDate}';
            if (status === 'Free') {
                window.location.href = 'getdetailTable?tableid=' + id + '&time=' + time + '&date=' + date;
            } else {
                alert('❌ โต๊ะ ' + id + ' ไม่ว่างสำหรับวันที่ ' + date + ' เวลา ' + time + ' น.');
            }
        }
    </script>
</body>
</html>