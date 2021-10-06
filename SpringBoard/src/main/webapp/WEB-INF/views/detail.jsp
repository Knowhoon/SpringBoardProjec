<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hello World</title>
<script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="./css/index.css">
<style type="text/css">
.likeDislike {
	height: 120px;
	width: 100%;
	text-align: center;
	border-top: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

.likeDislike img {
	margin-top: 18px;
	width: 40px;
}

.button {
	display: inline-block;
}

.cmtNotice {
	height: 35px;
	width: 400px;
	margin: auto;
	text-align: center;
	border: 1px solid #ccc;
	background-color: #fffef8;
	padding-top: 10px;
}

.clear1 {
	margin: auto;
}

#comment {
	width: 100%;
	padding-top: 10px;
}

#comment ul {
	width: 100%;
}

#comment ul li {
	width: 90%;
	margin: auto;
}

#commentInfo {
	height: 40px;
	margin-left: 20px;
	font-size: 16px;
	font-weight: 600;
	padding-top: 15px;
}

#commentSee {
	background-color: #fff;
	transition: 0.3s;
	cursor: pointer;
}

#commentSee:hover {
	background-color: #eee;
}

#commentContainer {
	background-color: #fff;
	border-top: 1px solid #eee;
}

#commentbox {
	width: 100%;
	margin: 0 auto;
	padding-bottom: 10px;
	min-height: 80px;
	margin-top: 10px;
}

#cbPlus {
	width: 100%;
	height: 40px;
	line-height: 30px;
	overflow: hidden;
	border-bottom: 1px solid #eee;
	margin-top: 6px;
}

#cbPlus img {
	height: 30px;
	vertical-align: middle;
}

#cbUser {
	display: inline-block;
	height: 30px;
}

#cbUser img {
	height: 14px;
	width: 14px;
	cursor: pointer;
}

#cmtModify {
	display: inline-block;
	height: 15px;
	line-height: 12px;
	cursor: pointer;
	float: right;
	margin-right: 10px;
}

#cmtContent {
	width: 100%;
	min-height: 40px;
	padding-bottom: 10px;
	padding-top: 10px;
	border-bottom: 1px solid #eee;
	text-align: left;
}

#commentWrite {
	padding-top: 20px;
}

#cwArea {
	width: 100%;
	margin: 0 auto;
	overflow: hidden;
}

#cwArea p {
	float: left;
}

#cwText {
	width: 90%;
	text-align: left;
}

#cwText textarea {
	width: 99%;
	height: 75px;
	padding-top: 5px;
	padding-left: 1%;
	overflow: auto;
	resize: none;
}

#cwTSend {
	width: 10%;
	height: 82px;
	font-size: 12px;
}

#cwTSBtn {
	width: 100%;
	height: 100%;
	line-height: 80px;
	cursor: pointer;
	transition: 0.3s;
}

#cwTSBtn:hover, #cwTSBtn:focus {
	background-color: #5499C7;
}

textarea:focus {
	outline: none;
}

button:focus, button:hover {
	outline: none;
}

#nextPrev a {
	display: inline-block;
	float: left;
	padding: 10px 15px;
	margin: 10px;
	font-weight: 600;
	background-color: #f7f7f7;
	vertical-align: middle;
	border: 1px solid #ebebeb;
	border-radius: 5px;
}

#writeSub {
	display: inline-block;
	float: right;
	padding: 10px 15px;
	margin: 10px;
	cursor: pointer;
	font-weight: 600;
	background-color: #f7f7f7;
	vertical-align: middle;
	border: 1px solid #ebebeb;
	border-radius: 5px;
}

#writeSub:hover, #write_sub:focus {
	background-color: #ccc;
}
</style>
<script type="text/javascript">

