<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cateogry Update</title>
</head>
<body>
	<h1>수정하기</h1>
	<div>
		<form action="./categoryUpdate" method="post">
			<input type = "text" name="sca_category" value = "${cate.sca_category }">
			<input type = "hidden" name="sca_no" value = "${cate.sca_no }">
			<button type = "submit">수정하기</button>
			
		</form>
			<button onclick="location.href='./category'">취소</button>
	
	</div>
	

</body>
</html>