<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Our Menu</title>
    <style>
        /* Basic CSS - You can expand this */
        body {
            font-family: sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 960px;
            margin: 20px auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
            color: #e74c3c;
        }

        .menu-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); /* Responsive grid */
            gap: 20px;
            margin-top: 20px;
        }

        .menu-item {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            background-color: #fff;
        }

        .menu-item img {
            max-width: 100%;
            height: auto;
            border-radius: 8px 8px 0 0;
            margin-bottom: 10px;
        }

        .menu-item h2 {
            font-size: 1.5em;
            color: #333;
            margin-bottom: 5px;
        }

        .menu-item p {
            color: #555;
            font-size: 1em;
        }

        .menu-item .price {
            font-weight: bold;
            color: #e74c3c;
            margin-top: 10px;
        }
    </style>
</head>
<body>
		<a href="Homecustomer" style="
		    ">← Back to Home</a>
    <div class="container">
        <h1>Our Delicious Menu</h1>

        <div class="menu-grid">
			 <c:forEach items="${menuItems}" var="item">
			    <div class="menu-item">
			        <img src="${item.foodImage}" alt="${item.foodname}">
			        <h2>${item.foodname}</h2>

			    </div>
			</c:forEach>

        </div>
    </div>

</body>
</html>