<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Restaurant Table Management</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        :root {
            --primary-purple: #8B5CF6;
            --secondary-purple: #A78BFA;
            --light-purple: #E9D5FF;
            --dark-purple: #6B46C1;
            --white: #FFFFFF;
            --light-gray: #F8FAFC;
            --medium-gray: #E2E8F0;
            --dark-gray: #64748B;
            --success: #10B981;
            --warning: #F59E0B;
            --error: #EF4444;
            --shadow-light: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            --shadow-medium: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            --shadow-heavy: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            background-attachment: fixed;
            min-height: 100vh;
            padding: 20px;
            position: relative;
        }



        .container {
            position: relative;
            z-index: 1;
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            color: var(--dark-purple);
            text-align: center;
            box-shadow: var(--shadow-medium);
            border: 1px solid rgba(255, 255, 255, 0.5);
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 8px;
            color: var(--dark-purple);
        }

        .header p {
            font-size: 1.1rem;
            opacity: 0.9;
            font-weight: 300;
        }

        .main-content {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 32px;
            box-shadow: var(--shadow-medium);
            border: 1px solid rgba(255, 255, 255, 0.5);
        }

        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 32px;
            padding-bottom: 16px;
            border-bottom: 2px solid var(--light-purple);
        }

        .section-title {
            color: var(--dark-purple);
            font-size: 2rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title::before {
            content: '🍽️';
            font-size: 2.5rem;
        }

        .stats-bar {
            display: flex;
            gap: 20px;
        }

        .stat-item {
            text-align: center;
            padding: 12px 20px;
            background: linear-gradient(135deg, var(--primary-purple), var(--secondary-purple));
            border-radius: 12px;
            color: white;
            box-shadow: var(--shadow-light);
            min-width: 80px;
        }

        .stat-number {
            font-size: 1.5rem;
            font-weight: 700;
            display: block;
        }

        .stat-label {
            font-size: 0.75rem;
            opacity: 0.9;
            font-weight: 400;
        }

        .controls {
            margin-bottom: 32px;
            display: flex;
            gap: 20px;
            align-items: center;
            flex-wrap: wrap;
        }

        .search-container {
            position: relative;
            flex: 1;
            min-width: 300px;
        }

        .search-input {
            width: 100%;
            padding: 16px 24px 16px 52px;
            border: 2px solid var(--medium-gray);
            border-radius: 50px;
            background: var(--white);
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-light);
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-purple);
            box-shadow: 0 0 0 3px rgba(139, 92, 246, 0.1);
        }

        .search-icon {
            position: absolute;
            left: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--dark-gray);
            font-size: 1.2rem;
        }

        .filter-buttons {
            display: flex;
            gap: 12px;
        }

        .filter-button {
            padding: 12px 24px;
            border: 2px solid var(--medium-gray);
            border-radius: 50px;
            background: var(--white);
            color: var(--dark-gray);
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            white-space: nowrap;
        }

        .filter-button:hover {
            border-color: var(--primary-purple);
            color: var(--primary-purple);
        }

        .filter-button.active {
            background: linear-gradient(135deg, var(--primary-purple), var(--secondary-purple));
            color: white;
            border-color: transparent;
            box-shadow: var(--shadow-medium);
        }

        .table-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 24px;
            margin-top: 32px;
        }

        .table-card {
            aspect-ratio: 1;
            border-radius: 16px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: var(--shadow-light);
            position: relative;
            overflow: hidden;
        }

        .table-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-medium);
        }

        .table-free {
            background: linear-gradient(135deg, #10B981, #34D399);
        }

        .table-in-use {
            background: linear-gradient(135deg, #EF4444, #F87171);
        }

        .table-reserved {
            background: linear-gradient(135deg, #F59E0B, #FBBF24);
        }

        .table-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 8px;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        }

        .table-capacity {
            font-size: 1rem;
            opacity: 0.9;
            font-weight: 500;
            margin-bottom: 8px;
        }

        .table-status {
            font-size: 0.8rem;
            font-weight: 600;
            padding: 6px 12px;
            border-radius: 20px;
            background: rgba(255, 255, 255, 0.25);
            backdrop-filter: blur(10px);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .legend {
            position: fixed;
            bottom: 24px;
            right: 24px;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 12px;
            padding: 16px;
            box-shadow: var(--shadow-medium);
            border: 1px solid rgba(255, 255, 255, 0.5);
            min-width: 180px;
        }

        .legend h3 {
            color: var(--dark-purple);
            margin-bottom: 16px;
            font-weight: 600;
            font-size: 1.1rem;
        }

        .legend-item {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
            font-size: 0.9rem;
            color: var(--dark-gray);
        }

        .legend-color {
            width: 16px;
            height: 16px;
            border-radius: 50%;
            margin-right: 12px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        .legend-free { background: linear-gradient(135deg, #10B981, #34D399); }
        .legend-in-use { background: linear-gradient(135deg, #EF4444, #F87171); }
        .legend-reserved { background: linear-gradient(135deg, #F59E0B, #FBBF24); }

        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
            opacity: 0;
            visibility: hidden;
            transition: all 0.3s ease;
        }

        .loading-overlay.show {
            opacity: 1;
            visibility: visible;
        }

        .spinner {
            width: 50px;
            height: 50px;
            border: 4px solid var(--light-purple);
            border-top: 4px solid var(--primary-purple);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @media (max-width: 768px) {
            .header {
                padding: 24px;
                margin-bottom: 24px;
            }
            
            .header h1 {
                font-size: 2rem;
            }
            
            .main-content {
                padding: 24px;
            }
            
            .section-header {
                flex-direction: column;
                gap: 16px;
                align-items: flex-start;
            }
            
            .stats-bar {
                width: 100%;
                justify-content: space-around;
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
                flex-wrap: wrap;
            }
            
            .table-grid {
                grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
                gap: 16px;
            }
            
            .legend {
                position: relative;
                bottom: auto;
                right: auto;
                margin-top: 24px;
            }
        }
        .home-button {
    position: absolute;
    top: 20px;
    left: 20px;
    background: linear-gradient(135deg, var(--primary-purple), var(--secondary-purple));
    color: white;
    text-decoration: none;
    font-weight: 500;
    padding: 10px 18px;
    border-radius: 50px;
    box-shadow: var(--shadow-light);
    transition: all 0.3s ease;
}

.home-button:hover {
    background: linear-gradient(135deg, var(--dark-purple), var(--primary-purple));
    box-shadow: var(--shadow-medium);
}
        
    </style>
</head>
<body>
    <div class="loading-overlay" id="loadingOverlay">
        <div class="spinner"></div>
    </div>

    <div class="container">
        <div class="header">
        <a href="gotowelcomeCustomer" class="home-button">🏠 Home</a>
            <h1>Restaurant Table Management</h1>
            
        </div>

        <div class="main-content">
            <div class="section-header">
                <h2 class="section-title">Table Overview</h2>
                <div class="stats-bar">
                    <div class="stat-item">
                        <span class="stat-number" id="totalTables">0</span>
                        <span class="stat-label">Total</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number" id="availableTables">0</span>
                        <span class="stat-label">Available</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number" id="occupiedTables">0</span>
                        <span class="stat-label">Occupied</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number" id="reservedTables">0</span>
                        <span class="stat-label">Reserved</span>
                    </div>
                </div>
            </div>

            <div class="controls">
                <div class="search-container">
                    <span class="search-icon">🔍</span>
                    <input type="text" class="search-input" placeholder="Search tables..." id="searchInput">
                </div>
                <div class="filter-buttons">
                    <button class="filter-button active" onclick="filterTables('all')">All Tables</button>
                    <button class="filter-button" onclick="filterTables('free')">Available</button>
                    <button class="filter-button" onclick="filterTables('in-use')">Occupied</button>
                    <button class="filter-button" onclick="filterTables('reserved')">Reserved</button>
                </div>
            </div>
            
            <div class="table-grid" id="tableGrid">
                <c:forEach items="${tables}" var="table">
                    <div class="table-card 
                        <c:choose>
                            <c:when test='${table.status == "Free"}'>table-free</c:when>
                            <c:when test='${table.status == "In use"}'>table-in-use</c:when>
                            <c:when test='${table.status == "Already reserved"}'>table-reserved</c:when>
                            <c:otherwise>table-free</c:otherwise>
                        </c:choose>"
                        onclick="navigateToTable('${table.tableid}')"
                        data-status="${table.status}"
                        data-capacity="${table.capacity}">
                        
                        <div class="table-number">T${table.tableid}</div>
                        <div class="table-capacity">${table.capacity} capacity</div>
                        <div class="table-status">
                            <c:choose>
                                <c:when test='${table.status == "Free"}'>Available</c:when>
                                <c:when test='${table.status == "In use"}'>Occupied</c:when>
                                <c:when test='${table.status == "Already reserved"}'>Reserved</c:when>
                                <c:otherwise>${table.status}</c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="legend">
            <h3>Status Legend</h3>
            <div class="legend-item">
                <div class="legend-color legend-free"></div>
                Available
            </div>
            <div class="legend-item">
                <div class="legend-color legend-in-use"></div>
                Occupied
            </div>
            <div class="legend-item">
                <div class="legend-color legend-reserved"></div>
                Reserved
            </div>
        </div>
    </div>

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
            window.location.href = 'getdetailTable?tableid=' + tableId;
        }
    </script>
</body>
</html>