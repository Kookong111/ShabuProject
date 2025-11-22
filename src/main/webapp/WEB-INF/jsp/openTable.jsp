<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="th">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ยืนยันการเปิดโต๊ะ</title>
    <link href="https://fonts.googleapis.com/css2?family=Kanit:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
    <style>
        /* (CSS สไตล์เดิมทั้งหมด) */
        * { font-family: 'Kanit', sans-serif; box-sizing: border-box; }
        body { 
            background-color: #f0f4f8; 
            color: #333; 
            padding: 40px 20px; 
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }
        .form-container {
            max-width: 500px;
            width: 100%;
            background-color: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
        }
        h2 { 
            color: #1a237e; 
            text-align: center; 
            margin-bottom: 25px; 
            font-weight: 600; 
        }
        .table-info {
            text-align: center;
            font-size: 2rem;
            font-weight: 700;
            color: #4caf50; 
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: 500;
            margin-bottom: 8px;
            font-size: 1rem;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #ccc;
            font-size: 1rem;
        }
        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            color: white;
            transition: background-color 0.2s;
            border: none;
            cursor: pointer;
            font-size: 1.1rem;
        }
        .btn-submit { background-color: #4caf50; }
        .btn-submit:hover { background-color: #388e3c; }
        .btn-cancel {
            background-color: #f44336;
            margin-top: 10px;
        }
        .btn-cancel:hover { background-color: #d32f2f; }
        .btn-home {
            background-color: #1a237e; 
            color: white;
            display: inline-block;
            width: auto;
            padding: 8px 15px;
            margin-bottom: 15px;
            border-radius: 8px;
            text-decoration: none;
            font-size: 0.9rem;
        }
        .btn-home:hover {
            background-color: #3949ab;
        }
        .error-message {
            background-color: #fce4e4;
            color: #c62828;
            padding: 10px;
            border-radius: 8px;
            margin-bottom: 15px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="form-container">
        
        <a href="gohome" class="btn-home">
            <i class="fas fa-arrow-left"></i> 🏠 กลับหน้าหลัก
        </a>
        
        <h2><i class="fas fa-door-open"></i> เปิดโต๊ะสำหรับลูกค้า Walk-in</h2>
        
        <c:if test="${not empty selectedTable}">
            <div class="table-info">
                โต๊ะ ${selectedTable.tableid}
                <div style="font-size: 1rem; color: #555;">(รองรับ ${selectedTable.capacity} ที่นั่ง)</div>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>

        <form action="confirmOpenTable" method="POST">
            
            <input type="hidden" name="tableid" value="${selectedTable.tableid}">
            
            <div class="form-group">
                <label for="guestCount">จำนวนลูกค้า (คน)</label>
                <input type="number" id="guestCount" name="guestCount" min="1" max="${selectedTable.capacity}" 
                       placeholder="กรุณากรอกจำนวนลูกค้า..." required 
                       oninput="checkCapacity(this, ${selectedTable.capacity})">
                <small id="capacityWarning" style="color: red; display: none; margin-top: 5px;">
                    จำนวนลูกค้าเกินกว่าที่โต๊ะรองรับ!
                </small>
            </div>
            
            <div class="form-group">
                <label for="initialFoodId">เลือกเมนูอาหารเริ่มต้น (เปิดบิล)</label>
                <select id="initialFoodId" name="initialFoodId" required>
                    <option value="">-- กรุณาเลือกเมนู --</option>
                    <c:forEach var="menu" items="${menuList}">
                        <option value="${menu.foodId}">${menu.foodname}</option> 
                    </c:forEach>
                </select>
            </div>
            
            <button type="submit" class="btn btn-submit">
                <i class="fas fa-check"></i> ยืนยันการเปิดโต๊ะและเปิดบิล
            </button>
            
            <a href="gotoManageTable" class="btn btn-cancel">
                <i class="fas fa-times"></i> ยกเลิก
            </a>
        </form>
    </div>

    <script>
        // ฟังก์ชันตรวจสอบความจุ (เดิม)
        function checkCapacity(input, maxCapacity) {
            var warning = document.getElementById('capacityWarning');
            if (parseInt(input.value) > maxCapacity) {
                warning.style.display = 'block';
                input.style.borderColor = 'red';
            } else {
                warning.style.display = 'none';
                input.style.borderColor = '#ccc';
            }
        }
        
        // 🚩 NEW: ฟังก์ชัน JavaScript สำหรับกรองตัวเลือกเฉพาะ "บุฟเฟต์"
        function filterBuffetOptions() {
            const selectElement = document.getElementById('initialFoodId');
            const options = selectElement.options;
            const buffetKeyword = "บุฟเฟต์"; 
            
            // วนลูปย้อนกลับเพื่อลบ options ได้อย่างปลอดภัย
            for (let i = options.length - 1; i >= 0; i--) {
                const option = options[i];
                const text = option.text;
                
                // ตรวจสอบว่าไม่ใช่ตัวเลือกแรก ("-- กรุณาเลือกเมนู --") 
                // และชื่อขึ้นต้นด้วย 'บุฟเฟต์' (แบบไม่คำนึงถึงตัวพิมพ์เล็กใหญ่)
                if (i > 0 && !text.toUpperCase().startsWith(buffetKeyword.toUpperCase())) {
                    selectElement.removeChild(option);
                }
            }
            // หากตัวเลือกแรกถูกลบไป ให้แน่ใจว่าตัวเลือกเริ่มต้นยังคงอยู่
            if (selectElement.options.length === 0 || selectElement.options[0].value !== "") {
                const defaultOption = document.createElement('option');
                defaultOption.value = "";
                defaultOption.text = "-- กรุณาเลือกเมนู --";
                selectElement.prepend(defaultOption);
            }
        }

        // เรียกใช้ฟังก์ชันเมื่อหน้าเว็บโหลด
        document.addEventListener('DOMContentLoaded', filterBuffetOptions);
    </script>
</body>
</html>