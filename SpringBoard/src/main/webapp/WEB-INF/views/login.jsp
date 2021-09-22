<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<link href="./resources/css/index.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
#login{
margin-top: 100px;
}
input {
	display: block;
	width: 280px;
	height: 20px;
	line-height: 40px;
	padding: 10px;
	margin: 10px auto;
}

button {
	display: block;
	width: 180px;
	margin: 20px auto;
	height: 40px;
	letter-spacing: 4px;
	font-size: 17px;
	cursor: pointer;
}

button:hover {
	background-color: #ccc;
}

#join {
	width: 100%;
	text-align: center;
}
#kakao {
	text-align: center;
    margin-bottom: 10px;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
$(function(){
	if( != null){
		alert("아이디 또는 패스워드가 올바르지 않습니다.\n다시 시도해주십시오.");
		$("#sm_id").val("");
		$("#sm_id").focus();
		history.replaceState({}, null, "./?login=again");
	};
});
$(function(){
	$("#logOut").click(function(){
		if(!confirm("로그아웃 하시겠습니까?")){
			return false;
		}
	});
});
</script>
</head>
<body>
	<div id="wrapper">
		<header>
		<jsp:include page="./header.jsp"></jsp:include>
		<c:import url="/menu"/>
		</header>
		<main id="container">
			<div id="login">
				<form action="./login" method="post">
					<input type="text" id="sm_id" name="sm_id"
						placeholder="아이디를 입력해주세요." required autofocus /> <input
						type="password" id="sm_pw" name="sm_pw"
						placeholder="패스워드를 입력해주세요." required />
					<button type="submit"><b>로그인</b></button>
					
				</form>
				<div id = kakao>
				<a href="./kakaoLogin"><img alt="카카오로그인" src="./img/kakaoLogin.png"></a>
			    </div>
				<div id="join">
					<a href="./join">회원가입</a> | <a href="">ID/PW 찾기</a>
				</div>
			</div>
		<footer>
		<c:import url="footer.jsp"/>
		</footer>
		</main>
	</div>
</body>
</html>