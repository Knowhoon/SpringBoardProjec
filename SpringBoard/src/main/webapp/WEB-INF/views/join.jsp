<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>join</title>
<link href="./resources/css/index.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.point {
	color: #333;
	font-size: 12px;
}

.tip {
	color: #ff2300;
	font-size: 12px;
}

caption {
	display: none;
}

#joinForm {
	width: 100%;
	margin: 0 auto;
}

fieldset {
	border: none;
	width: 100%;
}

.f1 {
	min-height: 420px;
	padding-bottom: 10px;
}

.dataView table {
	width: 100%;
	border-bottom: 2px solid #ccc;
	border-collapse: collapse;
}

.dataView th {
	width: 99px;
	height: 44px;
	border-top: 1px solid #ccc;
	text-align: left;
}

.dataView td {
	padding: 5px 10px;
	border-top: 1px solid #ccc;
}

.dataView tr:first-child th, .dataView tr:first-child td {
	border-top: 2px solid #aaa;
}

.dataView th label {
	width: 120px;
	display: block;
	padding: 10px 0 5px 10px;
}

.dataView td span {
	padding: 0 10px;
}

.dataView td p {
	margin: 4px 0 3px;
}

.dataView td input {
	width: 188px;
	height: 25px;
	padding: 5px 0 4px 10px;
}

.dataView td input[type="button"] {
	width: 120px;
    vertical-align: middle;
    height: 25px;
    padding: 5px 0 4px 0px;
}

.doubleChk {
	display: inline-block;
	font-weight: bold;
	padding: 5px 10px;
	font-size: 12px;
	border: 1px solid gray;
	background-color: #eee;
	cursor: pointer;
}

#emailChk2, #phoneChk2 {
	display: none;
}

#phone2, #sm_email2 {
	margin-top: 4px;
}

.btnCenter {
	text-align: center;
	padding-top: 10px;
}

.btnCenter button {
	width: 105px;
	height: 28px;
	font-weight: bold;
}

.f1:after {
	content: "";
	display: block;
	clear: both;
}

.f2, .f3 {
	width: 407px;
	height: 315px;
}

.f2 {
	float: left;
}

.f3 {
	float: right;
}

.agreeText {
	text-align: right;
}

