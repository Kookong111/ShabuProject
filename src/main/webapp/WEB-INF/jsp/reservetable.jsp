<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>จองโต๊ะ - Restaurant</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@300;400;500;600&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #4f46e5;
            --primary-light: #eef2ff;
            --secondary: #64748b;
            --text-dark: #1e293b;
            --text-light: #64748b;
            --bg-gray: #f8fafc;
            --white: #ffffff;
            --border: #e2e8f0;
            --success: #10b981;
            --error: #ef4444;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Kanit', sans-serif;
            background-color: #f1f5f9;
            color: var(--text-dark);
            line-height: 1.6;
            padding: 40px 20px;
        }

        .container {
            max-width: 650px;
            margin: 0 auto;
            background: var(--white);
            border-radius: 24px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
            overflow: hidden;
            border: 1px solid var(--border);
        }

        .header {
            padding: 40px 40px 20px;
            text-align: center;
        }

        .header h1 { font-size: 1.8rem; margin-bottom: 8px; font-weight: 600; }
        .header p { color: var(--text-light); font-weight: 300; }

        .content { padding: 0 40px 40px; }

        .info-card {
            background: var(--bg-gray);
            padding: 24px;
            border-radius: 16px;
            margin-bottom: 24px;
            border: 1px solid var(--border);
        }

        .info-card h3 {
            font-size: 1rem;
            color: var(--primary);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 12px;
        }

        .info-item span {
            color: var(--text-light);
            display: block;
            font-size: 0.75rem;
            text-transform: uppercase;
        }

        .table-info { margin-bottom: 30px; }
        .table-info h2 { font-size: 1.1rem; margin-bottom: 16px; font-weight: 500; }

        .table-details {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 16px;
        }

        .detail-item {
            padding: 16px;
            background: var(--white);
            border-radius: 16px;
            border: 1px solid var(--border);
            text-align: center;
        }

        .detail-item .label { font-size: 0.75rem; color: var(--text-light); margin-bottom: 4px; }
        .detail-item .value { font-size: 1.1rem; font-weight: 600; }

        .status-free { color: var(--success); }

        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; font-size: 0.9rem; }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px 16px;
            border: 1px solid var(--border);
            border-radius: 12px;
            font-family: 'Kanit', sans-serif;
            font-size: 1rem;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px var(--primary-light);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .btn-group { display: flex; gap: 12px; margin-top: 30px; }
        .btn {
            flex: 1;
            padding: 14px;
            border-radius: 14px;
            font-family: 'Kanit', sans-serif;
            font-weight: 500;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-primary { background: var(--primary); color: var(--white); border: none; }
        .btn-primary:hover { background: #4338ca; transform: translateY(-2px); }

        .btn-secondary { background: var(--white); color: var(--text-dark); border: 1px solid var(--border); }
        .btn-secondary:hover { background: var(--bg-gray); }

        .alert-error {
            background: #fef2f2; color: var(--error); border: 1px solid #fee2e2;
            padding: 16px; border-radius: 12px; margin-bottom: 24px; font-size: 0.9rem;
        }

        @media (max-width: 600px) {
            .form-row, .table-details { grid-template-columns: 1fr; }
            .btn-group { flex-direction: column; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>จองโต๊ะอาหาร</h1>
            <p>กรุณาเลือกวันและเวลาที่ท่านสะดวก</p>
        </div>

        <div class="content">
            <c:if test="${not empty error}">
                <div class="alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <div class="info-card">
                <h3><i class="fas fa-user-circle"></i> ข้อมูลผู้ติดต่อ</h3>
                <div class="info-grid">
                    <div class="info-item"><span>ชื่อผู้จอง</span>${user.cusname}</div>
                    <div class="info-item"><span>เบอร์โทรศัพท์</span>${user.phonenumber}</div>
                </div>
            </div>

            <div class="table-info">
                <h2>โต๊ะที่ท่านเลือก</h2>
                <div class="table-details">
                    <div class="detail-item">
                        <div class="label">หมายเลขโต๊ะ</div>
                        <div class="value">${selectedTable.tableid}</div>
                    </div>
                    <div class="detail-item">
                        <div class="label">จำนวนที่นั่ง</div>
                        <div class="value">${selectedTable.capacity} ท่าน</div>
                    </div>
                    <div class="detail-item">
                        <div class="label">สถานะ</div>
                        <div class="value status-free">พร้อมใช้งาน</div>
                    </div>
                </div>
            </div>

            <form action="confirmReservation" method="post">
                <input type="hidden" name="tableid" value="${selectedTable.tableid}">
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="reservationDate">วันที่จอง (จองล่วงหน้าได้ 1 วัน)</label>
                        <input type="date" id="reservationDate" name="reservationDate" required>
                    </div>
                    <div class="form-group">
                        <label for="reservationTime">เวลาจอง</label>
                        <select id="reservationTime" name="reservationTime" required>
                            <option value="">เลือกเวลา</option>
                            <option value="11:00">11:00</option>
                            <option value="13:00">13:00</option>
                            <option value="15:00">15:00</option>
                            <option value="17:00">17:00</option>
                            <option value="19:00">19:00</option>
                            <option value="21:00">21:00</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="numberOfGuests">จำนวนผู้เข้าใช้บริการ</label>
                    <select id="numberOfGuests" name="numberOfGuests" required>
                        <option value="">ระบุจำนวนคน</option>
                        <c:forEach begin="1" end="${selectedTable.capacity}" var="i">
                            <option value="${i}">${i} ท่าน</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">ยืนยันการจอง</button>
                    <a href="listTable" class="btn btn-secondary">ยกเลิก</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const dateInput = document.getElementById('reservationDate');
            const timeSelect = document.getElementById('reservationTime');
            const now = new Date();

            // --- 1. ตั้งค่าวันที่: วันนี้ และ วันพรุ่งนี้ เท่านั้น ---
            const todayStr = now.toISOString().split('T')[0];
            const tomorrow = new Date();
            tomorrow.setDate(now.getDate() + 1);
            const tomorrowStr = tomorrow.toISOString().split('T')[0];

            dateInput.min = todayStr;
            dateInput.max = tomorrowStr;
            dateInput.value = todayStr;

            // --- 2. ฟังก์ชันตรวจสอบเวลา (ป้องกันการจองย้อนหลังสำหรับวันนี้) ---
            function updateAvailableTimes() {
                const selectedDate = dateInput.value;
                const currentHour = now.getHours();
                const currentMinute = now.getMinutes();

                for (let i = 0; i < timeSelect.options.length; i++) {
                    const option = timeSelect.options[i];
                    if (!option.value) continue;

                    const [optHour, optMinute] = option.value.split(':').map(Number);
                    
                    if (selectedDate === todayStr) {
                        // ปิดเวลาที่เท่ากับหรือน้อยกว่าเวลาปัจจุบัน
                        if (optHour < currentHour || (optHour === currentHour && optMinute <= currentMinute)) {
                            option.disabled = true;
                            option.style.backgroundColor = "#f1f5f9";
                            option.style.color = "#cbd5e1";
                        } else {
                            option.disabled = false;
                            option.style.backgroundColor = "";
                            option.style.color = "";
                        }
                    } else {
                        // วันพรุ่งนี้เปิดทุกเวลา
                        option.disabled = false;
                        option.style.backgroundColor = "";
                        option.style.color = "";
                    }
                }
                
                // หากตัวเลือกที่เลือกอยู่ถูก Disable ให้รีเซ็ตค่า
                if (timeSelect.selectedOptions[0] && timeSelect.selectedOptions[0].disabled) {
                    timeSelect.value = "";
                }
            }

            updateAvailableTimes();
            dateInput.addEventListener('change', updateAvailableTimes);

            // --- 3. Animation ตอนโหลด ---
            const container = document.querySelector('.container');
            container.style.opacity = '0';
            container.style.transform = 'translateY(15px)';
            container.style.transition = 'all 0.5s ease-out';
            setTimeout(() => {
                container.style.opacity = '1';
                container.style.transform = 'translateY(0)';
            }, 100);
        });
    </script>
</body>
</html>