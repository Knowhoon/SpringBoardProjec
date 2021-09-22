<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Knowhoon Web Board</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="./css/index.css">
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
	var cate = getParameterByName('sb_cate');
	if(!searchOption && !search){
		location.href="./board?pageNo="+pageNo+"&sb_cate="+${sb_cate};
	}else{
		location.href="./board?pageNo="+pageNo+"&sb_cate="+${sb_cate}+"&searchOption="+searchOption+"&search="+search;
	}
}
</script>
<style type="text/css">
#paging{text-align: center; margin: 20px;}
#paging a{background-color: #fdfdfd;cursor: pointer;border: 1px solid #ebebeb;border-radius: 10px; padding: 7px; }
#paging strong{background-color: #ebebeb;cursor: pointer;border: 1px solid #ebebeb;border-radius: 10px; padding: 7px; }
#SearchOption select {display: inline-block;padding: 10px 20px;    font-size: 15px;vertical-align: middle;background-color: #fdfdfd;cursor: pointer;border: 1px solid #ebebeb;border-radius: 5px;}
#SearchOption input {display: inline-block;padding: 10px 20px;    font-size: 15px;vertical-align: middle;background-color: #fdfdfd;cursor: pointer;border: 1px solid #ebebeb;border-radius: 5px;}
#SearchOption button {display: inline-block;padding: 10px 20px;    font-size: 15px;vertical-align: middle;background-color: #fdfdfd;cursor: pointer;border: 1px solid #ebebeb;border-radius: 5px;}
#writeSub {display: inline-block; float:right; padding: 5px 15px;cursor:pointer;font-weight:600;font-size:17px;background-color:#f7f7f7; vertical-align: middle; border: 1px solid #ebebeb; border-radius: 5px;}
#writeSub:hover, #write_sub:focus{background-color:#ccc;}
#SearchResult  {margin-bottom: 20px;}
#SearchResult span {display: inline-block;font-size: 15px;padding: 10px 20px;vertical-align: middle;background-color: #fdfdfd;cursor: pointer;border: 1px solid #ebebeb;border-radius: 5px;}
#SearchResult input {display: inline-block;font-size: 15px;padding: 10px 20px;vertical-align: middle;background-color: #fdfdfd;cursor: pointer;border: 1px solid #ebebeb;border-radius: 5px;}

</style>
</head>
<body>
<div id="wrapper">
	<header>
		<jsp:include page="./header.jsp"></jsp:include>
		<c:import url="/menu"/>
	</header>
	<main id="container">

			<ul id="subTitle" class="title">
			<li>번호</li>
			<li>제목</li>
			<li>날짜</li>
			<li>조회수</li>
			<li><img alt="like" src="./img/like.png"></li>
			<li>글쓴이</li>
		</ul>
		<c:choose>
			<c:when test="${fn:length(boardList) gt 0 }">
				<c:forEach items="${boardList }" var="l">
					<ul id="main" class="title" onclick="location.href='./detail?sb_no=${l.sb_no }&sb_cate=${sb_cate}'">
						<li>${l.sb_nno }</li>
						<li>${l.sb_title } <c:if test="${l.commentcount gt 0 }"><small>[${l.commentcount}]</small></c:if></li>
						<li>${l.sb_date }</li>
						<li>${l.sb_count }</li>
						<li>${l.sb_like }</li>						
						<li>${l.sm_name }<small>(${l.sm_id })</small></li>
					</ul>
				</c:forEach>
				<!-- 페이징 -->
				<div >
				<ul id="paging">				
				<ui:pagination paginationInfo="${paginationInfo }" type="image" jsFunction="linkPage"/>			
				</ul>
				</div>
				<div id="SearchResult">
				<c:if test="${param.searchOption ne null }">		
				<span>
				검색 결과 : <b>${boardList.get(0).totalList }건</b> 
				/ 검색 조건 :
				 <b>
				<c:choose>
					<c:when test="${param.searchOption eq 'sb_title' }">제목</c:when>
					<c:when test="${param.searchOption eq 'sb_content' }">내용</c:when>
					<c:otherwise>제목+내용</c:otherwise>
				</c:choose>		
				</b>
				/ 검색어 : <b>${param.search }</b>
				</span>	
				<a href="./board?sb_cate=${sb_cate}" ><input type="button"value ="검색초기화"></a>					
				</c:if>
				</div>
				<div id="SearchOption">
				<form action="./board" method="get">
					<select name="searchOption">
						<option value='sb_title' <c:if test="${searchOption eq 'sb_title'}">selected="selected"</c:if>>제목</option>
						<option value='sb_content'<c:if test="${searchOption eq 'sb_content'}">selected="selected"</c:if>>내용</option>
						<option value='TC' <c:if test="${searchOption eq 'TC'}">selected="selected"</c:if>>제목+내용</option>
					</select>
					<input name="search" value="${search}"/> <button type="submit">검색</button>
					<input type="hidden" name="sb_cate" value="${sb_cate }">
				
				<c:if test="${sessionScope.sm_id ne null }">
				<div id="writeSub">
				<a href="./write?sb_cate=${sb_cate }">글쓰기</a>
				</div>
				</c:if>
				</form>
			
				</div>
			</c:when>
			<c:otherwise>
				출력할 글이 없습니다.<br/><br/>
				<c:if test="${param.searchOption ne null }">		
				<span>
				검색 결과 : <b>${boardList.get(0).totalList }건</b> 
				/ 검색 조건 :
				 <b>
				<c:choose>
					<c:when test="${param.searchOption eq 'sb_title' }">제목</c:when>
					<c:when test="${param.searchOption eq 'sb_content' }">내용</c:when>
					<c:otherwise>제목+내용</c:otherwise>
				</c:choose>		
				</b>
				/ 검색어 : <b>${param.search }</b>
				</span>	
				<a href="./board?sb_cate=${sb_cate}" ><input type="button"value ="검색초기화"></a>					
				</c:if>
				<button onclick="location.href='./home'">메인</button>
				
			</c:otherwise>
		</c:choose>

	<c:import url="footer.jsp"/>
	</main>
</div>
</body>
</html>