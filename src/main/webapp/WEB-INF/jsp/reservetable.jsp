<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>จองโต๊ะ - Restaurant</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f8f6ff 0%, #f0ebff 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            background: #ffffff;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(139, 69, 255, 0.1);
            border: 1px solid #e9ecef;
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #8b45ff, #6c35cc);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .header h1 {
            font-size: 2.5em;
            margin-bottom: 10px;
            font-weight: 300;
        }

        .header p {
            font-size: 1.1em;
            opacity: 0.9;
        }

        .content {
            padding: 40px;
        }

        .table-info {
            background: #faf8ff;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            text-align: center;
            border: 1px solid #e9d5ff;
        }

        .table-info h2 {
            color: #6c35cc;
            margin-bottom: 15px;
            font-size: 1.8em;
        }

        .table-details {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }

        .detail-item {
            text-align: center;
        }

        .detail-item .label {
            font-size: 0.9em;
            color: #666;
            margin-bottom: 5px;
        }

        .detail-item .value {
            font-size: 1.3em;
            font-weight: bold;
            color: #333;
        }

        /* Status styles */
        .status-free { color: #059669; }
        .status-in-use { color: #6b7280; }
        .status-reserved { color: #d97706; }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 1.1em;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 15px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            font-size: 1em;
            transition: all 0.3s ease;
            background: white;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #8b45ff;
            box-shadow: 0 0 8px rgba(139, 69, 255, 0.2);
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
        }

        .form-row {
            display: flex;
            gap: 20px;
        }

        .form-row .form-group {
            flex: 1;
        }

        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: center;
            margin-top: 30px;
        }

        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            font-weight: 600;
            font-size: 1.1em;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        .btn-primary {
            background: #8b45ff;
            color: white;
        }

        .btn-primary:hover {
            background: #6c35cc;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(139, 69, 255, 0.3);
        }

        .btn-secondary {
            background: #6b7280;
            color: white;
        }

        .btn-secondary:hover {
            background: #4b5563;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(75, 85, 99, 0.3);
        }

        .alert {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 600;
        }

        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .alert-success {
            background: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .user-info {
            background: #faf8ff;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 25px;
            border-left: 4px solid #8b45ff;
        }

        .user-info h3 {
            color: #6c35cc;
            margin-bottom: 10px;
        }

        .required {
            color: #dc3545;
            font-weight: bold;
        }

        @media (max-width: 768px) {
            .form-row {
                flex-direction: column;
            }
            
            .table-details {
                flex-direction: column;
                gap: 15px;
            }
            
            .btn-group {
                flex-direction: column;
            }
            
            .content {
                padding: 25px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🍽️ จองโต๊ะ</h1>
            <p>กรุณากรอกข้อมูลการจองให้ครบถ้วน</p>
        </div>

        <div class="content">
            <!-- แสดงข้อความข้อผิดพลาด -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    ❌ ${error}
                </div>
            </c:if>

            <!-- ข้อมูลผู้ใช้ -->
            <div class="user-info">
                <h3>👤 ข้อมูลผู้จอง</h3>
                <p><strong>ชื่อ:</strong> ${user.cusname}</p>
                <p><strong>เบอร์โทร:</strong> ${user.phonenumber}</p>
                <p><strong>อีเมล:</strong> ${user.gmail}</p>
            </div>

            <!-- ข้อมูลโต๊ะที่เลือก -->
            <div class="table-info">
                <h2>📋 ข้อมูลโต๊ะที่เลือก</h2>
                <div class="table-details">
                    <div class="detail-item">
                        <div class="label">หมายเลขโต๊ะ</div>
                        <div class="value">${selectedTable.tableid}</div>
                    </div>
                    <div class="detail-item">
                        <div class="label">จำนวนที่นั่ง</div>
                        <div class="value">${selectedTable.capacity} ที่</div>
                    </div>
                    <div class="detail-item">
                        <div class="label">สถานะ</div>
                        <div class="value" id="tableStatus">
                            <c:choose>
                                <c:when test="${selectedTable.status == 'Free'}">
                                    <span class="status-free">พร้อมให้บริการ</span>
                                </c:when>
                                <c:when test="${selectedTable.status == 'In use'}">
                                    <span class="status-in-use">กำลังใช้งาน</span>
                                </c:when>
                                <c:when test="${selectedTable.status == 'Already reserved'}">
                                    <span class="status-reserved">จองแล้ว</span>
                                </c:when>
                                <c:otherwise>
                                    <span>${selectedTable.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ฟอร์มการจอง -->
            <form action="confirmReservation" method="post" onsubmit="return validateForm()">
                <input type="hidden" name="tableid" value="${selectedTable.tableid}">
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="reservationDate"> วันที่จอง <span class="required">*</span></label>
                        <input type="date" id="reservationDate" name="reservationDate" required min="">
                    </div>
                    <div class="form-group">
                        <label for="reservationTime"> เวลาจอง <span class="required">*</span></label>
                        <select id="reservationTime" name="reservationTime" required>
                            <option value="">เลือกเวลา</option>
                            
                            <option value="11:00">11:00 น.</option>
                            <option value="11:30">11:30 น.</option>
                            <option value="12:00">12:00 น.</option>
                            <option value="12:30">12:30 น.</option>
                            <option value="13:00">13:00 น.</option>
                            <option value="13:30">13:30 น.</option>
                            <option value="14:00">14:00 น.</option>
                            <option value="17:00">17:00 น.</option>
                            <option value="17:30">17:30 น.</option>
                            <option value="18:00">18:00 น.</option>
                            <option value="18:30">18:30 น.</option>
                            <option value="19:00">19:00 น.</option>
                            <option value="19:30">19:30 น.</option>
                            <option value="20:00">20:00 น.</option>
                            <option value="20:30">20:30 น.</option>
                            <option value="21:00">21:00 น.</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label for="numberOfGuests"> จำนวนผู้ใช้บริการ <span class="required">*</span></label>
                    <select id="numberOfGuests" name="numberOfGuests" required>
                        <option value="">เลือกจำนวนคน</option>
                        <c:forEach begin="1" end="${selectedTable.capacity}" var="i">
                            <option value="${i}">${i} คน</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                         ยืนยันการจอง
                    </button>
                    <a href="listTable" class="btn btn-secondary">
                         ยกเลิก
                    </a>
                </div>
            </form>
        </div>
    </div>

   <script>
    // แทนที่สคริปต์เดิมด้วยอันนี้ทั้งหมด
    document.addEventListener('DOMContentLoaded', function() {
        const dateInput = document.getElementById('reservationDate');
        const timeSelect = document.getElementById('reservationTime');

        // ค่า server-side ที่ต้องการใช้งานใน JS
        const maxCapacity = ${selectedTable.capacity}; // เป็นตัวเลข
        const tableId = '${selectedTable.tableid}'; // ใช้ใน confirm message

        // ตั้งค่าวันที่ขั้นต่ำเป็นวันนี้ (อนุญาตจองวันนี้ แต่ต้องเป็นเวลาข้างหน้า)
        const now = new Date();
        const todayIso = new Date(now.getFullYear(), now.getMonth(), now.getDate())
                          .toISOString().split('T')[0];
        dateInput.min = todayIso;

        // ตั้งค่าวันที่สูงสุด (2 วันข้างหน้า)
        const maxDate = new Date(now);
        maxDate.setDate(maxDate.getDate() + 2);
        dateInput.max = maxDate.toISOString().split('T')[0];

        // ฟังก์ชันช่วย: ปรับสถานะตัวเลือกเวลาเมื่อเลือกวันเป็น "วันนี้" หรือวันอื่น
        function updateTimeOptionsDisablePast() {
            const selectedDateStr = dateInput.value;
            if (!selectedDateStr) {
                // ถ้ายังไม่เลือกวัน ให้เปิดตัวเลือกทั้งหมด (ยกเลิก disabled)
                for (let opt of timeSelect.options) opt.disabled = false;
                return;
            }

            const selectedDate = new Date(selectedDateStr);
            const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

            // ถ้าเลือกวันนี้ ให้ปิดตัวเลือกเวลาที่ผ่านไปแล้ว
            if (selectedDate.getTime() === today.getTime()) {
                const current = new Date(); // เวลาปัจจุบันจริง
                for (let i = 0; i < timeSelect.options.length; i++) {
                    const opt = timeSelect.options[i];
                    if (!opt.value) { // ตัวเลือก placeholder
                        opt.disabled = false;
                        continue;
                    }
                    // สร้าง Date object สำหรับเวลาที่เลือก (บนวันที่ที่เลือก)
                    const [h, m] = opt.value.split(':').map(Number);
                    const optDate = new Date(selectedDate);
                    optDate.setHours(h, m, 0, 0);

                    // ถ้าเวลาในอดีตหรือเท่ากับตอนนี้ -> disabled
                    if (optDate <= current) {
                        opt.disabled = true;
                    } else {
                        opt.disabled = false;
                    }
                }
            } else {
                // ถ้าไม่ใช่วันนี้ (วันถัดไป/2 วันข้างหน้า) ให้เปิดทุกตัวเลือก
                for (let opt of timeSelect.options) opt.disabled = false;
            }
        }

        // เรียกครั้งแรก (กรณี dateInput มีค่า preload)
        updateTimeOptionsDisablePast();

        // อัพเดตตัวเลือกเวลาเมื่อผู้ใช้เปลี่ยนวันที่
        dateInput.addEventListener('change', updateTimeOptionsDisablePast);

        // เพิ่ม animation เมื่อโหลดหน้า
        const container = document.querySelector('.container');
        container.style.transform = 'translateY(20px)';
        container.style.opacity = '0';

        setTimeout(() => {
            container.style.transition = 'all 0.5s ease';
            container.style.transform = 'translateY(0)';
            container.style.opacity = '1';
        }, 100);

        // ติดตั้งการ validate ก่อน submit
        const form = document.querySelector('form[action="confirmReservation"]');
        if (form) {
            form.addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                }
            });
        }

        // ฟังก์ชัน validate เดียว ทำหน้าที่ครบถ้วน
        function validateForm() {
            const date = dateInput.value;
            const time = timeSelect.value;
            const guests = document.getElementById('numberOfGuests').value;

            if (!date || !time || !guests) {
                alert('กรุณากรอกข้อมูลให้ครบถ้วน');
                return false;
            }

            // ตรวจสอบจำนวนไม่เกินความจุของโต๊ะ
            if (parseInt(guests) > parseInt(maxCapacity, 10)) {
                alert('จำนวนผู้ใช้บริการเกินความจุของโต๊ะ (สูงสุด ' + maxCapacity + ' คน)');
                return false;
            }

            // สร้าง DateTime ที่ถูกเลือก
            const [hour, minute] = time.split(":").map(Number);
            const selectedDate = new Date(date);
            selectedDate.setHours(hour, minute, 0, 0);

            const nowReal = new Date();

            // ถ้าวันที่เป็นวันนี้หรือวันก่อน ตรวจสอบเวลาให้แน่นอน
            if (selectedDate <= nowReal) {
                alert('ไม่สามารถจองเวลาที่ผ่านมาแล้วได้ กรุณาเลือกเวลาในอนาคต');
                return false;
            }

            // ยืนยันการจอง (show confirmation)
            const confirmation = confirm(
                'ยืนยันการจองโต๊ะ ' + tableId + '\n' +
                'วันที่: ' + formatDate(date) + '\n' +
                'เวลา: ' + time + '\n' +
                'จำนวนคน: ' + guests + ' คน'
            );

            return confirmation;
        }

        function formatDate(dateStr) {
            const date = new Date(dateStr);
            const options = {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                weekday: 'long'
            };
            return date.toLocaleDateString('th-TH', options);
        }
    });
</script>

</body>
</html>