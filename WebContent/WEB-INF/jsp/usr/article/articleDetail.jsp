<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.sbs.example.jspCommunity.util.Util"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${article.title }"/>

<%@ include file="../../part/head.jspf"%>
<script>

function increaseHit(){
	
	let memberId = 0;
	const articleId = ${article.id};
	
	if(${loginedMemberId}){
	memberId = ${loginedMemberId};
		}
	
	const date = new Date();
	
	const year = date.getFullYear();
	const month = new String(date.getMonth());
	const day = new String(date.getDate());
	
	const currentDate = new Date(year,month , day);
	
	if( JSON.parse(localStorage.getItem('member_'+ memberId + '_' + 'article_' + articleId))){
		
		const setYear = JSON.parse(localStorage.getItem('member_'+ memberId + '_' + 'article_' + articleId)).date.substr(0,4);
        const setMonth = JSON.parse(localStorage.getItem('member_'+ memberId + '_' + 'article_' + articleId)).date.substr(5,2);
		const setDay = JSON.parse(localStorage.getItem('member_'+ memberId + '_' + 'article_' + articleId)).date.substr(8,2);
		const setDate = new Date(setYear,setMonth,setDay);

		
		if(currentDate.getTime() - setDate.getTime() > 86400000 ){
			localStorage.removeItem('member_'+ memberId + '_' + 'article_' + articleId);
			}
		
		}

	
	if( localStorage.getItem('member_'+ memberId + '_' + 'article_' + articleId)) {
			return;
		}

	$.post(
			"doIncreaseArticleHit",
			{
				memberId,
				articleId
			},
			function(data) {
			if(data.success){
				$('.articleDetailHitCount').text('조회수 '+data.body.hitCount);
				}
			else{
				}
			},
			"json"
		);

	const setMonth = new String(date.getMonth() -1);
	const setDay = new String(date.getDate() +1);
	
	const setData = {
			'memberId' : memberId,
			'articleId' : ${article.id},
			'date' : new Date(year,setMonth,setDay)
			};
	
	localStorage.setItem('member_'+ memberId + '_' + 'article_' + articleId , JSON.stringify(setData));
	
}

function countTime(){
	setTimeout(increaseHit, 10000);
}

countTime();

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
				$('.articleDetailInfo-box2__likeCount').text('좋아요 '+ data.body.likeCount);
				}
			else{
				$('.articleDetailBody__likeBtn > i').attr('class','far fa-thumbs-up');
				$('.articleDetailInfo-box2__likeCount').text('좋아요 '+ data.body.likeCount);
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
				$('.articleDetailInfo-box2__dislikeCount').text('싫어요 '+ data.body.dislikeCount);
				}
			else{
				$('.articleDetailBody__dislikeBtn > i').attr('class','far fa-thumbs-down');
				$('.articleDetailInfo-box2__dislikeCount').text('싫어요 '+ data.body.dislikeCount);
				}
			},
			"json"
		);
}

function doLikeReplyBtn(el,id){

	const memberId = ${loginedMemberId};
	const replyId = id;
	$.get(
			"${appUrl}/usr/reply/doLikeReply",
			{
				memberId,
				replyId
			},
			function(data) {
			if(data.success){
				$(el).children('i').attr('class','fas fa-thumbs-up');
				$(el).children('span').text('좋아요 '+data.body.replyLikeCount);
				}
			else{
				$(el).children('i').attr('class','far fa-thumbs-up');
				$(el).children('span').text('좋아요 '+data.body.replyLikeCount);
				}
			},
			"json"
		);
}

