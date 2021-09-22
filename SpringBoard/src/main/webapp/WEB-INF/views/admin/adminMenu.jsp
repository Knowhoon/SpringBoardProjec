<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h1>
	<span>관리자 메뉴</span>
</h1>
<nav>
	<ul>		
		<li><a class="navHover" href="../home">메인</a></li>
		<li><a class="navHover" href="./memberList">회원확인</a></li>
		<li><a class="navHover" href="./logList">로그확인</a></li>
		<li><a class="navHover" href="./category">카테고리</a></li>
		<c:if test="${sessionScope.sm_id ne null }">
		<li>		
		<img alt="프로필" src=
		<c:if test="${sessionScope.userImg ne null }">
		"${sessionScope.userImg }"
		</c:if>
		<c:if test="${sessionScope.userImg eq null }">
		"../img/info.png"
		</c:if>
		 style="height: 33px;vertical-align: middle;">
		${sessionScope.sm_name }님 환영합니다.	
		<button id="logout" onclick="location.href='../logout'" style="cursor:pointer;">로그아웃</button>
		</li>
		</c:if>
	</ul>
</nav>
</html>