fieldset textarea {
	width: 308px;
	height: 50px;
	font-size: 11px;
	color: #8f785c;
	line-height: 16px;
	padding: 5px 10px;
}
</style>
<script>
$(document).ready(function(){
	//공백 체크
	var empJ = /\s/g;
	//아이디 중복확인
    $("#sm_id").keyup(function() {    	
		var sm_id = $('#sm_id').val();
		var idJ = /^[A-za-z0-9]{4,10}$/g; //영문 대문자 또는 소문자 또는 숫자로 시작하는 아이디, 길이는 5~15자, 끝날때 영문 대문자 또는 소문자 또는 숫자
		if(sm_id == ""){
			$(".successIdChk").text("필수 정보입니다.");
			$(".successIdChk").css("color", "red");
			$("#idDoubleChk").val("false");
		} else if(empJ.test(sm_id)){
			$(".successIdChk").text("아이디에 공백이 포함될 수 없습니다.");
			$(".successIdChk").css("color", "red");
			$("#idDoubleChk").val("false");			
		} else if(sm_id.length < 4 || !idJ.test(sm_id)){
			$(".successIdChk").text("4~10자의 영문 소문자, 숫자와 특수기호(_)만 사용 가능합니다.");
			$(".successIdChk").css("color", "red");
			$("#idDoubleChk").val("false");
		}		
		else{			
			$.ajax({
				url : 'checkID?sm_id='+ sm_id,
				type : 'post',
				cache : false,
				success : function(data) {
					if (data == 0) {
						$(".successIdChk").text("멋진 아이디네요!");
						$(".successIdChk").css("color", "green");
						$("#idDoubleChk").val("true");
					} else {
						$(".successIdChk").text("사용중인 아이디입니다.");
						$(".successIdChk").css("color", "red");
						$("#idDoubleChk").val("false");
					}
				}, error : function() {
					console.log("실패");
				}
			});
		}
	});
	//이름 체크
    $("#username").keyup(function(){
    	var sm_name = $("#username").val();
    	var nameJ = /^[가-힣]{2,6}$|[a-zA-Z]{4,10}$/;

    	if(sm_name == ""){
    		$(".successNameChk").text("필수 정보입니다.");
			$(".successNameChk").css("color", "red");
			$("#nameDoubleChk").val("false");
    	} else if(empJ.test(sm_name)){
			$(".successNameChk").text("이름에 공백이 포함될 수 없습니다.");
			$(".successNameChk").css("color", "red");
			$("#nameDoubleChk").val("false");			
    	} else if(!nameJ.test(sm_name)){
			$(".successNameChk").text("한글(2~6자) 영문(4~12자)의 이름만 사용 가능합니다.");
			$(".successNameChk").css("color", "red");
			$("#nameDoubleChk").val("false");		
		}else{    		
    		$(".successNameChk").text("멋진 이름이네요!");
    		$(".successNameChk").css("color", "green");
			$("#nameDoubleChk").val("true");
    	}
    });

	//비밀번호 확인
	$("#userpass").keyup(function(){
		var pw = $("#userpass").val();
		var pw2 = $("#userpasschk").val();
		var pattern1 = /[0-9]/;
	    var pattern2 = /[a-zA-Z]/;
        var pattern3 = /[~!@\#$%<>^&*]/;// 원하는 특수문자 추가 제거
        if(!pattern1.test(pw)||!pattern2.test(pw)||!pattern3.test(pw)||pw.length<8||pw.length>16){
			$(".userpass").text("8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요.");
			$(".userpass").css("color", "red");
			$("#pwDoubleChk").val("false");			
		}else{
			$(".userpass").empty();
			$("#pwDoubleChk").val("true");
		}
	});
	
	$("#userpasschk").keyup(function(){		
		if($("#userpasschk").val() != $("#userpass").val()){
			$(".successPwChk").text("비밀번호가 일치하지 않습니다.");
			$(".successPwChk").css("color", "red");
			$("#pwDoubleChk").val("false");
		} else{
			$(".successPwChk").text("비밀번호가 일치합니다.");
			$(".successPwChk").css("color", "green");
			$("#pwDoubleChk").val("true");
		}
	});
	//이메일 확인
	
	$("#sm_email").keyup(function(){
		var sm_email = $("#sm_email").val();
		var mailJ = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;

        if(!mailJ.test(sm_email)){
			$(".successEmailChk").text("이메일 주소를 다시 확인해주세요.");
			$(".successEmailChk").css("color", "red");
			$("#emailChk").attr("disabled",true);
			$("#sendEmail").attr("disabled",true);	
		}else{
			$.ajax({
		        type:"POST",
		        url:"checkEmail?sm_email=" + sm_email,
		        cache : false,
		        success:function(data){
		        	if(data == 1){
						$("#sm_email").attr("autofocus",true);
						$(".successEmailChk").text("이미 가입된 이메일 주소입니다. 다른 이메일 주소를 입력해주세요.");
						$(".successEmailChk").css("color","red");
		        	} else {
		        		$("#sendEmail").attr("disabled",false);	        		
		        		$(".successEmailChk").text("이메일 인증번호 전송 후 인증해주세요.");
		        		$(".successEmailChk").css("color","green");
		        	}
		        }
		    });
		}
	});
	
	$("#emailChk").click(function(){
		var sm_email = $("#sm_email").val();
		$.ajax({
	        type:"POST",
	        url:"checkEmail?sm_email=" + sm_email,
	        cache : false,
	        success:function(data){
	        	if(data == 1){
					$("#sm_email").attr("autofocus",true);
					$(".successEmailChk").text("이미 가입된 이메일 주소입니다. 다른 이메일 주소를 입력해주세요.");
					$(".successEmailChk").css("color","red");
	        	} else {
	        		$("#sendEmail").attr("disabled",false);	        		
	        		$(".successEmailChk").text("이메일 인증번호 전송 후 인증해주세요.");
	        		$(".successEmailChk").css("color","green");
	        	}
	        }
	    });
	});
	//이메일 인증
	var code = "";
	$("#sendEmail").click(function(){
		var sm_email = $("#sm_email").val();
		$(".successSendChk").text("이메일 전송 중입니다. 잠시만 기다려주세요.");
		$(".successSendChk").css("color","green");
		$("#sendEmail").attr("disabled",true);
		$.ajax({
	        type:"POST",
	        url:"emailConfirm?sm_email=" + sm_email,
	        cache : false,
	        success:function(data){
	        	if(data == "error"){
	        		alert("이메일 전송에 실패했습니다. 이메일 주소를 확인 또는 관리자에게 문의하세요.");
					$("#sm_email").attr("autofocus",true);
					$(".successEmailChk").text("이메일 전송에 실패했습니다. 이메일 주소를 확인 또는 관리자에게 문의하세요.");
					$(".successEmailChk").css("color","red");
					$("#emailChk").attr("disabled",false);
					$("#sendEmail").attr("disabled",false);	
	        	} else {
					alert("인증번호 발송이 완료되었습니다.\n입력한 이메일에서 인증번호를 확인을 해주세요.");
	        		$("#sm_email2").attr("disabled",false);
	        		$("#emailChk2").css("display","inline-block");
	        		$(".successEmailChk").text("인증번호를 입력 후 인증 버튼을 눌러주세요.");
	        		$(".successEmailChk").css("color","green");
	        		$("#sm_email").attr("readonly",true);
	        		code = data;
	        	}
	        }
	    });
	});
	//이메일 인증번호 확인
	$("#emailChk2").click(function(){
		if($("#sm_email2").val() == code){
			$(".successEmailChk").text("인증번호가 일치합니다.");
			$(".successEmailChk").css("color","green");
			$("#emailDoubleChk").val("true");
		}else{
			$(".successEmailChk").text("인증번호가 일치하지 않습니다. 다시 입력해 주세요.");
			$(".successEmailChk").css("color","red");
			$("#emailDoubleChk").val("false");
			$("#sm_email2").attr("autofocus",true);
		}
	});
	//생년 월일 확인
   $("#birthDate").keyup(function(){
    	var sm_birthdate = $("#birthDate").val();
    	var dateJ = /^\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])$/;
		var date = new Date();  
		var today = date.getFullYear()+'-'+("0" + (1 + date.getMonth())).slice(-2)+'-'+("0" + date.getDate()).slice(-2);
    	if(sm_birthdate == ""){
    		$(".successDateChk").text("필수 정보입니다.");
			$(".successDateChk").css("color", "red");
			$("#dateDoubleChk").val("false");
    	} else if(!dateJ.test(sm_birthdate)){
			$(".successDateChk").text("생년월일을 확인해주세요.");
			$(".successDateChk").css("color", "red");
			$("#dateDoubleChk").val("false");		
		} else if(sm_birthdate > today){
			$(".successDateChk").text("미래에서 오셧군요.^^ 생년월일을 확인해주세요.");
			$(".successDateChk").css("color", "red");
			$("#dateDoubleChk").val("false");	
		} else {    		
			$(".successDateChk").empty();
			$("#dateDoubleChk").val("true");
    	}
    });
    //최종 틍록하기 버튼 클릭시 각 부분별 입력값 맞는지 확인
    $("#button1").click(function(){
	    if($("#nameDoubleChk").val() == "true" && $("#idDoubleChk").val() == "true" && $("#pwDoubleChk").val() == "true" && $("#emailDoubleChk").val() == "true" && $("#dateDoubleChk").val() == "true"){
	    	alert($('#sm_id').val()+"님 가입을 환영합니다.");
	    }else{
	    	alert("회원가입을 완료할 수 없습니다. 다시한번 확인해주세요.");
	    	if($("#idDoubleChk").val() != "true"){
	    		$(".successIdChk").text("아이디를 입력해주세요.");
				$(".successIdChk").css("color", "red");
	    	}
	    	if($("#nameDoubleChk").val() != "true"){
	    		$(".successNameChk").text("이름를 입력해주세요.");
				$(".successNameChk").css("color", "red");
	    	}
	    	if($("#pwDoubleChk").val() != "true"){
	    		$(".successPwChk").text("비밀번호가 일치하지 않습니다.");
				$(".successPwChk").css("color", "red");
	    	}
	    	if($("#emailDoubleChk").val() != "true"){
	    		$(".successEmailChk").text("이메일 인증을 해주세요.");
				$(".successEmailChk").css("color", "red");
	    	}
	    	if($("#dateDoubleChk").val() != "true"){
	    		$(".successDateChk").text("생년월일을 확인을 해주세요.");
				$(".successDateChk").css("color", "red");
	    	}
	    	return false
	    }    	    	
    });
});
</script>
</head>
<body>
	<div id="wrapper">


		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<script>
