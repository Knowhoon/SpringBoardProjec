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
<link rel="stylesheet" href="../css/index.css">
<style type="text/css">
h1{line-height:100px;background-color:#f7f7f7;}		
		h1 span{display:block;width:1200px;margin:0 auto;text-align:left;}
nav{width:1200px;margin:0 auto;overflow:hidden;padding-bottom:10px;}
#container{width:1200px; margin:0 auto;padding-top:20px;font-size:15px;font-family:'맑은 고딕';}
	.title{overflow:hidden;text-align:center;border-bottom:1px solid #ccc;height:35px;line-height:35px;}
		.title li{text-align: center;}
		.title li:first-child{width:10%;}
		.title li:nth-child(2){text-align: center; width:15%;}
		.title li:nth-child(3){width:15%;}
		.title li:nth-child(4){width:15%;}
		.title li:nth-child(5){width:15%;}
		.title li:last-child{text-align: center; width:30%;}
	#subTitle{margin-bottom:5px;font-weight:600;background-color:#F7F7F7;border-top:2px solid #444;color:#444;}
	#main {transition:0.3s all;cursor:pointer; text-align: center;}
	#main:hover{background-color:#EBF5FB;}
	#mainTitle{font-size:14px;font-family:'맑은 고딕';}
	#modify{float: right; margin-right: 10px; margin-top: 10px;}
#bbottom{width:990px;min-height:500px;padding:10px;margin-bottom:0px;text-align:left;}

</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}
function linkPage(pageNo){
	var searchOption = getParameterByName('searchOption');
	var search = getParameterByName('search');
	if(!searchOption && !search){
		location.href="./logList?pageNo="+pageNo;
	}else{
		location.href="./logList?pageNo="+pageNo+"&searchOption="+searchOption+"&search="+search;
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
		<c:if test="${param.searchOption ne null }">		
		<h2>검색 조건 : 
		<c:choose>
			<c:when test="${param.searchOption eq 'sl_ip' }">ip</c:when>
			<c:when test="${param.searchOption eq 'sl_id' }">id</c:when>
			<c:otherwise>페이지+내역</c:otherwise>
		</c:choose>		
		/ 검색어 : ${param.search }	
		<button onclick="location.href='./logList'">검색 초기화</button>
		</h2>	
		</c:if>
		
		
		<ul id="subTitle" class="title">
			<li>번호</li>
			<li>ip</li>
			<li>접속날짜</li>
			<li>페이지</li>
			<li>id</li>
			<li>내역</li>
		</ul>
		<c:choose>
			<c:when test="${fn:length(logList) gt 0 }">
				<c:forEach items="${logList }" var="l">
					<ul id="main" class="title" >
						<li>${l.sl_no }</li>
						<li>${l.sl_ip }</li>
						<li>${l.sl_date }</li>
						<li>${l.sl_target }</li>						
						<li><c:if test="${l.sl_id eq null }"> - </c:if>${l.sl_id }</li>
						<li>${l.sl_data }</li>
				</ul>
				</c:forEach>
				<!-- 페이징 -->
				<div style="text-align: center;">
				<ul>				
				<ui:pagination paginationInfo="${paginationInfo }" type="text" jsFunction="linkPage"/>			
				</ul>				
				</div>
				<div id="SearchOption">
				<form action="./logList" method="get">
					<select name="searchOption">
						<option value="sl_ip" <c:if test="${searchOption eq 'sl_ip'}">selected="selected"</c:if>>ip</option>
						<option value="sl_id" <c:if test="${searchOption eq 'sl_id'}">selected="selected"</c:if>>id</option>
						<option value="td" <c:if test="${searchOption eq 'td'}">selected="selected"</c:if>>페이지+내역</option>
					</select> <input name="search" value="${search}"/> <button type="submit">검색</button>
				</form>
				</div>
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