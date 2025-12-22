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
      --customer-accent: #8b5fbf;
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
      position: relative;
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
      border-color: var(--customer-accent);
      box-shadow: 0 0 0 3px rgba(139, 95, 191, 0.08);
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
      position: relative;
    }

    .btn-login:hover {
      background: linear-gradient(135deg, #7a4fa6, #8b5fbf);
      box-shadow: 0 8px 20px rgba(139, 95, 191, 0.3);
      transform: translateY(-1px);
    }

    /* Error styles เหมือน Waiter */
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

    .error-message.show { display: block; }

    .form-control.error {
      border-color: #d32f2f;
      background-color: #ffebee;
    }

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

    /* Loading animation */
    .btn-login.loading { pointer-events: none; opacity: 0.8; }
    
    .btn-back-login {
      position: absolute;
      left: 32px;
      top: 32px;
      z-index: 10;
      text-decoration: none;
      display: flex;
      align-items: center;
      gap: 8px;
      padding: 0;
      background: none;
      color: #5d4e6b;
      border: none;
      border-radius: 0;
      font-weight: 500;
      font-size: 0.95rem;
      transition: color 0.2s;
      box-shadow: none;
    }

    .btn-back-login:hover {
      color: #7a4fa6;
      background: none;
      text-decoration: underline;
      transform: none;
    }

    @media (max-width: 768px) {
      .main-container { flex-direction: column; width: 95%; }
      .login-section { padding: 40px 30px; }
      .btn-back-login { left: 10px; top: 10px; padding: 0; font-size: 0.8rem; }
    }
        .login-error-alert {
        padding: 12px 16px;
        margin-bottom: 20px;
      }   
    .login-error-alert p {
              font-size: 0.9rem;
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
                                }    .login-error-alert.hidden {
                                      display: none;
                                    }    .login-error-alert i {
                                          color: #d32f2f;
                                          font-size: 1.3rem;
                                          flex-shrink: 0;
                                        }  .login-error-alert p {
                                              color: #c62828;
                                              font-weight: 500;
                                              margin: 0;
                                              font-size: 0.95rem;
                                            }
  </style>
</head>

<body>
  <div class="main-container">
    <a href="gotowelcomeCustomerCheck" class="btn-back-login">
      <i class="fas fa-arrow-left"></i>
    </a>
        
    <div class="login-section">
      <div class="login-header">
        <h2>เข้าสู่ระบบลูกค้า</h2>
        <p>ระบบจัดการร้านอาหาร</p>
      </div>
      
      <c:if test="${not empty error}">
        <div class="login-error-alert" id="errorAlert">
          <i class="fas fa-exclamation-circle"></i>
          <p>${error}</p>
        </div>
      </c:if>

      <form action="loginCustomer" method="post" id="loginForm">
        <input type="hidden" name="role" value="customer">

        <div class="form-group">
          <label class="form-label">ชื่อผู้ใช้</label>
          <div class="input-wrapper">
            <input type="text" class="form-control" id="usernameInput" name="cususername" required placeholder="กรอกชื่อผู้ใช้ (6 ตัวอักษรขึ้นไป)">
            <i class="fas fa-user input-icon"></i>
          </div>
          <div class="error-message" id="usernameError">ชื่อผู้ใช้ต้องมีอย่างน้อย 6 ตัวอักษร</div>
        </div>

        <div class="form-group">
          <label class="form-label">รหัสผ่าน</label>
          <div class="input-wrapper">
            <input type="password" class="form-control" id="passwordInput" name="cuspassword" required placeholder="กรอกรหัสผ่าน (ตัวอักษรและตัวเลขรวมกัน 8 ตัวขึ้นไป)">
            <i class="fas fa-lock input-icon"></i>
          </div>
          <div class="error-message" id="passwordError">รหัสผ่านต้องมีตัวอักษรและตัวเลข รวมกัน 8 ตัวขึ้นไป</div>
        </div>

        <button type="submit" class="btn-login" id="loginBtn">
          <i class="fas fa-sign-in-alt"></i> เข้าสู่ระบบ
        </button>

        <div class="register-link">
           หากยังไม่มีบัญชี <a href="regiscus">ลงทะเบียน</a>
        </div>
      </form>
    </div>
  </div>

  <script>
    // Validation functions
    function validateUsername(username) {
      return username.length >= 6;
    }

    function validatePassword(password) {
      if (password.length < 8) return false;
      const hasLetters = /[a-zA-Z]/.test(password);
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

    // Auto-hide error alert after 5 seconds (if error alert exists)
    const errorAlert = document.querySelector('.alert-danger');
    if (errorAlert) {
      setTimeout(function() {
        errorAlert.classList.add('d-none');
      }, 5000);
    }

    // Add keydown listener to focus first input if error is shown
    const inputs = document.querySelectorAll('.form-control');
    inputs.forEach(input => {
      input.addEventListener('keydown', function(e) {
        if ((e.key === 'Enter' || e.keyCode === 13) && document.querySelector('.error-message.show')) {
          e.preventDefault();
          document.querySelector('.form-control.error')?.focus();
        }
      });
    });

    // Add loading animation on form submit
    document.getElementById('loginForm').addEventListener('submit', function(e) {
      const username = document.getElementById('usernameInput').value.trim();
      const password = document.getElementById('passwordInput').value;
      let hasError = false;

      if (!validateUsername(username)) {
        document.getElementById('usernameInput').classList.add('error');
        document.getElementById('usernameError').classList.add('show');
        hasError = true;
      }

      if (!validatePassword(password)) {
        document.getElementById('passwordInput').classList.add('error');
        document.getElementById('passwordError').classList.add('show');
        hasError = true;
      }

      if (hasError) {
        e.preventDefault();
        return false;
      }

      const btn = document.getElementById('loginBtn');
      btn.classList.add('loading');
      btn.innerHTML = '<span>กำลังโหลด...</span>';
      // this.submit(); // ไม่ต้องเรียกซ้ำ เพราะ form จะ submit ตามปกติ
    });

    // Add smooth focus transitions
    inputs.forEach(input => {
      input.addEventListener('focus', function() {
        this.parentElement.style.transform = 'scale(1.01)';
      });
      input.addEventListener('blur', function() {
        this.parentElement.style.transform = 'scale(1)';
      });
    });

    // Add subtle interaction feedback (ถ้ามีปุ่ม role-button ในอนาคต)
    const roleButtons = document.querySelectorAll('.role-button');
    roleButtons.forEach(button => {
      button.addEventListener('mousedown', function() {
        this.style.transform = 'scale(0.98)';
      });
      button.addEventListener('mouseup', function() {
        this.style.transform = '';
      });
      button.addEventListener('mouseleave', function() {
        this.style.transform = '';
      });
    });
  </script>
</body>
</html>