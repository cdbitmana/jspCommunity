<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${article.title }"/>

<%@ include file="../../part/head.jspf"%>
<script>
function doLikeBtn(){

	const memberId = ${loginedMemberId};
	const articleId = ${article.id};
	$.get(
			"doLikeArticle",
			{
				memberId,
				articleId
			},
			function(data) {
			if(data.success){
				$('.articleDetailBody__likeBtn > i').attr('class','fas fa-thumbs-up');
				}
			else{
				$('.articleDetailBody__likeBtn > i').attr('class','far fa-thumbs-up');
				}
			},
			"json"
		);
}


function doDislikeBtn(){
	const memberId = ${loginedMemberId};
	const articleId = ${article.id};
	$.get(
			"doDislikeArticle",
			{
				memberId,
				articleId
			},
			function(data) {
			if(data.success){
				$('.articleDetailBody__dislikeBtn > i').attr('class','fas fa-thumbs-down');
				}
			else{
				$('.articleDetailBody__dislikeBtn > i').attr('class','far fa-thumbs-down');
				}
			},
			"json"
		);
}

let DoWriteForm__submited = false;

function writeFormCheck(el) {
	if ( DoWriteForm__submited ) {
		alert('처리중입니다.');
		return false;
	}
	
	
	const editor = $(el).find('.toast-ui-editor').data('data-toast-editor');
	const body = editor.getMarkdown().trim();
	
	if ( body.length == 0 ) {
		alert('내용을 입력해주세요.');
		editor.focus();
		
		return false;
	}
	
	writeReplyForm.body.value = body;
	
	return true;
}

function modifyFormOpen(el){
	const form = $(el).parents().parents().siblings('.articleDetailBox__reply-modify');
	$(form).css({
		'display':'block',
		'margin-top':'15px'
		});
}


let DoModifyForm__submited = false;

function modifyFormCheck(el) {
	if ( DoModifyForm__submited ) {
		alert('처리중입니다.');
		return false;
	}
	
	
	const editor = $(el).find('.toast-ui-editor').data('data-toast-editor');
	const body = editor.getMarkdown().trim();
	
	if ( body.length == 0 ) {
		alert('내용을 입력해주세요.');
		editor.focus();
		
		return false;
	}
	
	$(el).closest('form').get(0).body.value = body;
	
	return true;
}

function modifyReplyCancel(el){
const form = $(el).parents().parents('.articleDetailBox__reply-modify');
	$(form).css('display','none');
}
</script>
<main class="con-min-width">
<div class="con articleDetailBox">
<span class="articleDetailTitle">${article.title}</span>
<!-- 게시물 상세보기 상단 정보 PC버전 시작 -->
    <div class="flex flex-ai-c flex-jc-sb articleDetailInfo articleDetailInfo-pc">
    <div class="flex flex-ai-c articleDetailInfo-box1">
    <span class="articleDetailWriter">${article.extra__writer}</span>
      <span class="articleDetailRegDate">${article.regDate}</span>
       <c:if test="${article.memberId == loginedMemberId }">
     <form class="articleDetailModify" action="${contextName }/usr/article/modify" style="display:inline-block" method="post">	
     <input type="hidden" name="afterModifyUrl" value="${currentUrl }">
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="hidden" name="title" value="${article.title }">
	<input type="hidden" name="body" value="${article.body }">
	
	<input type="submit" value="수정">
	</form>
    <form class="articleDetailDelete" action="${contextName }/usr/article/doDelete" style="display:inline-block" method="post">
    <input type="hidden" name="listUrl" value="${param.listUrl }">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="submit" value="삭제">
	</form>	
	</c:if>
	</div>
	<div class="articleDetailInfo-box2">
      <span>조회수 ${article.hitCount}</span>
      <span>좋아요 ${article.likeCount}</span>
      <span>싫어요 ${article.dislikeCount}</span>
      <span>댓글수 ${totalReplyCount}</span>
      </div>
      </div>	
<!-- 게시물 상세보기 상단 정보 PC버전 끝 -->

<!-- 게시물 상세보기 상단 정보 모바일 버전 시작 -->
<div class="articleDetailInfo articleDetailInfo-mb">
<div class="articleDetailInfo-mb__box1 flex flex-ai-c flex-jc-sb">
<div>
    <span class="articleDetailWriter">${article.extra__writer}</span>
      <span class="articleDetailRegDate">${article.regDate}</span>
      </div>
      <div>
      <span>조회수 ${article.hitCount}</span>
      <span>댓글수 ${totalReplyCount}</span>
      </div>
      </div>
      <div class="articleDetailInfo-mb__box2 flex flex-ai-c flex-jc-sb">
      <div class="articleDetailInfo-mb__box2__left">      
      <c:if test="${article.memberId == loginedMemberId }">
     <form class="articleDetailModify" action="${contextName }/usr/article/modify" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="hidden" name="title" value="${article.title }">
	<input type="hidden" name="body" value="${article.body }">
	<input type="hidden" name="page" value="${param.page }">
	<input type="submit" value="수정">
	</form>
    <form class="articleDetailDelete" action="${contextName }/usr/article/doDelete" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="submit" value="삭제">
	</form>
	</c:if>  
	</div>
	<div class="float-r articleDetailInfo-mb__box2__right">
	  <span>좋아요 ${article.likeCount}</span>
      <span>싫어요 ${article.dislikeCount}</span>
	</div>
	</div> 
      </div>
