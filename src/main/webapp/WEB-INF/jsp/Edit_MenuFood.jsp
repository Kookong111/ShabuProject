<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>แก้ไขข้อมูลอาหาร</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #222;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Poppins', sans-serif;
            color: #f0f0f0;
        }

        .form-container {
            background-color: #333;
            border-radius: 12px;
            padding: 40px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.6);
            border: none;
            margin-top: 30px;
            margin-bottom: 30px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-weight: 600;
            color: #f0f0f0;
        }

        .form-label {
            color: #f0f0f0;
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control {
            background-color: #444;
            border-radius: 8px;
            border: none;
            color: #fff;
            padding: 12px 15px;
            margin-bottom: 1.5rem;
            transition: background-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }

        .form-control:focus {
            background-color: #555;
            box-shadow: 0 0 10px rgba(200, 200, 200, 0.3);
            outline: none;
        }

        .btn-success {
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.2s;
            padding: 12px 25px;
            width: 48%;
        }

        .btn-danger {
            border-radius: 8px;
            font-size: 1.1rem;
            font-weight: 500;
            transition: background-color 0.3s ease, transform 0.2s;
            padding: 12px 25px;
            width: 48%;
        }


        .btn-success:hover {
            transform: scale(1.02);
        }
        .btn-danger:hover {
            transform: scale(1.02);
        }


        .form-links {
            text-align: center;
            margin-top: 20px;
        }

        .form-links a {
            color: #ccc;
            text-decoration: none;
            font-weight: 500;
        }

        .form-links a:hover {
            text-decoration: underline;
            color: #eee;
        }

        .success-message {
            font-size: 1.1rem;
            color: #28a745;
            text-align: center;
            font-weight: bold;
            margin-top: 20px;
        }

        hr {
            border-color: #555;
            margin-top: 30px;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>แก้ไขข้อมูลอาหาร</h2>
<div class="result-message">
            <div class="success-message">${add_result}</div>
            <h2 class="text-danger">${error_result}</h2>
        </div>
        <form name="frm1" action="confirmEditMenuFood" method="post">
         <input type="hidden" name="foodId" value="${menu.foodId}" />
            <div class="mb-3">
                <label for="foodname" class="form-label">ชื่อ</label>
                <input type="text" class="form-control" id="foodname" name="foodname" value="${menu.foodname}" >
            </div>

            <div class="mb-3">
                <label for=price class="form-label">ราคา</label>
                <input type="text" class="form-control" id="price" name="price" value="${menu.price}">
            </div>

            <div class="mb-3">
    <label for="foodImage" class="form-label">รูป</label>
    <input type="url" class="form-control" id="foodImage" name="foodImage" value="${menu.foodImage}">

    <c:if test="${not empty menu.foodImage}">
        <div class="text-center mt-3">
            <img src="${menu.foodImage}" alt="Preview Image" style="max-width: 50%; height: 50%; border-radius: 8px;" />
        </div>
    </c:if>
</div>


			 <div class="mb-3">
                <label for="type" class="form-label">ประเภท</label>
               <select class="form-control form-control-select" id="type" name="type">
    <c:forEach var="ft" items="${foodTypes}">
        <option value="${ft.foodtypeName}">${ft.foodtypeName}</option>
    </c:forEach>
</select>

            </div>
            
            <div class="d-flex justify-content-center gap-2">  <button type="submit" class="btn btn-success">บันทึก</button>
                <button type="reset" class="btn btn-danger">รีเซ็ต</button>
            </div>

             <div class="result-message">
                 <font color="red"></font>
            </div>
        </form>

        <hr>

        <div class="form-links">
            <a href="ListAllMenuFood">กลับหน้าหลัก</a>
        </div>
    </div>
</body>
</html>