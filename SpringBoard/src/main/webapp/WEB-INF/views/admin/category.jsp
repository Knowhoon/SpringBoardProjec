<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello World</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="../css/index.css">
<style type="text/css">
h1{line-height:100px;background-color:#f7f7f7;}		
		h1 span{display:block;width:1200px;margin:0 auto;text-align:left;}
nav{width:1200px;margin:0 auto;overflow:hidden;padding-bottom:10px;}
#container{width:800px; margin:0 auto;padding-top:20px;font-size:15px;font-family:'맑은 고딕';}
	.title{overflow:hidden;text-align:center;border-bottom:1px solid #ccc;height:50px;line-height:50px;}
		.title li{text-align: center;}
		.title li:first-child{width:20%;}
		.title li:nth-child(2){width:40%;}
		.title li:nth-child(3){width:20%;}
		.title li:last-child{width:20%;}
	#subTitle{margin-bottom:5px;font-weight:600;background-color:#F7F7F7;border-top:2px solid #444;color:#444;}
	#main {transition:0.3s all;cursor:pointer; text-align: center;}
	#main:hover{background-color:#EBF5FB;}
	#mainTitle{font-size:14px;font-family:'맑은 고딕';}
	#modify{float: right; margin-right: 10px; margin-top: 10px;}
#bbottom{width:990px;min-height:500px;padding:10px;margin-bottom:0px;text-align:left;}

</style>
<script type="text/javascript">
function gradeModify(sm_no, sm_grade, code){
	if(code == 'up'){
		if(confirm("해당 회원 등급을 올리시겠습니까?")){
			location.href="./gradeModify?code=" + code + "&sm_no=" + sm_no + "&sm_grade=" + sm_grade;
		}
	} else if(code == 'down'){
		if(confirm("해당 회원 등급을 내리시겠습니까?")){
			location.href="./gradeModify?code=" + code + "&sm_no=" + sm_no + "&sm_grade=" + sm_grade;
		}
	}
}
function userDelete(sm_no){	
	if(confirm("해당 회원을 삭제 하시겠습니까?")){
		location.href="./userDelete?sm_no=" + sm_no;
	}
	
}
</script>
</head>
<body>
<div id="wrapper">
	<header>
		<jsp:include page="../header.jsp"/>
		<c:import url="./adminMenu.jsp"/>
	</header>
	<main id="container">
		<ul id="subTitle" class="title">
			<li>번호</li>
			<li>게시판</li>
			<li>이름 수정</li>
			<li>게시판 노출 여부</li>
		</ul>
		<c:forEach items="${category }" var="c">
		<ul id="main" class="title" 
					<c:if test="${c.sca_visible eq 1 }">style="background-color: #c0c0c0"</c:if>										
					>
					<li>${c.sca_no }</li>
		<li>${c.sca_category }</li>
		<li><a href="./categoryUpdate?sca_no=${c.sca_no }">이름 수정</a></li>
		<li>
		<c:choose>
		<c:when test="${c.sca_visible eq 0 }"><a href="./categoryVisible?sca_no=${c.sca_no }&sca_visible=1"><img alt="on" src="../img/on.png"></a></c:when>
		<c:otherwise>
		<a href="./categoryVisible?sca_no=${c.sca_no }&sca_visible=0"><img alt="off" src="../img/off.png"></a>
		</c:otherwise>
		</c:choose>
		</li>
		</ul>
	</c:forEach>
	게시판 추가
	<form action="./category" method="post">
		<input type="text" name="categoryName">
		<button type="submit">등록</button>
	</form>
	
	</main>
	<footer></footer>
</div>
</body>
</html>