<!-- 게시물 상세보기 상단 정보 모바일 버전 끝 -->
    <div class="flex flex-dir-col articleDetailBody">
    <div class="flex-grow-1 articleDetailBody__bodytext">
      <script type="text/x-template">${article.body }</script>
  <div class="toast-ui-viewer"></div>
  </div>
  <c:if test="${isLogined }">
  <div class="flex flex-ai-c flex-jc-sa articleDetailBody__likeanddislike">
  <div class="articleDetailBody__likeBtn" onclick="doLikeBtn();">
  <c:if test="${isLikedArticle == true }">
  <i class="fas fa-thumbs-up"></i>
  </c:if>
  <c:if test="${isLikedArticle == false }">  
  <i class="far fa-thumbs-up"></i>
  </c:if>
  <span>좋아요</span></div>
  <div class="articleDetailBody__dislikeBtn" onclick="doDislikeBtn();">
   <c:if test="${isDislikedArticle == true }">  
  <i class="fas fa-thumbs-down"></i>
  </c:if>
   <c:if test="${isDislikedArticle == false }">  
  <i class="far fa-thumbs-down"></i>
  </c:if>
  <span>싫어요</span></div>
  </div>
  </c:if>
    </div>
    
	<div class="articleDetailToList">
	<a href="${param.listUrl }">목록</a>
	</div>
	
	<!-- 댓글 입력 창 시작 -->
	<div class="articleDetailBox__reply">
	
	<!-- 댓글 입력 창(로그인 안했을 때) -->
	<c:if test="${isLogined == false }">
	<div class="flex flex-dir-col flex-jc-c flex-ai-c articleDetailBox__reply-isNotLogined">
	<div class="articleDetailBox__reply-isNotLogined__text">로그인한 회원만 댓글을 작성할 수 있습니다.</div>
	<c:url value="/usr/member/login" var="url">
	<c:param name="afterLoginUrl" value="${currentUrl }"/>
	</c:url>
	<a href="${url }">로그인</a>
	</div>
	</c:if>
	
	<!-- 댓글 입력 창(로그인 했을 때) -->
	<c:if test="${isLogined }">
	<div class="articleDetailBox__reply-isLogined">
	<form name="writeReplyForm" class="articleDetailBox__reply-form" action="${contextName }/usr/reply/doWriteArticleReply" method="POST" onsubmit="return writeFormCheck(this);">
	<input type="hidden" name="body">
	<input type="hidden" name="memberId" value="${sessionScope.loginedMemberId }">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	<div class="writeReplyBodyInput">
		 <script type="text/x-template"></script>
  <div class="toast-ui-editor"></div>
  </div>
  <button class="btn-square submitWriteReply">등록</button>
  
  </form>
	</div>
	</c:if>
	
	<!-- 댓글 리스트 -->
	<div class="articleDetailBox__articleReplyList">
	<div class="articleDetailBox__articleReplyList__info">
	<span>전체 댓글 수</span><span> ${totalReplyCount }</span>
	</div>
	
	<div class="articleDetailBox__articleReplyList__replys">	
	<c:forEach var="reply" items="${replys }">
	<div class="flex flex-dir-col articleDetailBox__articleReplyList__reply">
	<!-- 댓글 리스트 본문 PC버전 -->
	<div class="flex articleDetailBox__articleReplyList__reply-1-pc">
	<div class="reply__writer">${reply.extra__writer }</div>
	<div class="flex-grow-1 reply__body">${reply.body }</div>
	<c:if test="${loginedMemberId == reply.memberId }">
	<div class="reply__btns flex flex-ai-c flex-jc-sa">
	<div class="reply__btns__modify" onclick="modifyFormOpen(this);">수정</div>
	<div class="reply__btns__delete">
	<form class="reply__btns__delete-form" action="${contextName }/usr/reply/doDeleteArticleReply">
	<input type="submit" value="삭제">
	<input type="hidden" name="id" value="${reply.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	</div>
	</div>
	</c:if>
	<div class="reply__regDate">${reply.regDate }</div>	
	</div>	
	
	<!-- 댓글 리스트 본문 모바일버전 -->
	<div class="flex flex-dir-col articleDetailBox__articleReplyList__reply-1-mb">
	<div class="flex flex-ai-c flex-jc-sb articleDetailBox__articleReplyList__reply-1-mb__box1">
	<div>${reply.extra__writer }</div>
	<div class="flex flex-ai-c">
	<c:if test="${loginedMemberId == reply.memberId }">
	<div class="reply__btns__modify" onclick="modifyFormOpen(this);">수정</div>
	<div class="reply__btns__delete">
	<form class="reply__btns__delete-form" action="${contextName }/usr/reply/doDeleteArticleReply">
	<input type="submit" value="삭제">
	<input type="hidden" name="id" value="${reply.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	</div>
	</c:if>
	<div>${reply.regDate }</div>
	</div>
	</div>
	<div class="articleDetailBox__articleReplyList__reply-1-mb__box2">
	<div>${reply.body }</div>
	</div>
	</div>
	
	
	
	
	<div class="articleDetailBox__reply-modify">
	<form name="writeReplyModifyForm" class="articleDetailBox__reply-modifyform" action="${contextName }/usr/reply/doModifyArticleReply" method="POST" onsubmit="return modifyFormCheck(this);">
	<input type="hidden" name="body">
	<input type="hidden" name="id" value="${reply.id }">
	<input type="hidden" name="memberId" value="${sessionScope.loginedMemberId }">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	<div class="writeReplyBodyInput">
		 <script type="text/x-template"></script>
  <div class="toast-ui-editor"></div>
  </div>
  <div class="flex flex-ai-c flex-jc-e articleDetailBox__reply-modifyform__btns">
  <button class="btn-square submitReplyModify">수정</button><span class="btn-square submitReplyModifyCancel"  onclick="modifyReplyCancel(this);">취소</span>
  </div>  
  </form>
	</div>
	
	</div>
	</c:forEach>
	
	</div>
	</div>
	
	</div>
	</div>
	</main>
<%@ include file="../../part/foot.jspf"%>
