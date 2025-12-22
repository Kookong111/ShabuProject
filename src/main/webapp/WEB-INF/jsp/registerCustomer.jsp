<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register - Customer</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

  <style>
    :root {
      --primary-purple: #9b95a8;
      --light-purple: #b5b0c4;
      --very-light-purple: #fbfafc;
      --white: #ffffff;
      --light-gray: #fcfcfd;
      --border-color: #d0ccd7;
      --border-strong: #b8b3c1;
      --text-dark: #3a3f4a;
      --text-gray: #7a8391;
      --text-light: #adb5c2;
      --shadow: 0 20px 40px -15px rgba(155, 149, 168, 0.15);
    }

    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #fbfafc, #f3f1f6);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .main-container {
      position: relative;
      background: #fff;
      border-radius: 20px;
      box-shadow: var(--shadow);
      border: 3px solid var(--border-strong);
      width: 100%;
      max-width: 650px;
      padding: 48px 36px;
      margin: 20px;
      box-sizing: border-box;
    }

    .btn-back-inside {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      padding: 0;
      background: none;
      color: #5d4e6b;
      border: none;
      border-radius: 0;
      font-weight: 500;
      font-size: 0.95rem;
      text-decoration: none;
      margin-bottom: 25px;
      transition: color 0.2s;
      box-shadow: none;
    }

    .btn-back-inside:hover {
      color: #7a4fa6;
      background: none;
      text-decoration: underline;
      transform: none;
    }

    .header {
      text-align: center;
      margin-bottom: 40px;
      border-bottom: 2px solid var(--border-color);
      padding-bottom: 18px;
    }

    .header h2 {
      font-size: 2rem;
      color: #5d4e6b;
      font-weight: 700;
      margin-bottom: 5px;
    }

    .header p {
      font-size: 0.95rem;
      color: var(--text-gray);
    }

    .form-group {
      margin-bottom: 20px;
    }

    .form-label {
      display: block;
      font-weight: 600;
      font-size: 0.85rem;
      margin-bottom: 8px;
      color: #5d4e6b;
    }

    .input-wrapper {
      position: relative;
    }

    .form-control {
      width: 100%;
      padding: 14px 18px 14px 45px;
      border: 2px solid var(--border-color);
      border-radius: 10px;
      background-color: var(--light-gray);
      font-size: 0.95rem;
      color: var(--text-dark);
      transition: all 0.3s ease;
    }

    .form-control:focus {
      border-color: var(--primary-purple);
      box-shadow: 0 0 0 3px rgba(155, 149, 168, 0.08);
      background-color: var(--white);
      outline: none;
    }

    .input-icon {
      position: absolute;
      left: 16px;
      top: 50%;
      transform: translateY(-50%);
      font-size: 1rem;
      color: var(--text-light);
    }

    .btn-primary-modern {
      background: linear-gradient(135deg, #8b5fbf, #a569d9);
      color: white;
      border: none;
      border-radius: 10px;
      padding: 14px 28px;
      font-size: 1rem;
      font-weight: 500;
      width: 100%;
      margin-top: 10px;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn-primary-modern:hover {
      background: linear-gradient(135deg, #7a4fa6, #8b5fbf);
      box-shadow: 0 8px 20px rgba(139, 95, 191, 0.3);
    }

    .alt-link {
      text-align: center;
      margin-top: 18px;
      font-size: 0.95rem;
      color: var(--text-gray);
    }

    .alt-link a {
      color: #7a4fa6;
      text-decoration: none;
      font-weight: 500;
    }

    .alt-link a:hover {
      text-decoration: underline;
    }

    @media (max-width: 768px) {
      .main-container { padding: 28px 20px; margin: 12px; border-width: 2px; }
      .header h2 { font-size: 1.6rem; }
    }
  </style>
</head>

<body>
  <div class="main-container">
    
    <a href="gotowelcomeCustomerCheck" class="btn-back-inside">
      <i class="fas fa-arrow-left"></i>
    </a>

    <div class="header">
      <h2>ลงทะเบียนลูกค้า</h2>
      <p>ระบบจัดการร้านอาหาร</p>
    </div>

    <form action="registercustomer" method="post" id="registerForm" onsubmit="return validateRegisterForm()">
      <div class="form-group">
        <label class="form-label" for="username">ชื่อผู้ใช้</label>
        <div class="input-wrapper">
          <input type="text" id="username" name="username" class="form-control" required placeholder="ตั้งชื่อผู้ใช้ของคุณ">
          <i class="fas fa-user input-icon"></i>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label" for="password">รหัสผ่าน</label>
        <div class="input-wrapper">
          <input type="password" id="password" name="password" class="form-control" required placeholder="กรอกรหัสผ่าน">
          <i class="fas fa-lock input-icon"></i>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label" for="name">ชื่อ</label>
        <div class="input-wrapper">
          <input type="text" id="name" name="name" class="form-control" required placeholder="ชื่อจริง">
          <i class="fas fa-id-card input-icon"></i>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label" for="phonenumber">เบอร์โทร</label>
        <div class="input-wrapper">
          <input type="text" id="phonenumber" name="phonenumber" class="form-control" required placeholder="เช่น 08x-xxx-xxxx">
          <i class="fas fa-phone input-icon"></i>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label" for="age">อายุ</label>
        <div class="input-wrapper">
          <input type="number" id="age" name="age" class="form-control" min="1" required placeholder="เช่น 20">
          <i class="fas fa-cake-candles input-icon"></i>
        </div>
      </div>

      <div class="form-group">
        <label class="form-label" for="email">อีเมล</label>
        <div class="input-wrapper">
          <input type="email" id="email" name="email" class="form-control" required placeholder="example@email.com">
          <i class="fas fa-envelope input-icon"></i>
        </div>
      </div>

      <button type="submit" class="btn-primary-modern">
        <i class="fas fa-user-plus"></i> ลงทะเบียน
      </button>

      <div class="alt-link">
        มีบัญชีอยู่แล้ว? <a href="gotologin">เข้าสู่ระบบ</a>
      </div>
    </form>
  </div>

  <script>
    document.addEventListener('DOMContentLoaded', function() {
      var el = document.getElementById('username');
      if (el) el.focus();
    });

    function validateRegisterForm() {
        const username = document.getElementById('username').value.trim();
        const password = document.getElementById('password').value;
        const name = document.getElementById('name').value.trim();
        const phone = document.getElementById('phonenumber') ? document.getElementById('phonenumber').value.trim() : '';
        const email = document.getElementById('email') ? document.getElementById('email').value.trim() : '';
        const age = document.getElementById('age') ? document.getElementById('age').value.trim() : '';

        if (!username) {
          alert('กรุณาระบุชื่อผู้ใช้');
          return false;
        }
        if (username.length < 6) {
          alert('ชื่อผู้ใช้ต้องมีอย่างน้อย 6 ตัวอักษร');
          return false;
        }
        if (password.length < 6) {
            alert('รหัสผ่านต้องมีอย่างน้อย 6 ตัวอักษร');
            return false;
        }
        if (!name) {
            alert('กรุณาระบุชื่อจริง');
            return false;
        }
        if (phone && !/^\d{9,11}$/.test(phone)) {
            alert('เบอร์โทรศัพท์ควรเป็นตัวเลข 9-11 หลัก');
            return false;
        }
        if (email && !/^\S+@\S+\.\S+$/.test(email)) {
            alert('รูปแบบอีเมลไม่ถูกต้อง');
            return false;
        }
        if (age && (isNaN(age) || age < 1 || age > 120)) {
            alert('อายุควรเป็นตัวเลข 1-120 ปี');
            return false;
        }
        return true;
    }
  </script>
</body>
</html>