$(function(){
	var txtw = 0;
	$(".modifyWrite").hide();
	$(".clear1").bind("click focus",function(){
		if(txtw == 0){		
			$(this).parent().hide();
			$(this).parent().siblings().show();
			txtw=1;
		}
		else{
			$(this).parent().siblings().show();
			$(this).parent().hide();
			txtw=0;
		}
	});
});
function boardVote(vote, sb_no, detail_id, sm_id){
<%-- 	var sm_id = '<%=session.getAttribute("sm_id")%>';
 	alert(sm_id);
--%>
 	if(!sm_id){
 		if(confirm("로그인이 필요한 기능입니다.\n로그인 페이지로 이동하시겠습니까?")){
			location.href="./login";
		}
	}else{
		if(sm_id != detail_id){
			$.ajax({
				url:"./voteIdCheck",
				type:"POST",
				cache : false,
				dataType:"html",
				data:{"sm_id" : sm_id,
					 "sb_no" : sb_no	
				},
				success: function(data){
					if(data == 0){
						if(vote == '0'){
							if(confirm("해당 글을 좋아하시겠습니까?")){
								location.href="./detailVote?sb_vote=" + vote + "&sb_no=" + sb_no + "&sm_id=" + sm_id + "&sb_cate=" + ${detail.sb_cate};
							}
						}else if(vote == '1'){
							if(confirm("해당 글을 싫어하시겠습니까?")){
								location.href="./detailVote?sb_vote=" + vote + "&sb_no=" + sb_no + "&sm_id=" + sm_id + "&sb_cate=" + ${detail.sb_cate};
							}			
						}	
					}else{
						alert("이미 좋아요/싫어요를 하셨습니다.");					
					}
				},
				error: function(request, status, error){
					alert("문제 발생 : " + error);
				}
			});
		}else{
			alert("자신이 쓴 작성글은 좋아요/싫어요를 할 수 없습니다.");
		}
	}
}
function commentVote(comment_id, sb_no, sc_no, sm_id){
	if(!sm_id){
 		if(confirm("로그인이 필요한 기능입니다.\n로그인 페이지로 이동하시겠습니까?")){
			location.href="./login";
		}
	}else{
		if(sm_id != comment_id){
			$.ajax({
				url:"./voteIdCheck",
				type:"POST",
				cache : false,
				dataType:"html",
				data:{"sm_id" : sm_id,
					 "sb_no" : sb_no,
					 "sc_no" : sc_no	
				},
				success: function(data){
					if(data == 0){
						if(confirm("해당 댓글을 추천하시겠습니까?")){
							location.href="./commentVote?&sb_no=" + sb_no + "&sc_no=" + sc_no + "&sm_id=" + sm_id +  "&sb_cate=" + ${detail.sb_cate};
						}
					} else{
						alert("이미 해당 댓글을 추천 하셨습니다.");	
					}
				},
				error: function(request, status, error){
					alert("문제 발생 : " + error);
				}
			});
		}else{
			alert("자신이 쓴 댓글은 추천 할 수 없습니다.");
		}
	}
}
</script>
</head>
<body>
	<div id="wrapper">
		<header>
			<jsp:include page="./header.jsp"></jsp:include>
			<c:import url="/menu" />
		</header>
		<main id="container">
			<ul id="subTitle" class="title">
				<li>번호</li>
				<li>제목</li>
				<li>날짜</li>
				<li>조회수</li>
				<li>추천수</li>
				<li>글쓴이</li>
			</ul>
			<ul id="mainTitle" class="title">
				<li>${detail.sb_nno }</li>
				<li>${detail.sb_title }</li>
				<li>${detail.sb_date2 }</li>
				<li>${detail.sb_count }</li>
				<li>${detail.sb_like }</li>
				<li>${detail.sm_name }<small>(${detail.sm_id })</small></li>
			</ul>
			<c:if test="${detail.sb_modifydate ne null }">
				<small style="float: right; margin-right: 15px; margin-top: 3px;">${detail.sb_modifydate }
					(수정)</small>
				<br>
			</c:if>
			<c:if test="${sessionScope.sm_id eq detail.sm_id}">
				<div id="modify">
					<button
						onclick="location.href='./boardDelete?sb_no=${detail.sb_no }&sb_cate=${detail.sb_cate }'">삭제하기</button>
					<button
						onclick="location.href='./boardModify?sb_no=${detail.sb_no }&sb_cate=${detail.sb_cate }'">수정하기</button>
				</div>
			</c:if>

			<div id="bbottom">
				<c:if test="${detail.sb_file ne null }">
					<img alt="" src="./upfile/${detail.sb_file }">
				</c:if>${detail.sb_content }
			</div>
			<div class="likeDislike">
				<div class="button">
					<a href='#'
						onclick="boardVote('0',${detail.sb_no}, '${detail.sm_id }', '${sessionScope.sm_id }');"><img
						src="./img/smile.png" alt="좋아요"><br>좋아요</a> <br>${detail.sb_like }
				</div>
				&nbsp;&nbsp;
				<div class="button">
					<a href='#'
						onclick="boardVote('1', ${detail.sb_no}, '${detail.sm_id }', '${sessionScope.sm_id }');"><img
						src="./img/frown.png" alt="싫어요"><br>싫어요</a> <br>${detail.sb_dislike }
				</div>
			</div>
			<div id=></div>
			<div id="comment">
				<div class="cmtNotice">올바른 댓글 문화를 지켜주세요.</div>
				<ul>
					<c:if test="${sessionScope.sm_id ne null }">
						<li id="commentWrite">
							<div id="cwID" style="margin-bottom: 10px;">
								<img src="./img/info.png" alt="info"
									style="cursor: pointer; vertical-align: middle; height: 30px;">&nbsp;${sessionScope.sm_name}(${sessionScope.sm_id})
							</div>
							<div id="cwArea">
								<form action="./commentWrite" method="post">
									<p id="cwText">
										<textarea name="sc_comment"></textarea>
										<input type="hidden" name="sb_no" value="${detail.sb_no }">
										<input type="hidden" name="sb_cate" value="${detail.sb_cate }">
									</p>
									<p id="cwTSend">
										<button id="cwTSBtn">댓글 작성</button>
									</p>
								</form>
							</div>
						</li>
					</c:if>
					<c:choose>
						<c:when test="${detail.commentcount gt 0 }">
							<li id="commentInfo">${detail.commentcount }개의댓글</li>
							<li id="commentContainer"><c:choose>
									<c:when test="${true }">
										<c:forEach items="${comment }" var="cmt">
											<div id="commentbox">
												<div id="cbPlus">
													<img src="./img/info.png" alt="info"
														style="cursor: pointer;">
													<div id="cbUser">${cmt.sm_name}(${cmt.sm_id })</div>
													<div id="cbUser">${cmt.sc_date }<c:if
															test="${cmt.sc_modifydate ne null }">
															<small>&emsp;${cmt.sc_modifydate } (수정)</small>
														</c:if>
													</div>
													<div id="cbUser">
														<a href='#'
															onclick="commentVote('${cmt.sm_id}', ${cmt.sb_no }, ${cmt.sc_no }, '${sessionScope.sm_id }');"><img
															src="./img/like.png" alt="좋아요"></a>&nbsp;${cmt.sc_like }
													</div>
												</div>


												<div class="modifyInputP">
													<div id="cmtContent">${cmt.sc_comment }
														<c:if test="${sessionScope.sm_id eq cmt.sm_id}">
															<button id=cmtModify class="clear1">수정하기</button>
															<div class="sb_no" style="display: none;">${cmt.sb_no }</div>
															<div class="sc_no" style="display: none;">${cmt.sc_no }</div>
															<form action="./commentDelete" method="post">
																<input type="hidden" name="sb_no" value="${cmt.sb_no }"><input
																	type="hidden" name="cno" value="${cmt.sc_no }">
																<input type="hidden" name="sb_cate"
																	value="${detail.sb_cate }">
																<button id=cmtModify>삭제하기</button>
															</form>
														</c:if>
													</div>
													<div class="modifyWrite">
														<form action="./commentModify" method="post">
															<textarea name="sc_comment"
																style="width: 100%; height: 100px; overflow: auto; resize: none;">${cmt.sc_comment }</textarea>
															<input type="hidden" name="sb_no" value="${cmt.sb_no }">
															<input type="hidden" name="sc_no" value="${cmt.sc_no }">
															<input type="hidden" name="sb_cate"
																value="${detail.sb_cate }">
															<button id=cmtModify>수정</button>
														</form>
														<button id=cmtModify class="clear1">수정취소</button>

													</div>
												</div>
											</div>
										</c:forEach>
									</c:when>
								</c:choose></li>
						</c:when>
						<c:otherwise>
							<li id="commentInfo">댓글이 없습니다. 댓글을 달아주세요.</li>
						</c:otherwise>
					</c:choose>

				</ul>
			</div>
			<div id="nextPrev">
				<c:if test="${detail.sb_nno gt 1}">
					<a
						href="./nextPrev?option=prev&sb_nno=${detail.sb_nno }&sb_cate=${detail.sb_cate}"
						title="이전글">이전글</a>
				</c:if>
				<c:if test="${detail.sb_nno lt detail.totalList}">
					<a
						href="./nextPrev?option=next&sb_nno=${detail.sb_nno }&sb_cate=${detail.sb_cate}"
						title="다음글">다음글</a>
				</c:if>
			</div>
			<c:if test="${sessionScope.sm_id ne null }">
				<div id="writeSub">
					<a href="./write?sb_cate=${detail.sb_cate }">글쓰기</a>
				</div>
			</c:if>
			<div id=writeSub>
				<a href="./board?sb_cate=${detail.sb_cate }">글목록</a>
			</div>
			<footer>
				<c:import url="footer.jsp" />
			</footer>
		</main>
	</div>
</body>
</html>