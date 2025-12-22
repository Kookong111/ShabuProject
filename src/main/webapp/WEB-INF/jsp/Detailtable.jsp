<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Table Details | Premium UI</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&family=Kanit:wght@300;400;500&display=swap" rel="stylesheet">

<style>
    :root {
        --bg-body: #f0f2f5;
        --bg-card: #ffffff;
        --primary: #4f46e5; /* Indigo Modern */
        --primary-hover: #4338ca;
        --text-main: #1a202c;
        --text-muted: #718096;
        --border-color: #edf2f7;
        --status-free: #10b981;
        --status-busy: #ef4444;
        --status-warn: #f59e0b;
    }

    body {
        font-family: 'Plus Jakarta Sans', 'Kanit', sans-serif;
        margin: 0;
        padding: 0;
        background: var(--bg-body);
        min-height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .container {
        max-width: 440px;
        width: 90%;
        background: var(--bg-card);
        padding: 40px 30px;
        border-radius: 24px;
        box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.04), 0 8px 10px -6px rgba(0, 0, 0, 0.04);
        position: relative;
        border: 1px solid var(--border-color);
        transition: transform 0.3s ease;
    }

    @keyframes fadeIn {
        from {opacity: 0; transform: translateY(10px);}
        to {opacity: 1; transform: translateY(0);}
    }

    .container { animation: fadeIn 0.5s ease-out; }

    /* ปุ่ม Home สไตล์ Minimal */
    .home-button {
        position: absolute;
        top: 25px;
        left: 25px;
        color: var(--text-muted);
        text-decoration: none;
        font-weight: 500;
        font-size: 0.85rem;
        display: flex;
        align-items: center;
        gap: 6px;
        transition: color 0.2s;
    }

    .home-button:hover {
        color: var(--primary);
    }

    h1 {
        text-align: center;
        color: var(--text-main);
        font-weight: 700;
        margin: 20px 0 35px;
        font-size: 1.6rem;
        display: flex;
        flex-direction: column;
        align-items: center;
        gap: 10px;
    }
    
    h1 i {
        color: var(--primary);
        font-size: 1.8rem;
        opacity: 0.9;
    }

    .detail-item {
        margin-bottom: 24px;
    }

    .detail-item label {
        display: block;
        font-weight: 600;
        margin-bottom: 10px;
        color: var(--text-muted);
        font-size: 0.8rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
    }

    .detail-value {
        padding: 14px 18px;
        border-radius: 14px;
        background-color: #f9fafb;
        font-size: 1rem;
        color: var(--text-main);
        font-weight: 500;
        border: 1px solid var(--border-color);
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .detail-value i {
        color: var(--primary);
        width: 20px;
        text-align: center;
    }

    /* Status Badges */
    .status-badge {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 6px 14px;
        border-radius: 50px;
        font-size: 0.85rem;
        font-weight: 600;
    }

    .status-free { background: #ecfdf5; color: var(--status-free); }
    .status-in-use { background: #fef2f2; color: var(--status-busy); }
    .status-reserved { background: #fffbeb; color: var(--status-warn); }

    .reserve-button {
        background: var(--primary);
        color: #fff;
        padding: 16px;
        border: none;
        border-radius: 16px;
        cursor: pointer;
        font-size: 1rem;
        font-weight: 700;
        width: 100%;
        margin-top: 15px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 10px;
    }

    .reserve-button:hover:not(:disabled) {
        background: var(--primary-hover);
        box-shadow: 0 10px 15px -3px rgba(79, 70, 229, 0.3);
        transform: translateY(-2px);
    }

    .reserve-button:active:not(:disabled) {
        transform: translateY(0);
    }

    .disabled-button {
        background: #f3f4f6;
        color: #9ca3af;
        cursor: not-allowed;
    }

    @media (max-width: 480px) {
        .container {
            padding: 35px 20px;
            width: 85%;
        }
        h1 { font-size: 1.4rem; }
    }
</style>

</head>
<body>
    <div class="container">
        <a href="listTable" class="home-button"><i class="fas fa-arrow-left"></i> กลับ</a>
        
        <h1><i class="fas fa-couch"></i>Table Info</h1>

        <div class="detail-item">
            <label>หมายเลขโต๊ะ</label>
            <div class="detail-value">
                ${table.tableid}
            </div>
        </div>

        <div class="detail-item">
            <label> ความจุโต๊ะ</label>
            <div class="detail-value">
                ${table.capacity} คน
            </div>
        </div>

        <div class="detail-item">
            <label>สถานะ</label>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${table.status == 'Free'}">
                        <span class="status-badge status-free">ว่าง</span>
                    </c:when>
                    <c:when test="${table.status == 'In use'}">
                        <span class="status-badge status-in-use">จองแล้ว</span>
                    </c:when>
                    <c:when test="${table.status == 'Already reserved'}">
                        <span class="status-badge status-reserved">ไม่ว่าง</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-badge" style="background:#f3f4f6; color:var(--text-muted);">${table.status}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <c:choose>
            <c:when test="${table.status == 'Free'}">
                <form action="reserveTable">
                    <input type="hidden" name="tableid" value="${table.tableid}">
                    <button type="submit" class="reserve-button">
                        ยืนยัน
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <button type="button" class="reserve-button disabled-button" disabled>
                    Currently Unavailable
                </button>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        const btn = document.querySelector('.reserve-button:not(:disabled)');
        if(btn) {
            btn.addEventListener('click', () => {
                btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Processing...';
            });
        }
    </script>
</body>
</html>