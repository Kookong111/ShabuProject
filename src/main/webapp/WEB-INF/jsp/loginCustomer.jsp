<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Customer</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
      /* NEW COLOR FOR ORDERING BUTTON */
      --order-color: #4CAF50; /* Green for Call-to-Action */
      --order-dark: #388E3C;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, #fbfafc, #f3f1f6);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      overflow-x: hidden;
      position: relative;
    }

    .main-container {
      background: #fff;
      border-radius: 20px;
      box-shadow: var(--shadow);
      border: 3px solid var(--border-strong);
      width: 100%;
      max-width: 900px;
      display: flex;
      overflow: hidden;
      position: relative;
    }

    .login-section {
      flex: 1;
      padding: 60px 50px;
      background: var(--white);
    }

    /* Side panel for larger screens (optional visual) */
    .side-panel {
      width: 320px;
      background: linear-gradient(135deg, rgba(139,95,191,0.08), rgba(165,105,217,0.03));
      padding: 40px 30px;
      display: none; /* shown only on larger screens */
      align-items: center;
      justify-content: center;
      flex-direction: column;
      gap: 16px;
    }

    .side-panel .promo-title {
      font-size: 1.1rem;
      font-weight: 700;
      color: #5d4e6b;
      text-align: center;
    }

    .side-panel .promo-text {
      font-size: 0.95rem;
      color: var(--text-gray);
      text-align: center;
    }

    .login-header {
      text-align: center;
      margin-bottom: 50px;
      border-bottom: 2px solid var(--border-color);
      padding-bottom: 20px;
    }

    .login-header h2 {
      font-size: 2rem;
      color: #5d4e6b;
      font-weight: 700;
    }

    .login-header p {
      font-size: 0.95rem;
      color: var(--text-gray);
    }

    .form-group {
      margin-bottom: 24px;
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

    .btn-login {
      background: linear-gradient(135deg, #8b5fbf, #a569d9);
      color: white;
      border: none;
      border-radius: 10px;
      padding: 14px 28px;
      font-size: 1rem;
      font-weight: 500;
      width: 100%;
      margin-top: 20px;
      cursor: pointer;
      transition: all 0.3s ease;
    }

    .btn-login:hover {
      background: linear-gradient(135deg, #7a4fa6, #8b5fbf);
      box-shadow: 0 8px 20px rgba(139, 95, 191, 0.3);
    }
    
    /* NEW STYLE: Order Button */
    .btn-order-test {
        background-color: var(--order-color);
        color: white;
        border: none;
        border-radius: 10px;
        padding: 14px 28px;
        font-size: 1rem;
        font-weight: 600;
        width: 100%;
        margin-top: 20px;
        cursor: pointer;
        transition: all 0.3s ease;
        text-decoration: none; /* Make it look like a button */
        display: block;
        text-align: center;
        margin-bottom: 20px;
        box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
    }
    
    .btn-order-test:hover {
        background-color: var(--order-dark);
        box-shadow: 0 6px 20px rgba(76, 175, 80, 0.5);
        color: white;
    }
    
    .divider {
        margin: 20px 0;
        text-align: center;
        border-bottom: 1px dashed var(--border-color);
        line-height: 0.1em;
    }
    
    .divider span {
        background: #fff;
        padding: 0 10px;
        font-size: 0.9em;
        color: var(--text-gray);
    }
    /* End NEW STYLE */


    .register-link {
      text-align: center;
      margin-top: 20px;
      font-size: 0.95rem;
      color: var(--text-gray);
    }

    .register-link a {
      color: #7a4fa6;
      text-decoration: none;
      font-weight: 500;
    }

    .register-link a:hover {
      text-decoration: underline;
    }

    @media (max-width: 768px) {
      .main-container {
        flex-direction: column;
        width: 95%;
        border-width: 2px;
      }

      .login-section {
        padding: 40px 30px;
      }

      .login-header h2 {
        font-size: 1.7rem;
      }

      .form-control {
        padding: 12px 16px 12px 40px;
      }
      .btn-login, .btn-order-test {
        padding: 12px 18px;
      }
      .side-panel { display: none; }
    }

    /* Extra small devices adjustments */
    @media (max-width: 420px) {
      .login-header h2 { font-size: 1.4rem; }
      .login-section { padding: 24px 18px; }
      .form-label { font-size: 0.9rem; }
      .input-icon { left: 12px; }
      .form-control { padding-left: 42px; }
      .btn-login { padding: 12px; font-size: 0.95rem; }
      .main-container { border-radius: 14px; }
    }

    /* Show side-panel on wide screens */
    @media (min-width: 992px) {
      .side-panel { display: flex; }
      .main-container { align-items: stretch; }
    }
  </style>
</head>

<body>
  <div class="main-container">
    <div class="side-panel" aria-hidden="true">
      <div class="promo-title">ยินดีต้อนรับสู่ ShaBu</div>
      <div class="promo-text">จองโต๊ะ จัดการการสั่งอาหาร และติดตามคำสั่งซื้อได้อย่างง่ายดาย</div>
      <img src="image/shabu-illustration.png" alt="ShaBu" style="max-width:100%; border-radius:12px; box-shadow:0 8px 30px rgba(0,0,0,0.06);">
    </div>
    <div class="login-section">
      <div class="login-header">
        <h2>เข้าสู่ระบบลูกค้า</h2>
        <p>ระบบจัดการร้านอาหาร</p>
      </div>
      
      <c:choose>
        <c:when test="${not empty error}">
             <div class="alert alert-danger text-center" role="alert">
                ${error}
             </div>
        </c:when>
         <c:when test="${not empty param.error}">
             <div class="alert alert-danger text-center" role="alert">
                ${param.error}
             </div>
        </c:when>
      </c:choose>

      	
     
      
      <form action="loginCustomer" method="post" id="loginForm">
        <input type="hidden" id="role" name="role" value="customer">

        <div class="form-group">
          <label class="form-label">ชื่อผู้ใช้</label>
          <div class="input-wrapper">
            <input type="text" class="form-control" name="cususername" required placeholder="กรอกชื่อผู้ใช้">
            <i class="fas fa-user input-icon"></i>
          </div>
        </div>

        <div class="form-group">
          <label class="form-label">รหัสผ่าน</label>
          <div class="input-wrapper">
            <input type="password" class="form-control" name="cuspassword" required placeholder="กรอกรหัสผ่าน">
            <i class="fas fa-lock input-icon"></i>
          </div>
        </div>

        <button type="submit" class="btn-login">
          <i class="fas fa-sign-in-alt"></i> เข้าสู่ระบบ
        </button>

        <div class="register-link">
          หากยังไม่มีบัญชี <a href="regiscus">ลงทะเบียน</a>
        </div>
      </form>
    </div>
  </div>
</body>

</html>