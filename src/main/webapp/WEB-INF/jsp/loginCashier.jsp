<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login Cashier - Restaurant Management System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
  
  <style>
    :root {
      --primary-purple: #9b95a8;
      --light-purple: #b5b0c4;
      --very-light-purple: #fbfafc;
      --purple-muted: #a8a1b5;
      --purple-soft: #c4bdd0;
      --white: #ffffff;
      --light-gray: #fcfcfd;
      --border-color: #d0ccd7;
      --border-strong: #b8b3c1;
      --text-dark: #3a3f4a;
      --text-gray: #7a8391;
      --text-light: #adb5c2;
      --shadow: 0 20px 40px -15px rgba(155, 149, 168, 0.15);
      --shadow-light: 0 8px 25px -10px rgba(155, 149, 168, 0.12);
      --gradient-bg: linear-gradient(135deg, #fbfafc 0%, #f7f6f9 50%, #f3f1f6 100%);
      --gradient-card: linear-gradient(135deg, #ffffff 0%, #fefeff 100%);
      --cashier-accent: #7a6f8a;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: var(--gradient-bg);
      min-height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      overflow-x: hidden;
    }

    /* Subtle animated background pattern */
    body::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: radial-gradient(circle at 25px 25px, rgba(155, 149, 168, 0.015) 2px, transparent 0);
      background-size: 50px 50px;
      animation: float 30s ease-in-out infinite;
      z-index: 0;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0px); }
      50% { transform: translateY(-10px); }
    }

    .main-container {
      position: relative;
      z-index: 1;
      background: var(--gradient-card);
      border-radius: 20px;
      box-shadow: var(--shadow);
      padding: 0;
      width: 950px;
      max-width: 95%;
      min-height: 600px;
      display: flex;
      overflow: hidden;
      border: 3px solid var(--border-strong);
    }

    .roles-section {
      background: linear-gradient(135deg, var(--very-light-purple) 0%, #f9f9fa 100%);
      padding: 50px 30px;
      width: 320px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      position: relative;
      border-right: 2px solid var(--border-strong);
    }

    .roles-header {
      text-align: center;
      margin-bottom: 40px;
    }

    .roles-header h3 {
      color: #5d4e6b;
      font-weight: 700;
      font-size: 1.4rem;
      margin-bottom: 8px;
    }

    .roles-header p {
      color: var(--text-gray);
      font-size: 0.85rem;
      font-weight: 400;
      line-height: 1.5;
    }

    .roles-grid {
      display: grid;
      grid-template-columns: 1fr;
      gap: 14px;
    }

    .role-button {
      display: flex;
      align-items: center;
      padding: 16px 20px;
      border-radius: 12px;
      cursor: pointer;
      border: 2px solid var(--border-color);
      background: var(--white);
      color: #5d4e6b;
      font-weight: 600;
      font-size: 0.95rem;
      text-decoration: none;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      position: relative;
      overflow: hidden;
      box-shadow: var(--shadow-light);
    }

    .role-button:hover {
      transform: translateY(-1px);
      box-shadow: 0 8px 20px -8px rgba(155, 149, 168, 0.18);
      border-color: var(--primary-purple);
      border-width: 3px;
      background: linear-gradient(135deg, var(--white) 0%, #fdfcfe 100%);
    }

    .role-button.active {
      background: linear-gradient(135deg, var(--cashier-accent) 0%, #8b7e9d 100%);
      color: var(--white);
      border-color: var(--cashier-accent);
      border-width: 3px;
      box-shadow: 0 8px 20px -8px rgba(122, 111, 138, 0.3);
    }

    .role-button i {
      font-size: 1.1rem;
      margin-right: 12px;
      width: 18px;
      text-align: center;
      color: var(--primary-purple);
    }

    .role-button.active i {
      color: var(--white);
    }

    .role-button.manager i { color: #6b5f7a; }
    .role-button.cashier i { color: #7a6f8a; }
    .role-button.waiter i { color: #8b7db8; }
    .role-button.customer i { color: #6b5f7a; }

    .login-section {
      flex: 1;
      padding: 60px 50px;
      display: flex;
      flex-direction: column;
      justify-content: center;
      background: var(--white);
    }

    .login-header {
      text-align: center;
      margin-bottom: 50px;
      padding-bottom: 20px;
      border-bottom: 2px solid var(--border-color);
    }

    .login-header h2 {
      color: #5d4e6b;
      font-weight: 700;
      font-size: 2rem;
      margin-bottom: 8px;
    }

    .login-header p {
      color: var(--text-gray);
      font-size: 0.95rem;
      font-weight: 400;
    }

    .form-group {
      margin-bottom: 24px;
      position: relative;
    }

    .form-label {
      color: #5d4e6b;
      font-weight: 600;
      font-size: 0.85rem;
      margin-bottom: 8px;
      display: block;
    }

    .input-wrapper {
      position: relative;
    }

    .form-control {
      border: 2px solid var(--border-color);
      border-radius: 10px;
      padding: 14px 18px 14px 45px;
      font-size: 0.95rem;
      font-weight: 400;
      background-color: var(--light-gray);
      color: var(--text-dark);
      transition: all 0.25s ease;
      width: 100%;
    }

    .form-control:focus {
      border-color: var(--cashier-accent);
      border-width: 3px;
      box-shadow: 0 0 0 3px rgba(122, 111, 138, 0.08);
      background-color: var(--white);
      outline: none;
    }

    .input-icon {
      position: absolute;
      left: 16px;
      top: 50%;
      transform: translateY(-50%);
      color: var(--text-light);
      font-size: 1rem;
      z-index: 2;
    }

    .form-control:focus + .input-icon {
      color: var(--cashier-accent);
    }

    .btn-login {
      background: linear-gradient(135deg, var(--cashier-accent) 0%, #8b7e9d 100%);
      border: 3px solid transparent;
      border-radius: 10px;
      padding: 14px 28px;
      font-size: 1rem;
      font-weight: 500;
      color: var(--white);
      width: 100%;
      transition: all 0.3s ease;
      margin-top: 20px;
      position: relative;
      overflow: hidden;
    }

    .btn-login::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255,255,255,0.15), transparent);
      transition: left 0.6s;
    }

    .btn-login:hover::before {
      left: 100%;
    }

    .btn-login:hover {
      transform: translateY(-1px);
      box-shadow: 0 8px 20px -6px rgba(122, 111, 138, 0.35);
      background: linear-gradient(135deg, #6b5f7a 0%, #7a6f8a 100%);
      border-color: #5d4e6b;
    }

    .btn-login:active {
      transform: translateY(0);
    }

    /* Responsive Design */
    @media (max-width: 1024px) {
      .main-container {
        width: 90%;
      }
    }

    @media (max-width: 768px) {
      .main-container {
        flex-direction: column;
        width: 95%;
        min-height: auto;
        border: 2px solid var(--border-strong);
        border-radius: 16px;
      }

      .roles-section {
        width: 100%;
        padding: 25px 20px;
        border-right: none;
        border-bottom: 2px solid var(--border-strong);
      }

      .roles-header h3 {
        font-size: 1.2rem;
      }

      .roles-header p {
        font-size: 0.8rem;
      }

      .roles-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 10px;
      }

      .role-button {
        padding: 12px 14px;
        font-size: 0.85rem;
      }

      .role-button i {
        font-size: 0.95rem;
        margin-right: 8px;
      }

      .login-section {
        padding: 35px 25px;
      }

      .login-header {
        margin-bottom: 35px;
      }

      .login-header h2 {
        font-size: 1.5rem;
      }

      .login-header p {
        font-size: 0.9rem;
      }

      .form-label {
        font-size: 0.8rem;
      }

      .form-control {
        padding: 12px 14px 12px 40px;
        font-size: 0.9rem;
      }

      .btn-login {
        padding: 12px 24px;
        font-size: 0.95rem;
      }

      .error-message {
        font-size: 0.75rem;
      }

      .login-error-alert {
        padding: 12px 16px;
        margin-bottom: 20px;
      }

      .login-error-alert p {
        font-size: 0.9rem;
      }
    }

    @media (max-width: 600px) {
      .main-container {
        width: 100%;
        border-radius: 12px;
        min-height: 100vh;
      }

      .roles-section {
        padding: 20px 15px;
        width: 100%;
      }

      .roles-header {
        margin-bottom: 25px;
      }

      .roles-header h3 {
        font-size: 1.1rem;
        margin-bottom: 6px;
      }

      .roles-header p {
        font-size: 0.75rem;
      }

      .roles-grid {
        grid-template-columns: repeat(2, 1fr);
        gap: 8px;
      }

      .role-button {
        padding: 10px 12px;
        font-size: 0.75rem;
        border-radius: 8px;
      }

      .role-button i {
        font-size: 0.9rem;
        margin-right: 6px;
        width: 16px;
      }

      .login-section {
        padding: 30px 20px;
      }

      .login-header {
        margin-bottom: 30px;
        padding-bottom: 15px;
      }

      .login-header h2 {
        font-size: 1.3rem;
        margin-bottom: 6px;
      }

      .login-header p {
        font-size: 0.85rem;
      }

      .form-group {
        margin-bottom: 18px;
      }

      .form-label {
        font-size: 0.75rem;
        margin-bottom: 6px;
      }

      .form-control {
        padding: 11px 12px 11px 36px;
        font-size: 0.85rem;
        border-radius: 8px;
      }

      .input-icon {
        left: 12px;
        font-size: 0.9rem;
      }

      .btn-login {
        padding: 11px 20px;
        font-size: 0.9rem;
        margin-top: 16px;
        border-radius: 8px;
      }

      .error-message {
        font-size: 0.7rem;
        padding: 6px 10px;
        margin-top: 4px;
      }

      .login-error-alert {
        padding: 10px 12px;
        gap: 10px;
        margin-bottom: 16px;
        border-radius: 8px;
      }

      .login-error-alert i {
        font-size: 1.1rem;
      }

      .login-error-alert p {
        font-size: 0.85rem;
      }
    }

    @media (max-width: 400px) {
      .main-container {
        min-height: 100vh;
        border-width: 0;
        border-radius: 0;
      }

      .roles-section {
        padding: 15px 12px;
      }

      .roles-header h3 {
        font-size: 1rem;
      }

      .roles-header p {
        font-size: 0.7rem;
      }

      .role-button {
        padding: 9px 10px;
        font-size: 0.7rem;
      }

      .login-section {
        padding: 25px 15px;
      }

      .login-header h2 {
        font-size: 1.2rem;
      }

      .form-control {
        padding: 10px 10px 10px 34px;
        font-size: 0.8rem;
      }

      .btn-login {
        padding: 10px 18px;
        font-size: 0.85rem;
      }
    }

    /* Loading animation */
    .btn-login.loading {
      pointer-events: none;
      background: var(--text-light);
    }

    .btn-login.loading::after {
      content: '';
      position: absolute;
      width: 18px;
      height: 18px;
      margin: auto;
      border: 2px solid transparent;
      border-top-color: var(--white);
      border-radius: 50%;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    /* Enhanced glow effect */
    .main-container::after {
      content: '';
      position: absolute;
      top: -3px;
      left: -3px;
      right: -3px;
      bottom: -3px;
      background: linear-gradient(135deg, rgba(122, 111, 138, 0.08), rgba(139, 126, 157, 0.04));
      border-radius: 23px;
      z-index: -1;
      opacity: 0;
      transition: opacity 0.3s ease;
    }

    .main-container:hover::after {
      opacity: 1;
    }

    /* Additional border enhancements */
    .form-group {
      border: 1px solid transparent;
      border-radius: 12px;
      padding: 8px;
      transition: all 0.3s ease;
    }

    .form-group:focus-within {
      border-color: rgba(122, 111, 138, 0.15);
      background: rgba(251, 250, 252, 0.5);
    }

    /* Error message styles */
    .error-message {
      color: #d32f2f;
      font-size: 0.8rem;
      margin-top: 6px;
      display: none;
      padding: 8px 12px;
      background-color: #ffebee;
      border-left: 3px solid #d32f2f;
      border-radius: 4px;
      font-weight: 500;
    }

    .error-message.show {
      display: block;
    }

    .form-control.error {
      border-color: #d32f2f;
      background-color: #ffebee;
    }

    .form-control.error:focus {
      border-color: #d32f2f;
      box-shadow: 0 0 0 3px rgba(211, 47, 47, 0.08);
    }

    /* Backend error alert styles */
    .login-error-alert {
      background: linear-gradient(135deg, #ffebee 0%, #ffcdd2 100%);
      border: 2px solid #d32f2f;
      border-radius: 10px;
      padding: 16px 20px;
      margin-bottom: 24px;
      display: flex;
      align-items: center;
      gap: 12px;
      animation: slideDown 0.3s ease-out;
    }

    .login-error-alert.hidden {
      display: none;
    }

    .login-error-alert i {
      color: #d32f2f;
      font-size: 1.3rem;
      flex-shrink: 0;
    }

    .login-error-alert p {
      color: #c62828;
      font-weight: 500;
      margin: 0;
      font-size: 0.95rem;
    }

    @keyframes slideDown {
      from {
        opacity: 0;
        transform: translateY(-10px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }
  </style>
</head>

<body>
  <div class="main-container">
    <div class="roles-section">
      <div class="roles-header">
        <h3><i class="fas fa-users"></i> เลือกบทบาท</h3>
        <p>กรุณาเลือกบทบาทของคุณเพื่อเข้าสู่ระบบ</p>
      </div>
      
      <div class="roles-grid">
        <form action="RoleManager" method="post">
          <button type="submit" class="role-button manager">
            <i class="fas fa-user-tie"></i>
            <span>ผู้จัดการ</span>
          </button>
        </form>
        
        <form action="RoleCashier" method="post">
          <button type="submit" class="role-button cashier active">
            <i class="fas fa-cash-register"></i>
            <span>แคชเชียร์</span>
          </button>
        </form>
        
        <form action="RoleWaiter" method="post">
          <button type="submit" class="role-button waiter">
            <i class="fas fa-utensils"></i>
            <span>พนักงานเสิร์ฟ</span>
          </button>
        </form>
        
        <form action="RoleCustomer" method="post">
          <button type="submit" class="role-button customer">
            <i class="fas fa-user"></i>
            <span>ลูกค้า</span>
          </button>
        </form>
      </div>
    </div>

    <div class="login-section">
      <div class="login-header">
        <h2>เข้าสู่ระบบแคชเชียร์</h2>
        <p>ระบบจัดการร้านอาหาร</p>
      </div>

      <c:if test="${not empty error}">
        <div class="login-error-alert" id="errorAlert">
          <i class="fas fa-exclamation-circle"></i>
          <p>${error}</p>
        </div>
      </c:if>

      <form action="LoginCashier" method="post" id="loginForm">
        <input type="hidden" id="role" name="role">
        
        <div class="form-group">
          <label class="form-label">ชื่อผู้ใช้</label>
          <div class="input-wrapper">
            <input type="text" class="form-control" id="usernameInput" name="empUsername" required placeholder="กรอกชื่อผู้ใช้ (เริ่มต้นด้วย CUS)">
            <i class="fas fa-user input-icon"></i>
          </div>
          <div class="error-message" id="usernameError">ชื่อผู้ใช้ต้องขึ้นต้นด้วย CUS เท่านั้น</div>
        </div>
        
        <div class="form-group">
          <label class="form-label">รหัสผ่าน</label>
          <div class="input-wrapper">
            <input type="password" class="form-control" id="passwordInput" name="empPassword" required placeholder="กรอกรหัสผ่าน (ตัวอักษรและตัวเลขรวมกัน8 ตัวขึ้นไป)">
            <i class="fas fa-lock input-icon"></i>
          </div>
          <div class="error-message" id="passwordError">รหัสผ่านต้องมีทั้งตัวอักษรและตัวเลขรวมกัน 8 ตัวขึ้นไป</div>
        </div>
        
        <button type="submit" class="btn-login" id="loginBtn">
          <i class="fas fa-sign-in-alt"></i> เข้าสู่ระบบ
        </button>
      </form>
    </div>
  </div>

  <script>
    // Validation functions
    function validateUsername(username) {
      return username.toUpperCase().startsWith('CUS');
    }

    function validatePassword(password) {
      // ต้องมีความยาว >= 8
      if (password.length < 8) {
        return false;
      }
      
      // ต้องมีตัวอักษรภาษาอังกฤษ (a-z, A-Z)
      const hasLetters = /[a-zA-Z]/.test(password);
      
      // ต้องมีตัวเลข (0-9)
      const hasNumbers = /[0-9]/.test(password);
      
      return hasLetters && hasNumbers;
    }

    // Clear error on input
    document.getElementById('usernameInput').addEventListener('input', function() {
      this.classList.remove('error');
      document.getElementById('usernameError').classList.remove('show');
    });

    document.getElementById('passwordInput').addEventListener('input', function() {
      this.classList.remove('error');
      document.getElementById('passwordError').classList.remove('show');
    });

    // Auto-hide error alert after 5 seconds
    const errorAlert = document.getElementById('errorAlert');
    if (errorAlert) {
      setTimeout(() => {
        errorAlert.style.animation = 'slideUp 0.3s ease-out forwards';
        setTimeout(() => {
          errorAlert.classList.add('hidden');
        }, 300);
      }, 5000);
    }

    // Add keydown listener to focus first input if error is shown
    const inputs = document.querySelectorAll('.form-control');
    inputs.forEach(input => {
      input.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
          document.getElementById('loginForm').dispatchEvent(new Event('submit'));
        }
      });
    });

    // Add loading animation on form submit
    document.getElementById('loginForm').addEventListener('submit', function(e) {
      e.preventDefault();
      
      const username = document.getElementById('usernameInput').value.trim();
      const password = document.getElementById('passwordInput').value;
      
      let hasError = false;

      // Validate username
      if (!validateUsername(username)) {
        document.getElementById('usernameInput').classList.add('error');
        document.getElementById('usernameError').classList.add('show');
        hasError = true;
      }

      // Validate password
      if (!validatePassword(password)) {
        document.getElementById('passwordInput').classList.add('error');
        document.getElementById('passwordError').classList.add('show');
        hasError = true;
      }

      if (hasError) {
        return false;
      }

      // If validation passed, submit the form
      const btn = document.getElementById('loginBtn');
      btn.classList.add('loading');
      btn.innerHTML = '<span>กำลังโหลด...</span>';
      this.submit();
    });

    // Add smooth focus transitions
    const inputs = document.querySelectorAll('.form-control');
    inputs.forEach(input => {
      input.addEventListener('focus', function() {
        this.parentElement.style.transform = 'scale(1.01)';
      });
      
      input.addEventListener('blur', function() {
        this.parentElement.style.transform = 'scale(1)';
      });
    });

    // Add subtle interaction feedback
    const roleButtons = document.querySelectorAll('.role-button');
    roleButtons.forEach(button => {
      button.addEventListener('mouseenter', function() {
        if (!this.classList.contains('active')) {
          this.style.transform = 'translateY(-2px) scale(1.02)';
        }
      });
      
      button.addEventListener('mouseleave', function() {
        if (!this.classList.contains('active')) {
          this.style.transform = 'translateY(0) scale(1)';
        }
      });
    });
  </script>
</body>

</html>