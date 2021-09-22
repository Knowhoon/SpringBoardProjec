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
#container{width:1200px; margin:0 auto;padding-top:20px;font-size:15px;font-family:'맑은 고딕';}
	.title{overflow:hidden;text-align:center;border-bottom:1px solid #ccc;height:35px;line-height:35px;}
		.title li{text-align: center;}
		.title li:first-child{width:6%;}
		.title li:nth-child(2){width:10%;}
		.title li:nth-child(3){width:8%;}
		.title li:nth-child(4){width:25%;}
		.title li:nth-child(5){width:20%;}
		.title li:nth-child(6){width:15%;}
		.title li:nth-child(7){width:8%;}
		.title li:last-child{width:8%;}
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
			<li>아이디</li>
			<li>이름</li>
			<li>이메일</li>
			<li>가입날짜</li>
			<li>생년월일</li>
			<li>등급</li>			
			<li>삭제</li>			
		</ul>
		<c:choose>
			<c:when test="${fn:length(memberList) gt 0 }">
				<c:forEach items="${memberList }" var="l">
					<ul id="main" class="title" 
					<c:if test="${l.sm_grade lt 5 }">style="background-color: #c0c0c0"</c:if>										
					>
						<li>${l.sm_no }</li>
						<li>${l.sm_id }</li>
						<li>${l.sm_name }</li>
						<li>${l.sm_email }</li>						
						<li>${l.sm_joindate }</li>
						<li>${l.sm_birthdate }</li>
						<li><button <c:if test="${l.sm_grade eq 0}">disabled="disabled</c:if> onclick="gradeModify(${l.sm_no}, ${l.sm_grade}, 'down')">◀</button>
						${l.sm_grade }
						<button <c:if test="${l.sm_grade eq 9}">disabled="disabled</c:if> onclick="gradeModify(${l.sm_no}, ${l.sm_grade }, 'up')">▶</button></li>
						<li><img alt="delete" src="../img/user_delete.png" onclick="userDelete(${l.sm_no})"> </li>
					</ul>
				</c:forEach>
			</c:when>
			<c:otherwise>
				출력할 내용이 없습니다.<br/><br/>
			</c:otherwise>
		</c:choose>
	</main>
	<footer></footer>
</div>
</body>
</html>