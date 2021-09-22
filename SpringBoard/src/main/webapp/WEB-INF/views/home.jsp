<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello World</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="./css/index.css">
<script type="text/javascript">
</script>
<style>
		.boardBox{width:47%;margin:1.5%;float:left;}
			.boardBox h2{width:100%;height:35px;line-height:16px;font-size:16px;font-weight:600;border-bottom:1px solid #eee;padding-bottom:5px;}
				.boardBox h2 img{display:inline-block;width:22px;height:22px;vertical-align:middle;}
			.boardBox ul{width:100%;height:34px;border-bottom:1px solid #eee;border-right:1px solid #eee;cursor:pointer;transition:0.3s;}
			.boardBox ul:hover{background-color:#D6EAF8}
				.boardBox ul li{height:35px;line-height:42px;float:left;overflow:hidden;font-size:12px;}
				.boardBox ul li:first-child{width:54%;text-indent:15px;border-left:5px solid #ccc;border-radius:5px 0 0 5px;font-size:14px;line-height:35px;text-align:left;}
				.boardBox ul li:nth-child(2){width:20%; text-align: center;}
				.boardBox ul li:nth-child(3){width:12%;}
					.boardBox ul li:nth-child(3) img{height:15px;float:left;padding-top:12px;padding-right:1px;}
				.boardBox ul li:last-child{width:12%;}
				#container{padding-bottom: 400px;}
</style>
</head>
<body>
<div id="wrapper">
	<header>
		<jsp:include page="./header.jsp"></jsp:include>
		<c:import url="/menu"/>
	</header>
	<main id="container">
		<div id="weeklyBest" class="boardBox">
			<h2><img alt="위클리 베스트" src="./img/best.png">&nbsp;&nbsp;Weekly Best</h2>
			<c:forEach items="${weekList }" var="wl" >
					<ul class="main" onclick="location.href='./detail?sb_no=${wl.sb_no}&sb_cate=${wl.sb_cate }'">
						<li class="title">${wl.sb_title}</li>
						<li>${wl.sm_name}</li>
						<li><img alt="좋아요" src="./img/like.png">${wl.sb_tlike}</li>
						<li><c:if test="${wl.sb_ddate eq 0}">오늘</c:if>
						<c:if test="${wl.sb_ddate ne 0}">${wl.sb_ddate }일 전</c:if>
						</li>
					</ul>
				</c:forEach>			
		</div>
		<c:forEach items="${categoryList }" var="cl">
			<div class="boardBox">
				<h2><img alt="${cl.sca_category }" src="./img/home_img${cl.sb_cate }.png">&nbsp;&nbsp;${cl.sca_category }</h2>
			
			<c:choose>
				<c:when test="${cl.sb_cate eq 1 }">
				<c:forEach items="${bestList1 }" var="bl" >
				
					<ul class="main" onclick="location.href='./detail?sb_no=${bl.sb_no}&sb_cate=${bl.sb_cate }'">
						<li class="title">${bl.sb_title}</li>
						<li>${bl.sm_name}</li>
						<li><img alt="좋아요" src="./img/like.png">${bl.sb_tlike}</li>
						<li><c:if test="${bl.sb_ddate eq 0}">오늘</c:if>
						<c:if test="${bl.sb_ddate ne 0}">${bl.sb_ddate }일 전</c:if>
						</li>
					</ul>
				</c:forEach>
				</c:when>
				<c:when test="${cl.sb_cate eq 2 }">
					<c:forEach items="${bestList2 }" var="bl" >
					<ul class="main" onclick="location.href='./detail?sb_no=${bl.sb_no}&sb_cate=${bl.sb_cate }'">
						<li class="title">${bl.sb_title}</li>
						<li>${bl.sm_name}</li>
						<li><img alt="좋아요" src="./img/like.png">${bl.sb_tlike}</li>
						<li><c:if test="${bl.sb_ddate eq 0}">오늘</c:if>
						<c:if test="${bl.sb_ddate ne 0}">${bl.sb_ddate }일 전</c:if>
						</li>
					</ul>
					</c:forEach>
				</c:when>
					<c:when test="${cl.sb_cate eq 3 }">
					<c:forEach items="${bestList3 }" var="bl" >
					<ul class="main" onclick="location.href='./detail?sb_no=${bl.sb_no}&sb_cate=${bl.sb_cate }'">
						<li class="title">${bl.sb_title}</li>
						<li>${bl.sm_name}</li>
						<li><img alt="좋아요" src="./img/like.png">${bl.sb_tlike}</li>
						<li><c:if test="${bl.sb_ddate eq 0}">오늘</c:if>
						<c:if test="${bl.sb_ddate ne 0}">${bl.sb_ddate }일 전</c:if>
						</li>
					</ul>
					</c:forEach>
				</c:when>
			</c:choose>
			</div>
		</c:forEach>
		</main>
		<footer>
		<c:import url="footer.jsp"/>
		</footer>
</div>
</body>
</html>