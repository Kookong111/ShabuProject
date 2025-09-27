<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="com.springmvc.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
                <h1>Welcome I kuy</h1>
                <h2>คุณ ${user.empUsername}</h2>
             	<h2>ชื่อ ${user.empname}</h2>
             	<h2>ตำแหน่ง ${user.position}</h2>
             	


<form action="listTableReserveForCashier" method="POST"><button>ไปหน้าข้อมูลการจองโต๊ะ</button></form>
             	
             	
</body>
</html>