$(function(){
	$("#logOut").click(function(){
		if(!confirm("로그아웃 하시겠습니까?")){
			return false;
		}
	});
});
</script>
		<header>
			<jsp:include page="./header.jsp"></jsp:include>
			<c:import url="/menu" />
		</header>
		<main id="container">
			<form id="joinForm" action="./join" method="post">
				<fieldset class="fieldarea f1">
					<h2>회원 정보 입력</h2>
					<br>
					<div class="dataView">
						<table title="이름, 아이디, 비밀번호, 이메일 등의 정보입력">
							<caption>기본정보입력</caption>
							<tbody>
								<tr>
									<th><label for="userid">아이디</label></th>
									<td><input id="sm_id" type="text" name="sm_id"
										placeholder="아이디를 입력해주세요." maxlength="10" required autofocus />
										<span class="point successIdChk"></span><br /> <span
										class="point">영문자, 숫자, _ 만 입력 가능. 최소 4자 이상 입력하세요.</span> <input
										type="hidden" id="idDoubleChk" /></td>
								</tr>
								<tr>
									<th><label for="username">이&emsp;름</label></th>
									<td><input id="username" type="text" name="sm_name"
										placeholder="이름을 설정해주세요." maxlength="12" title="8자 까지 입력"
										required /> <span class="point successNameChk">한글 이름은 (2~6)자 영문 이름은 (4~12)자로 설정해주세요.</span>
										<input type="hidden" id="nameDoubleChk" />
									</td>
								</tr>

								<tr>
									<th><label for="userpass">비밀번호</label></th>
									<td><input id="userpass" type="password" name="sm_pw"
										required maxlength="15" autocomplete="off" /> <span
										class="point userpass">※ 비밀번호는 총 15자 까지 입력가능</span></td>
								</tr>
								<tr>
									<th><label for="userpasschk">비밀번호 확인</label></th>
									<td><input id="userpasschk" type="password"
										name="sm_pw_chk" placeholder="동일하게 입력해주세요." required
										maxlength="15" autocomplete="off" /> <span
										class="point successPwChk"></span> <input type="hidden"
										id="pwDoubleChk" /></td>
								</tr>
								<tr class="email">
									<th><label for="useremail">이메일</label></th>
									<td>
										<p>
										<input id="sm_email" type="text" name="sm_email" title="이메일 주소를 입력해주세요." required/>
										&nbsp;<input type="button" id="sendEmail" class="doubleChk" disabled="disabled" value="인증번호 보내기" />
										<span class="point successSendChk"></span>
										<br/>
										<input id="sm_email2" type="text" name="sm_email2" title="인증번호 입력" disabled required/>
										<span id="emailChk2" class="doubleChk">인증번호확인</span>
										<span class="point successEmailChk">이메일 입력후 인증번호 보내기를 해주세요.</span>
										<input type="hidden" id="emailDoubleChk"/>
										</p>
										<p class="tip">아이디 비밀번호 분실시 필요한 정보이므로, 정확히 기입해 해주세요.</p>
									</td>
								</tr>
								<tr class="birthDate">
									<th><label for="birthDate">생년월일</label></th>
									<td>
										<p>
											<input id="birthDate" type="date" name="sm_birthdate"
												title="생년월일 입력" required />
												<span class="point successDateChk"></span>
												<input type="hidden" id="dateDoubleChk"/>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="btnCenter">
						<button type="submit" id="button1" value="회원가입">회원가입</button>
						<button onclick="location.href='./home'" id="button2" value="취소">취소</button>
					</div>
				</fieldset>
			</form>
		<footer>
		<c:import url="footer.jsp"/>
		</footer>
		</main>
	</div>
</body>
</html>
