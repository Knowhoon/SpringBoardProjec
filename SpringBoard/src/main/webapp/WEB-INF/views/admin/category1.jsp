<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cateogry</title>
</head>
<body>
	<c:forEach items="${category }" var="c">
		${c.sca_no } | ${c.sca_category } | 
		<a href="./categoryUpdate?sca_no=${c.sca_no }">[수정]</a>
		<c:choose>
		<c:when test="${c.sca_visible eq 0 }"><a href="./categoryVisible?sca_no=${c.sca_no }&sca_visible=1"><img alt="off" src="../img/off.png"></a></c:when>
		<c:otherwise>
		<a href="./categoryVisible?sca_no=${c.sca_no }&sca_visible=0"><img alt="on" src="../img/on.png"></a>
		</c:otherwise>
		</c:choose>
		<a href="./categoryVisible?sca_no=${c.sca_no }"></a>
		<br>
	</c:forEach>
	//추가
	<form action="./category" method="post">
		<input type="text" name="categoryName">
		<button type="submit">등록</button>
	</form>
	

</body>
</html>