function doDisLikeReplyBtn(el,id){

	const memberId = ${loginedMemberId};
	const replyId = id;
	$.get(
			"${appUrl}/usr/reply/doDisLikeReply",
			{
				memberId,
				replyId
			},
			function(data) {
			if(data.success){
				$(el).children('i').attr('class','fas fa-thumbs-down');
				$(el).children('span').text('싫어요 '+data.body.replyDislikeCount);
				}
			else{
				$(el).children('i').attr('class','far fa-thumbs-down');
				$(el).children('span').text('싫어요 '+data.body.replyDislikeCount);
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

function replyReplyFormOpen(el){
	const form = $(el).parents().parents().siblings('.articleDetailBox__reply-reply');
	$(form).css({
		'display':'block',
		'margin-top':'15px'
		});
}

function replyReplyCancel(el){
const form = $(el).parents().parents('.articleDetailBox__reply-reply');
	$(form).css('display','none');
}

let writeReplyReplyForm__submited = false;

function replyReplyFormCheck(el){

	if ( writeReplyReplyForm__submited ) {
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

function modifyReplyReplyFormOpen(el){
	const form = $(el).parents().parents().siblings('.articleDetailBox__replyReply-modify');
	$(form).css({
		'display':'block',
		'margin-top':'15px'
		});
}

function modifyReplyReplyCancel(el){
	const form = $(el).parents().parents('.articleDetailBox__replyReply-modify');
		$(form).css('display','none');
	}



</script>

<script>
	$(function() {
		if ( param.focusReplyId ) {
			const $target = $('.targetReply[data-id="' + param.focusReplyId + '"]');
			$target.addClass('focus');
		
			setTimeout(function() {
				const targetOffset = $target.offset();
				$(window).scrollTop(targetOffset.top);
				
				setTimeout(function() {
					$target.removeClass('focus');
				}, 1000);
			}, 1000);
		}
	});
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
     <form class="articleDetailModify" action="${appUrl }/usr/article/modify" style="display:inline-block" method="post">	
     <input type="hidden" name="afterModifyUrl" value="${currentUrl }">
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="hidden" name="title" value="${article.title }">
	<input type="hidden" name="body" value="${article.body }">
	
	<input type="submit" value="수정">
	</form>
    <form class="articleDetailDelete" action="${appUrl }/usr/article/doDelete" style="display:inline-block" method="post">
    <input type="hidden" name="listUrl" value="${param.listUrl }">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="submit" value="삭제">
	</form>	
	</c:if>
	</div>
	<div class="articleDetailInfo-box2">
      <span class="articleDetailHitCount">조회수 ${article.hitCount}</span>
      <span class="articleDetailInfo-box2__likeCount">좋아요 ${article.extra__likeCount}</span>
      <span class="articleDetailInfo-box2__dislikeCount">싫어요 ${article.extra__dislikeCount}</span>
      <span>댓글수 ${article.replyCount}</span>
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
      <span class="articleDetailHitCount">조회수 ${article.hitCount}</span>
      <span>댓글수 ${article.replyCount}</span>
      </div>
      </div>
      <div class="articleDetailInfo-mb__box2 flex flex-ai-c flex-jc-sb">
      <div class="articleDetailInfo-mb__box2__left">      
      <c:if test="${article.memberId == loginedMemberId }">
     <form class="articleDetailModify" action="${appUrl }/usr/article/modify" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="hidden" name="title" value="${article.title }">
	<input type="hidden" name="body" value="${article.body }">
	<input type="hidden" name="page" value="${param.page }">
	<input type="submit" value="수정">
	</form>
    <form class="articleDetailDelete" action="${appUrl }/usr/article/doDelete" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="submit" value="삭제">
	</form>
	</c:if>  
	</div>
	<div class="float-r articleDetailInfo-mb__box2__right">
	  <span class="articleDetailInfo-box2__likeCount">좋아요 ${article.extra__likeCount}</span>
      <span class="articleDetailInfo-box2__dislikeCount">싫어요 ${article.extra__dislikeCount}</span>
	</div>
	</div> 
      </div>
<!-- 게시물 상세보기 상단 정보 모바일 버전 끝 -->

<!-- 게시물 본문 내용 시작 -->
    <div class="flex flex-dir-col articleDetailBody">
    <div class="flex flex-grow-1 articleDetailBody__bodytext">
    <c:if test="${article.extra__dislikeCount < 10 }">
    <div class="articleDetailBody__bodytext__body">
      <script type="text/x-template">${article.body }</script>
  <div class="toast-ui-viewer"></div>
  </div>
  </c:if>
  <c:if test="${article.extra__dislikeCount >= 10 }">
  <div class="width-100p flex flex-ai-c flex-jc-c articleDetailBody__bodytext__blindbody">
  <span>해당 게시물은 블라인드 처리되었습니다.</span>
  </div>
  </c:if>
  </div>
  <!-- 게시물 본문 내용 끝 -->
  
  <!-- 게시물 본문 좋아요 싫어요 버튼 시작 -->
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
    <!-- 게시물 본문 좋아요 싫어요 버튼 끝 -->
    
	<div class="articleDetailToList">
	<a href="${param.listUrl }">목록</a>
	</div>
	
	<!-- 댓글 -->
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
	<!-- 댓글 입력 창(로그인 안했을 때) -->
	
	<!-- 댓글 입력 창(로그인 했을 때) -->
	<c:if test="${isLogined }">
	<div class="articleDetailBox__reply-isLogined">
	<form name="writeReplyForm" class="articleDetailBox__reply-form" action="${appUrl }/usr/reply/doWriteArticleReply" method="POST" onsubmit="return writeFormCheck(this);">
	<input type="hidden" name="afterWriteReplyUrl"
				value="${Util.getNewUrl(currentUrl, 'focusReplyId', '[NEW_REPLY_ID]')}" />
	<input type="hidden" name="body">
	<input type="hidden" name="memberId" value="${sessionScope.loginedMemberId }">
	<input type="hidden" name="articleId" value="${article.id }">
	<div class="writeReplyBodyInput">
		 <script type="text/x-template"></script>
  <div class="toast-ui-editor"></div>
  </div>
  <button class="btn-square submitWriteReply">등록</button>
  
  </form>
	</div>
	</c:if>
	<!-- 댓글 입력 창(로그인 했을 때) -->
	
	
	<!-- 댓글 리스트 시작 -->
	<div class="articleDetailBox__articleReplyList">
	
	<!-- 전체 댓글 수 정보 시작 -->
	<div class="articleDetailBox__articleReplyList__info">
	<span>전체 댓글 수</span><span> ${article.replyCount}</span>
	</div>
	<!-- 전체 댓글 수 정보 끝 -->
	
	<!-- 댓글 리스트 본문 시작 -->
	 
	<div class="articleDetailBox__articleReplyList__replies">		
	<c:forEach var="reply" items="${replies }">
	
	<c:if test="${reply.relType eq 'article' && reply.relId == article.id}">	
	<div data-id="${reply.id }" class="flex flex-dir-col targetReply articleDetailBox__articleReplyList__reply">
	
	<!-- 댓글 리스트 본문 PC버전 시작 -->
	
	<div class="flex flex-dir-col articleDetailBox__articleReplyList__reply-1-pc">
	<c:if test="${reply.status > 0 }">
	<div class="flex articleDetailBox__articleReplyList__reply-1-pc__box-1">	
	<div class="reply__writer">${reply.extra__writer }</div>
	<div class="flex-grow-1 reply__body">${reply.body }</div>		
	<div class="flex flex-ai-c flex-jc-sa reply__btns-2">
	<div class="reply__btns__like <c:if test="${isLogined }"> click</c:if>" <c:if test="${isLogined }">onclick="doLikeReplyBtn(this,${reply.id});"</c:if>><i class="far fa-thumbs-up"></i><span class="replyLikeCount">좋아요 ${reply.extra__likeCount }</span></div>
	<div class="reply__btns__dislike <c:if test="${isLogined }"> click </c:if>" <c:if test="${isLogined }">onclick="doDisLikeReplyBtn(this,${reply.id});"</c:if>><i class="far fa-thumbs-down"></i><span class="replyDislikeCount">싫어요 ${reply.extra__dislikeCount }</span></div>
	</div>
	<div class="reply__regDate">${reply.regDate }</div>
	</div>
	
	<div class="articleDetailBox__articleReplyList__reply-1-pc__box-2">
	<div class="float-l reply__btns-1 flex flex-ai-c flex-jc-sb">
	<c:if test="${loginedMemberId == reply.memberId }">
	<div class="reply__btns__modify click" onclick="modifyFormOpen(this);">수정</div>
	<div class="reply__btns__delete click">
	<form class="reply__btns__delete-form" action="${appUrl }/usr/reply/doDeleteArticleReply">
	<input type="submit" value="삭제">
	<input type="hidden" name="id" value="${reply.id }">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	</div>
	</c:if>
	</div>	
	
	<c:if test="${isLogined }">
	<div class="float-r flex flex-ai-c reply__reply" onclick="replyReplyFormOpen(this);">
	<div>[답글]</div>
	</div>
	</c:if>
	
	</div>
	</c:if>
	
	<c:if test="${reply.status < 0 }">
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-pc__deletedReply">삭제된 댓글입니다.</div>
	</c:if>
	
	
	
	
	</div>	
	
	<!-- 댓글 리스트 본문 PC버전 끝 -->
	
	<!-- 댓글 리스트 본문 모바일버전 시작 -->
	<div class="flex flex-dir-col articleDetailBox__articleReplyList__reply-1-mb">
	
	<c:if test="${reply.status > 0 }">
	<div class="flex flex-ai-c flex-jc-sb articleDetailBox__articleReplyList__reply-1-mb__box1">
	<div>${reply.extra__writer }</div>
	<div class="flex flex-ai-c">	
	<div class="flex flex-ai-c flex-jc-sa reply__btns-mb-1">
	<div class="reply__btns__like <c:if test="${isLogined }"> click</c:if>" <c:if test="${isLogined }">onclick="doLikeReplyBtn(this,${reply.id});"</c:if>><i class="far fa-thumbs-up"></i><span class="replyLikeCount">좋아요 ${reply.extra__likeCount }</span></div>
	<div class="reply__btns__dislike <c:if test="${isLogined }"> click </c:if>" <c:if test="${isLogined }">onclick="doDisLikeReplyBtn(this,${reply.id});"</c:if>><i class="far fa-thumbs-down"></i><span class="replyDislikeCount">싫어요 ${reply.extra__dislikeCount }</span></div>
	</div>
	<div>${reply.regDate }</div>
	</div>
	</div>
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-mb__box2">
	<div class="flex-grow-1">${reply.body }</div>
	<c:if test="${loginedMemberId == reply.memberId }">
	<div class="flex flex-ai-c flex-jc-sa reply__btns-mb-2">
	<div class="reply__btns__modify" onclick="modifyFormOpen(this);">수정</div>
	<div class="reply__btns__delete">
	<form class="reply__btns__delete-form" action="${appUrl }/usr/reply/doDeleteArticleReply">
	<input type="submit" value="삭제">
	<input type="hidden" name="id" value="${reply.id }">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	
	</div>
	</div>
	</c:if>
	
	<c:if test="${isLogined }">
	<div class="float-r flex flex-ai-c reply__reply-mb" onclick="replyReplyFormOpen(this);">
	<div>[답글]</div>
	</div>
	</c:if>
	
	</div>
	</c:if>
	
	<c:if test="${reply.status < 0 }">
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-mb__deletedReply">삭제된 댓글입니다.</div>
	</c:if>
	
	</div>
	<!-- 댓글 리스트 본문 모바일버전 끝 -->
	
	
	<!-- 댓글 수정 시작 -->
	<div class="articleDetailBox__reply-modify">
	<form name="writeReplyModifyForm" class="articleDetailBox__reply-modifyform" action="${appUrl }/usr/reply/doModifyArticleReply" method="POST" onsubmit="return modifyFormCheck(this);">
	<input type="hidden" name="body">
	<input type="hidden" name="id" value="${reply.id }">
	<input type="hidden" name="memberId" value="${sessionScope.loginedMemberId }">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${Util.getNewUrl(currentUrl, 'focusReplyId', '[NEW_REPLY_ID]')}">
	<div class="writeReplyBodyInput">
		 <script type="text/x-template"></script>
  <div class="toast-ui-editor"></div>
  </div>
  <div class="flex flex-ai-c flex-jc-e articleDetailBox__reply-modifyform__btns">
  <button class="btn-square submitReplyModify">수정</button><span class="btn-square submitReplyModifyCancel"  onclick="modifyReplyCancel(this);">취소</span>
  </div>  
  </form>
	</div>
	<!-- 댓글 수정 끝 -->
	
	
	
	
	<!-- 대댓글 리스트 시작 -->
	<div class="flex replyReply-container">
	<c:forEach var="replyReply" items="${replies }">
	<c:if test="${replyReply.relType eq 'reply' && replyReply.relId == reply.id}">
	<c:set var="exists" value="true"></c:set>
	</c:if>
	</c:forEach>
	<c:if test="${exists }">
	<div class="replyreplies__arrow"></div>
	</c:if>	
	<c:set var="exists" value="false"></c:set>
	<div class="flex flex-dir-col replyreplies__replyReplyList">
	<c:forEach var="replyReply" items="${replies }">
	<c:if test="${replyReply.relType eq 'reply' && replyReply.relId == reply.id}">	
	<div data-id="${replyReply.id }" class="targetReply flex flex-dir-col replyreplies">
	
	<!-- 대댓글 리스트 PC버전 시작 -->
	
	<div class="flex replyreplies-pc">
	
	<div class="width-100p">
	
	<div class="replyreplies__replyReplyList__replyContainer">
	<c:if test="${replyReply.status > 0 }">
	<div class="flex flex-ai-c replyreplies__replyReplyList__replyContainer__box-1">
	<span class="replyreplies__writer">${replyReply.extra__writer }</span>
	<span class="flex-grow-1 replyreplies__body">${replyReply.body }</span>
	<div class="flex flex-ai-c flex-jc-sa replyreplies__btns-1">
	<div <c:if test="${isLogined }"> class="click"</c:if> <c:if test="${isLogined }">onclick="doLikeReplyBtn(this,${replyReply.id});"</c:if>>	
	<i class="far fa-thumbs-up"></i><span>좋아요 ${replyReply.extra__likeCount }</span>
	</div>
	<div <c:if test="${isLogined }"> class="click"</c:if><c:if test="${isLogined }">onclick="doDisLikeReplyBtn(this,${replyReply.id});"</c:if>>	
	<i class="far fa-thumbs-down"></i><span>싫어요 ${replyReply.extra__dislikeCount }</span>
	</div>
	</div>
	<span class="replyreplies__regDate">${reply.regDate }</span>
	</div>
	<div class="replyreplies__replyReplyList__replyContainer__box-2">
	<c:if test="${loginedMemberId == replyReply.memberId }">
	<div class="float-r flex flex-ai-c flex-jc-sb replyreplies__btns-2">
	<span class="click" onclick="modifyReplyReplyFormOpen(this);">수정</span>
	<form class="click replyreplies__btns-2__deleteForm" action="${appUrl }/usr/reply/doDeleteReplyReply">
	<input class="click" type="submit" value="삭제">
	<input type="hidden" name="id" value="${replyReply.id }">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	</div>
	</c:if>
	</div>
	</c:if>
	
	<c:if test="${replyReply.status < 0 }">
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-pc__deletedReply">삭제된 댓글입니다.</div>
	</c:if>
	
	</div>
	
	</div>
	</div>
	
	
	<!-- 대댓글 리스트 PC버전 끝 -->
	
	<!-- 대댓글 리스트 모바일 시작 -->
	
	<div class="targetReply flex replyreplies-mb">
	<div class="width-100p">
	
	<div class="replyreplies__replyReplyList__replyContainer-mb">
	<c:if test="${replyReply.status > 0 }">
	<div class="flex flex-ai-c replyreplies__replyReplyList__replyContainer__box-1">
	<span class="replyreplies__writer-mb">${replyReply.extra__writer }</span>
	<div class="flex-grow-1"></div>
	
	<span class="replyreplies__regDate-mb">${reply.regDate }</span>
	</div>
	<div class="flex flex-ai-c replyreplies__btns-1-mb">
	<div <c:if test="${isLogined }"> class="click"</c:if><c:if test="${isLogined }">onclick="doLikeReplyBtn(this,${replyReply.id});"</c:if>>
	<i class="far fa-thumbs-up"></i><span>좋아요 ${replyReply.extra__likeCount }</span>
	</div>
	<div <c:if test="${isLogined }"> class="click"</c:if><c:if test="${isLogined }">onclick="doDisLikeReplyBtn(this,${replyReply.id});"</c:if>>
	<i class="far fa-thumbs-down"></i><span>싫어요 ${replyReply.extra__dislikeCount }</span>
	</div>
	</div>
	<div class="replyreplies__body-mb"><span>${replyReply.body }</span></div>
	<div class="replyreplies__replyReplyList__replyContainer__box-2">
	<c:if test="${loginedMemberId == replyReply.memberId }">
	<div class="float-r flex flex-ai-c flex-jc-sb replyreplies__btns-2-mb">
	<span class="click" onclick="modifyReplyReplyFormOpen(this);">수정</span>
	<form class="click replyreplies__btns-2__deleteForm" action="${appUrl }/usr/reply/doDeleteReplyReply">
	<input class="click" type="submit" value="삭제">
	<input type="hidden" name="id" value="${replyReply.id }">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	</div>
	</c:if>
	</div>
	</c:if>
	
	<c:if test="${replyReply.status < 0 }">
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-pc__deletedReply">삭제된 댓글입니다.</div>
	</c:if>
	
	</div>
	
	</div>
	</div>
	<!-- 대댓글 리스트 모바일 끝 -->
	
	
	<!-- 대댓글 수정 시작 -->
	<div class="articleDetailBox__replyReply-modify">
	<form name="writeReplyReplyModifyForm" class="articleDetailBox__replyReply-modifyform" action="${appUrl }/usr/reply/doModifyReplyReply" method="POST" onsubmit="return modifyFormCheck(this);">
	<input type="hidden" name="body">
	<input type="hidden" name="id" value="${replyReply.id }">
	<input type="hidden" name="memberId" value="${sessionScope.loginedMemberId }">
	<input type="hidden" name="afterWriteReplyUrl" value="${Util.getNewUrl(currentUrl, 'focusReplyId', '[NEW_REPLY_ID]')}">
	<div class="writeReplyBodyInput">
		 <script type="text/x-template"></script>
  <div class="toast-ui-editor"></div>
  </div>
  <div class="flex flex-ai-c flex-jc-e articleDetailBox__reply-modifyform__btns">
  <button class="btn-square submitReplyModify">수정</button><span class="btn-square submitReplyModifyCancel" onclick="modifyReplyReplyCancel(this);">취소</span>
  </div>  
  </form>
	</div>
	<!-- 대댓글 수정 끝 -->
	
	</div>
	</c:if>
	</c:forEach>
	</div>
	</div>
	<!-- 대댓글 리스트 끝 -->	
	
	
	
	<!-- 대댓글 작성 시작 -->
	<div class="articleDetailBox__reply-reply">
	<form name="writeReplyReplyForm" class="articleDetailBox__replyReplyForm" action="${appUrl }/usr/reply/doWriteReplyReply" method="POST" onsubmit="return replyReplyFormCheck(this);">
	<input type="hidden" name="body">
	<input type="hidden" name="memberId" value="${loginedMemberId }">
	<input type="hidden" name="replyId" value="${reply.id }">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${Util.getNewUrl(currentUrl, 'focusReplyId', '[NEW_REPLY_ID]')}">
	<div class="writeReplyBodyInput">
		 <script type="text/x-template"></script>
  <div class="toast-ui-editor"></div>
  </div>
  <div class="flex flex-ai-c flex-jc-e replyReply-btns">
  <button class="btn-square replyReply__submit">등록</button><span class="btn-square replyReply__cancel"  onclick="replyReplyCancel(this);">취소</span>
  </div>
	</form>
	</div>	
	<!-- 대댓글 작성 끝 -->
	
	
	
	
	
	
	
	</div>
	</c:if>
	</c:forEach>
	
	</div>
	<!-- 댓글 리스트 본문 끝 -->
	</div>
	<!-- 댓글 리스트 끝 -->
	
	</div>
	<!-- 댓글 끝 -->
	
	</div>
	</main>
<%@ include file="../../part/foot.jspf"%>
