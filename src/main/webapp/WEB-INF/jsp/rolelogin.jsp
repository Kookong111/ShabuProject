<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>


<head>
  <meta charset="UTF-8">
  <title>Login</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  

  <style>
    body {
      margin: 0;
      padding: 0;
      background-color: #212529;
      height: 100vh;
      display: flex;
      justify-content: center;
      align-items: center;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .container {
      display: flex;
      background-color: #343a40;
      border-radius: 12px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.5);
      padding: 40px;
      width: 700px;
    }

    .roles {
      display: flex;
      flex-direction: column;
      gap: 20px;
      margin-right: 20px;
    }

    .role {
      display: inline-block;
    }

    .role-button {
      display: flex;
      align-items: center;
      padding: 15px 20px;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease, border-color 0.3s ease;
      border: 1px solid #495057;
      background-color: transparent;
      color: #f8f9fa;
      width: 150px;
    }

    .role-button:hover {
      background-color: #495057;
      border-color: #6c757d;
      
    }

    .role-button i {
      font-size: 24px;
      margin-right: 15px;
      color: #f8f9fa;
    }
    
    .login-container {
      flex-grow: 1;
    }

    .login-container h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #f8f9fa;
    }

    .form-label {
      color: #f8f9fa;
    }

    .form-control {
      border-radius: 8px;
      border: 1px solid #495057;
      padding: 12px 15px;
      font-size: 16px;
      background-color: #495057;
      color: #f8f9fa;
    }

    .form-control:focus {
      border-color: #80bdff;
      box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
    }

    .btn-primary {
      background-color: #007bff;
      border-color: #007bff;
      border-radius: 8px;
      padding: 12px 20px;
      font-size: 16px;
    }

    .btn-primary:hover {
      background-color: #0069d9;
      border-color: #0062cc;
    }

    .divider {
      width: 0;
      border-right: 2px solid #e0e0e0;
      margin: 0 20px;
    }

    @media (max-width: 768px) {
      .container {
        flex-direction: column;
        width: 90%;
      }

      .roles {
        flex-direction: row;
        margin: 0 0 20px;
        flex-wrap: wrap;
        justify-content: center;
      }

      .role {
        width: 45%;
        margin: 5px;
      }

      .divider {
        width: 100%;
        border-right: none;
        border-bottom: 2px solid #e0e0e0;
        height: 0;
        margin: 20px 0;
      }
    }
  </style>

</head>

<body>
  <div class="container">
    <div class="roles">
      <form action="RoleManager" method="post">
        <button type="submit" class="role-button">
          <i class="fas fa-user-tie"></i>
          <span>ผู้จัดการ</span>
        </button>
      </form>
      <form action="RoleCashier" method="post">
        <button type="submit" class="role-button">
          <i class="fas fa-cash-register"></i>
          <span>แคชเชียร์</span>
        </button>
      </form>
      <form action="RoleWaiter" method="post">
        <button type="submit" class="role-button">
          <i class="fas fa-utensils"></i>
          <span>พนักงานเสิร์ฟ</span>
        </button>
      </form>
      <form action=RoleCustomer method="post">
        <button type="submit" class="role-button">
          <i class="fas fa-user"></i>
          <span>ลูกค้า</span>
        </button>
      </form>
    </div>
    <div class="divider"></div>
    <div class="login-container">
      <h2>Login</h2>
      <form action="LoginManager" method="post">
        <input type="hidden" id="role" name="role">
        <div class="mb-3">
          <label class="form-label">Username</label>
          <input type="text" class="form-control" name="username" required>
        </div>
        <div class="mb-3">
          <label class="form-label">Password</label>
          <input type="password" class="form-control" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Login</button>
      </form>
    </div>
  </div>
</body>

</html>