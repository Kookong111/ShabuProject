<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shabu Restaurant</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
    
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: 'Segoe UI', sans-serif;
        }

        .container {
            display: flex;
            height: 100vh;
        }

        .left {
            width: 50%;
            background-color: white;
            position: relative;
            padding: 30px;
        }

        .right {
            width: 90%;
            background-image: url('<c:url value="/image/sss.jpg" />');
            background-size: cover;
            background-position: center;
            position: relative;
        }
nav {
    position: absolute;
    top: 35px;
    left: 30px; 
}
nav ul {
    list-style: none;
    display: flex;
    gap: 20px;
    margin: 0;
    padding: 0;
}
nav ul li a {
    text-decoration: none;
    color: #5c5470;
    font-weight: bold;
    font-size: 16px;
}
        .auth-buttons {
            position: absolute;
            top: 35px;
            left: 30px; 
            display: flex;
            gap: 10px;
        }
        .auth-buttons a {
            text-decoration: none;
            padding: 8px 60px; 
            color: #fff;
            font-size: 15px; 
            font-weight: bold;
            transition: 0.3s;
           
        }
        .login {
            background-color: #3b5998;
        }
        .register {
            background-color: #ff4d4d;
        }
        .login:hover, .register:hover {
            opacity: 0.9;
        }
        .left-center-text {
            position: absolute;
            top: 45%;
            right: 1px;
            text-align: right;
        }
        .big-black {
    font-size: 70px;
    color: black;
    font-weight: 600;
    font-family: 'Poppins', sans-serif;
}
.small-black {
    font-size: 40px;
    color: black;
    font-weight: 600;
    margin-top: 10px;
    font-family: 'Poppins', sans-serif;
}
        .right-center-text {
            position: absolute;
            top: 45%;
            left: 2px;
            text-align: left;
        }
.big-white {
    font-size: 70px;
    color: white;
    font-weight: 600;
    text-shadow: 1px 1px 3px black;
    font-family: 'Poppins', sans-serif;
}
.small-white {
    font-size: 40px;
    color: white;
    font-weight: 600;
    margin-top: 10px;
    text-shadow: 1px 1px 3px black;
    font-family: 'Poppins', sans-serif;
}
        .menu-button {
            position: absolute;
            top: 52%;
            left: 70%;
            transform: translateX(-50%);
            padding: 14px 30px;
            background-color: #5c5470;
            color: white;
            border: none;
            border-radius: 25px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .menu-button:hover {
            background-color: #443c68;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="left">
        <nav>
            <ul>
                <li><a href="<c:url value='/' />">Home</a></li>
                <li><a href="reservetable">Reserve</a></li>
                <li><a href="menurecomand">Menu</a></li>
                <li><a href="<c:url value='/contact' />">Contact</a></li>
            </ul>
        </nav>
        <div class="left-center-text">
            <div class="big-black">Sha</div>
            <div class="small-black">Resta</div>
        </div>
        <button class="menu-button" onclick="window.location.href='<c:url value="/menu" />'">Menu</button>
    </div>
    <div class="right">
      
        <div class="auth-buttons">
            <a href="gotologin" class="login">Login</a>
            <a href="gotoregister" class="register">Register</a>
        </div>
        <div class="right-center-text">
            <div class="big-white">bu</div>
            <div class="small-white">urant</div>
        </div>
    </div>
</div>
</body>
</html>
