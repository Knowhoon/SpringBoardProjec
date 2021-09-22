<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>

<link rel="stylesheet" href="./css/index.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
#container{width: 1000px; margin:auto;}
	#writeArea{width:1000px;min-height:650px;overflow:hidden;clear:both;padding-bottom:10px;}
			#writeArea p{height:50px;line-height:50px;margin-bottom:20px;}
				#title input{width:976px;height:40px;font-size:17px;font-weight:600;padding:10px;}
				#wcontent{width:100%;clear:both;}
				#textC{width:100%;}
				#textC textarea{width:978px;min-height:500px;resize:none;padding:10px;}
				#wcontent .filebox{width:100%;height:30px;text-align:left;margin-top: 10px;}
				#writeSub {float:right; padding: 5px 15px;cursor:pointer;font-weight:600;font-size:17px;background-color:#f7f7f7; vertical-align: middle; border: 1px solid #ebebeb; border-radius: 5px;}
				#wsBtn {float:right; padding: 5px 15px;cursor:pointer;font-weight:600;font-size:17px;background-color:#f7f7f7; vertical-align: middle; border: 1px solid #ebebeb; border-radius: 5px;}
				#writeSub:hover{background-color:#ccc;}

.bbox input[type="file"] {width: 0;height: 0;padding: 0;overflow: hidden;border: 0;}
.bbox label {display: inline-block;padding: 10px 20px;color: #999;vertical-align: middle;background-color: #fdfdfd;cursor: pointer;border: 1px solid #ebebeb;border-radius: 5px;}
/* named upload */
.bbox .upload{display: inline-block;width:400px;height: 35px;font-size:18px; padding: 0 10px;vertical-align: middle;background-color: #f5f5f5;border: 1px solid #ebebeb;border-radius: 5px;color:#999;}

</style>
<script>
$(document).ready(function(){
	$("#file").on('change',function(){
	  var fileName = $("#file").val();
	  $(".upload").val(fileName);
	});
	$("#wsBtn").click(function(){
		if(confirm("글 작성을 완료하시겠습니까?")){			
		}else{
			return false;
		}
	});
});
</script>
</head>
<body>
	<div class = "Wrapper">
		<header>
		<jsp:include page="./header.jsp"></jsp:include>
		<c:import url="/menu"/>
		</header>
		<div id = "container">
			<form action="./write" method="post" enctype="multipart/form-data">
				<div id="writeArea">
					<p id="title">
						<input type="text" name="sb_title" placeholder="제목을 입력하세요.">
					</p>
					<div id="wcontent">
						<div id="textC">
							<textarea name="sb_content" placeholder="내용을 입력하세요."></textarea>
						</div>
						<div class="bbox"> 
							<label for="file">업로드</label> 
							<input type="file" id="file" name="file" accept=".gif, .png, .jpg, .jpeg"> 
							<input class="upload" value="파일을 선택해주세요." disabled="disabled">
							<button id="writeSub" onclick="location.href='board?=sb_cate=${param.sb_cate }'" >취소</button>
							<button id="wsBtn" type="submit" style="margin-right: 10px;" >글 작성</button>
							<input type="hidden" name="sb_cate" value="${param.sb_cate }">
						</div>
					</div>
				</div>
			</form>
		</div>
		<footer>
		<c:import url="footer.jsp"/>
		</footer>
	</div>	

</body>

</html>