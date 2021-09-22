<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="menu"><h1>
	<c:choose>
		<c:when test="${category eq null }">&nbsp;&nbsp;&nbsp;Knowhoon Web Board</c:when>
		<c:otherwise>&nbsp;&nbsp;&nbsp;${category }</c:otherwise>
	</c:choose></h1>
</div>
<nav>
	<ul>
		<li><a class="navHover" href="./home">메인</a>
		</li>
		<c:forEach items="${categoryList }" var="cl">
			<li><a class="navHover" href="./board?sb_cate=${cl.sca_no }">${cl.sca_category }</a>
			</li>
		</c:forEach>
		<li><c:if test="${sessionScope.sm_id eq null }">
				<a class="navHover" href="./login">로그인</a>
			</c:if></li>
		<c:if test="${sessionScope.sm_grade eq 9 }">
				<li><a class="navHover" href="./admin/memberList">관리자메뉴</a></li>
		</c:if>
		<li>
		<c:if test="${sessionScope.sm_id ne null }">
		<li>		
		<img alt="프로필" src=
		<c:if test="${sessionScope.userImg ne null }">
		"${sessionScope.userImg }"
		</c:if>
		<c:if test="${sessionScope.userImg eq null }">
		"./img/info.png"
		</c:if>
		 style="height: 33px;vertical-align: middle;">
		${sessionScope.sm_name }님 환영합니다.	
		<button id="logout" onclick="location.href='./logout'" style="cursor:pointer;">로그아웃</button>
		</li>
		</c:if>
	</ul>
</nav>
</html>