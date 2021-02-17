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
</script>

<script>
let DoWriteForm__submited = false;

function writeFormCheck(el) {
	if ( DoWriteForm__submited ) {
		alert('처리중입니다.');
		return false;
	}
	
	const editor = $(el).find('.toast-ui-editor').data('data-toast-editor');
	const body = editor.getMarkdown().trim();
	
	const memberId = writeReplyForm.memberId.value;
	const articleId = writeReplyForm.articleId.value;
	const afterWriteReplyUrl = writeReplyForm.afterWriteReplyUrl.value;
	
	if ( body.length == 0 ) {
		alert('내용을 입력해주세요.');
		editor.focus();
		
		return false;
	}
	
	writeReplyForm.body.value = body;
	
	
	$.get(
			"${appUrl}/usr/reply/doWriteArticleReply",
			{
				body : writeReplyForm.body.value,
				memberId,
				articleId,
				afterWriteReplyUrl
			},
			function(data) {
			loadRepliesList();
			},
			"json"
		);
	
	return false;
}
</script>


<script>
	let writeReplyReplyForm__submited = false;
	
	function replyReplyFormCheck(el){
	
	if ( writeReplyReplyForm__submited ) {
		alert('처리중입니다.');
		return false;
	}
	
	
	const editor = $(el).find('.toast-ui-editor').data('data-toast-editor');
	const body = editor.getMarkdown().trim();
	
	$(el).closest('form').get(0).body.value = body;
	
	if ( body.length == 0 ) {
		alert('내용을 입력해주세요.');
		editor.focus();		
		return false;
	}
	
	
	$.get(
			"${appUrl}/usr/reply/doWriteReplyReply",
			{
				body,
				replyId : $(el).closest('form').get(0).replyId.value,
				memberId : $(el).closest('form').get(0).memberId.value,
				articleId : $(el).closest('form').get(0).articleId.value,
				afterWriteReplyUrl : $(el).closest('form').get(0).afterWriteReplyUrl.value
			},
			function(data) {
			loadRepliesList();
			},
			"json"
		);
		return false;
	
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

</script>
  
  
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
	
	
<script>

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

</script>
	
	
	
	
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
	<form name="writeReplyForm" class="articleDetailBox__reply-form" action="" method="POST" onsubmit="writeFormCheck(this); return false;">
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
	
	<script>
	
	var newHtml;
	
	function loadRepliesList(){
		
	$.get('${appUrl}/usr/reply/getReplies',
	{
	
	}, function(data){	
	
	if(data.body != null){
	
	
	data.body = data.body.reverse();
	
	newHtml.html('');
	
		for ( var i = 0 ; i < data.body.length ; i++ ) {
		
			var reply = data.body[i];
			
			var tmpBox1 = "";
			var tmpBox2 = "";
			
			if ( reply.relType == 'article' && reply.relId == ${article.id} ) {
			
				tmpBox1 = $('.template-box').html();
				
				if ( reply.status > 0 ) {
					tmpBox1 = replaceAll(tmpBox1 , "{$RstatusTrue}","");
					tmpBox1 = replaceAll(tmpBox1 , "{$RstatusFalse}","dp-none");
				} else if ( reply.status < 0 ) {
					tmpBox1 = replaceAll(tmpBox1 , "{$RstatusTrue}","dp-none");
					tmpBox1 = replaceAll(tmpBox1 , "{$RstatusFalse}","");
				}
				
				if ( ${isLogined} ) {
					tmpBox1 = replaceAll(tmpBox1 , "{$R클릭}","click");
					tmpBox1 = replaceAll(tmpBox1 , "{$R온클릭1}","doLikeReplyBtn(this,"+reply.id+");");
					tmpBox1 = replaceAll(tmpBox1 , "{$R온클릭2}","doDisLikeReplyBtn(this,"+reply.id+");");
					tmpBox1 = replaceAll(tmpBox1 , "{$R로그인여부}","");
				} else {
					tmpBox1 = replaceAll(tmpBox1 , "{$R로그인여부}","dp-none");
				}
				
				if ( reply.memberId == ${loginedMemberId} ) {
					tmpBox1 = replaceAll(tmpBox1 , "{$R내가쓴댓글}","");
				} else {
					tmpBox1 = replaceAll(tmpBox1 , "{$R내가쓴댓글}","dp-none");
				}
				
				tmpBox1 = replaceAll(tmpBox1 , "{$R번호}" , reply.id);
				tmpBox1 = replaceAll(tmpBox1 , "{$R작성자}" , reply.extra__writer);
				tmpBox1 = replaceAll(tmpBox1 , "{$R날짜}" , reply.regDate);
				tmpBox1 = replaceAll(tmpBox1 , "{$R내용}" , reply.body);
				tmpBox1 = replaceAll(tmpBox1 , "{$R좋아요}" , reply.extra__likeCount);
				tmpBox1 = replaceAll(tmpBox1 , "{$R싫어요}" , reply.extra__dislikeCount);
				
				var isExistsRR = false;
				
					for ( var j = data.body.length-1 ; j >= 0; j -- ) {
			
						var replyReply = data.body[j];
				
						if ( replyReply.relType == 'reply' && replyReply.relId == reply.id ) {
						
							isExistsRR = true;
				
							tmpBox2Html = $('.template-box-2').html();
					
						if ( replyReply.status > 0 ) {
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RRstatusTrue}","");
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RRstatusFalse}","dp-none");
						} else {
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RRstatusTrue}","dp-none");
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RRstatusFalse}","");
						}
				
						if ( ${isLogined} ) {
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RR클릭}","click");
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RR온클릭1}","doLikeReplyBtn(this,"+replyReply.id+");");
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RR온클릭2}","doDisLikeReplyBtn(this,"+replyReply.id+");");
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RR로그인여부}","");
						} else {
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RR로그인여부}","dp-none");
						}
				
						if ( replyReply.memberId == ${loginedMemberId} ) {
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RR내가쓴댓글}","");
						} else {
							tmpBox2Html = replaceAll(tmpBox2Html , "{$RR내가쓴댓글}","dp-none");
						}
				
						tmpBox2Html = replaceAll(tmpBox2Html , "{$RR번호}" , replyReply.id);
						tmpBox2Html = replaceAll(tmpBox2Html , "{$RR작성자}" , replyReply.extra__writer);
						tmpBox2Html = replaceAll(tmpBox2Html , "{$RR날짜}" , replyReply.regDate);
						tmpBox2Html = replaceAll(tmpBox2Html , "{$RR내용}" , replyReply.body);
						tmpBox2Html = replaceAll(tmpBox2Html , "{$RR좋아요}" , replyReply.extra__likeCount);
						tmpBox2Html = replaceAll(tmpBox2Html , "{$RR싫어요}" , replyReply.extra__dislikeCount);
						
						tmpBox2 += tmpBox2Html;
											
				}
				
				
			
			}
				
				if ( isExistsRR ) {
						tmpBox1 = replaceAll(tmpBox1 , "{$대댓글리스트}" , tmpBox2 );
				} else {
						tmpBox1 = replaceAll(tmpBox1 , "{$대댓글리스트}" , "" );
				}
				newHtml.prepend(tmpBox1);
				
			} 
			
				
			
		}
	
		
	
	$('.toast-ui-editor').html('');
	EditorViewer__init();
	Editor__init();	

	
	if ( param.focusReplyId ) {
			const $target = $('.real .targetReply[data-id="' + param.focusReplyId + '"]');
			$target.addClass('focus');
			
			setTimeout(function() {
				const targetOffset = $target.offset();
				$(window).scrollTop(targetOffset.top);
				
				setTimeout(function() {
					$target.removeClass('focus');
				}, 1000);
			}, 1000);
		}

	}
	else {
	$('.toast-ui-editor').html('');
	EditorViewer__init();
	Editor__init();
	}	
	},
	'json'
	);	
	
	}
	
	$(function() {
		newHtml = $('.articleDetailBox__articleReplyList__replies.real');
		loadRepliesList();
	});
	</script>
	
	
	<!-- 댓글 템플릿 시작 -->
	<div class="template-box articleDetailBox__articleReplyList__replies">
	<div data-id="{$R번호}" class="template-box-1 flex flex-dir-col targetReply articleDetailBox__articleReplyList__reply">
	
	<!-- 댓글 리스트 본문 PC버전 시작 -->	
	
	<div class="template-box-replyList-pc flex flex-dir-col articleDetailBox__articleReplyList__reply-1-pc">
		
	<div class="{$RstatusTrue}">
	<div class="flex articleDetailBox__articleReplyList__reply-1-pc__box-1">	
	<div class="reply__writer">{$R작성자}</div>
	<div class="flex-grow-1 reply__body">{$R내용}</div>		
	<div class="flex flex-ai-c flex-jc-sa reply__btns-2">
	<div class="reply__btns__like {$R클릭}" onclick="{$R온클릭1}"><i class="far fa-thumbs-up"></i><span class="replyLikeCount">좋아요 {$R좋아요}</span></div>
	<div class="reply__btns__dislike {$R클릭}" onclick="{$R온클릭2}"><i class="far fa-thumbs-down"></i><span class="replyDislikeCount">싫어요 {$R싫어요}</span></div>	</div>
	<div class="reply__regDate">{$R날짜}</div>
	</div>
	
	<div class="articleDetailBox__articleReplyList__reply-1-pc__box-2">
	<div class="{$R내가쓴댓글}">
	<div class="float-l reply__btns-1 flex flex-ai-c flex-jc-sb">
	<div class="reply__btns__modify click" onclick="modifyFormOpen(this);">수정</div>
	<div class="reply__btns__delete click">
	<form class="reply__btns__delete-form" action="" onsubmit="if ( confirm('정말 삭제하시겠습니까?') ) {doDeleteArticleReply(this);} return false;">
	<input type="submit" value="삭제">
	<input type="hidden" name="id" value="{$R번호}">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	</div>
	</div>	
	</div>
	
	<script>
	function doDeleteArticleReply(el){
	
		$.get(
			"${appUrl}/usr/reply/doDeleteArticleReply",
			{
				id : $(el).closest('form').get(0).id.value,
				articleId: $(el).closest('form').get(0).articleId.value
			},
			function(data) {
			loadRepliesList();
			},
			"json"
		);
	}
	</script>
	
	<div class="{$R로그인여부} float-r flex flex-ai-c reply__reply" onclick="replyReplyFormOpen(this);">
	<div class="click">[답글]</div>
	</div>
	
	</div>
	</div>
	
	
	
	<div class="{$RstatusFalse}">
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-pc__deletedReply">삭제된 댓글입니다.</div>
	</div>
	
	
	</div>	
	
	
	 
	<!-- 댓글 리스트 본문 PC버전 끝 -->
	
	<!-- 댓글 리스트 본문 모바일버전 시작 -->
	<div class="flex flex-dir-col articleDetailBox__articleReplyList__reply-1-mb">	
	
	<div class="{$RstatusTrue}">
	<div class="flex flex-ai-c flex-jc-sb articleDetailBox__articleReplyList__reply-1-mb__box1">
	<div>{$R작성자}</div>
	<div class="flex flex-ai-c">	
	<div class="flex flex-ai-c flex-jc-sa reply__btns-mb-1">
	<div class="reply__btns__like {$R클릭}" onclick="{$R온클릭1}"><i class="far fa-thumbs-up"></i><span class="replyLikeCount">좋아요 {$R좋아요}</span></div>
	<div class="reply__btns__dislike {$R클릭}" onclick="{$R온클릭1}"><i class="far fa-thumbs-down"></i><span class="replyDislikeCount">싫어요 {$R싫어요}</span></div>
	</div>
	<div>{$R날짜}</div>
	</div>
	</div>
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-mb__box2">
	<div class="flex-grow-1">{$R내용}</div>
	<div class="{$R내가쓴댓글}">
	<div class="flex flex-ai-c flex-jc-sa reply__btns-mb-2">
	<div class="reply__btns__modify" onclick="modifyFormOpen(this);">수정</div>
	<div class="reply__btns__delete">
	<form class="reply__btns__delete-form" action="" onsubmit="if ( confirm('정말 삭제하시겠습니까?') ) {doDeleteArticleReply(this);} return false;">
	<input type="submit" value="삭제">
	<input type="hidden" name="id" value="{$R번호}">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	
	</div>
	</div>
	</div>
	
	
	<div class="{$R로그인여부}">
	<div class="float-r flex flex-ai-c reply__reply-mb" onclick="replyReplyFormOpen(this);">
	<div>[답글]</div>
	</div>
	</div>
	
	</div>
	</div>
	
	
	
	<div class="{$RstatusFalse}">
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-mb__deletedReply">삭제된 댓글입니다.</div>
	</div>
	
	</div>
	
	
	<!-- 댓글 리스트 본문 모바일버전 끝 -->
	
	<!-- 댓글 수정 시작 -->
   	<script>
	function modifyFormOpen(el){
	const form = $(el).parents().parents().siblings('.articleDetailBox__reply-modify');
	$(form).css({
		'display':'block',
		'margin-top':'15px'
		});
	}

	function modifyReplyCancel(el){
	const form = $(el).parents().parents('.articleDetailBox__reply-modify');
	$(form).css('display','none');
	}
	
	
	DoModifyForm__submited = false;

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
	
		$.get(
			"${appUrl}/usr/reply/doModifyArticleReply",
			{
				body,
				replyId : $(el).closest('form').get(0).replyId.value,
				memberId : $(el).closest('form').get(0).memberId.value,
				articleId : $(el).closest('form').get(0).articleId.value,
				afterWriteReplyUrl : $(el).closest('form').get(0).afterWriteReplyUrl.value
			},
			function(data) {
			loadRepliesList();
			},
			"json"
		);
	
	return true;
}
	</script>	
	
	<div class="articleDetailBox__reply-modify">
	<form name="writeReplyModifyForm" class="articleDetailBox__reply-modifyform" action="" method="POST" onsubmit="modifyFormCheck(this); return false;">
	<input type="hidden" name="body">
	<input type="hidden" name="replyId" value="{$R번호}">
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
	{$대댓글리스트}
	
	<!-- 대댓글 작성 시작 -->
	<script>
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
	</script>
	
	<div class="articleDetailBox__reply-reply">
	<form name="writeReplyReplyForm" class="articleDetailBox__replyReplyForm" action="" method="POST" onsubmit="replyReplyFormCheck(this); return false;">
	<input type="hidden" name="body">
	<input type="hidden" name="memberId" value="${loginedMemberId }">
	<input type="hidden" name="replyId" value="{$R번호}">
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
	</div>
		
	
	<div class="template-box template-box-2">
	<!-- 대댓글 리스트 시작 -->
	<div class="flex replyReply-container">
	
	<div class="replyreplies__arrow"></div>
	
	<div class="flex flex-dir-col replyreplies__replyReplyList">
	
	<div data-id="{$RR번호}" class="targetReply flex flex-dir-col replyreplies">
	
	<!-- 대댓글 리스트 PC버전 시작 -->	
	<div class="flex replyreplies-pc">
	
	<div class="width-100p">
	
	<div class="replyreplies__replyReplyList__replyContainer">
	<div class="{$RRstatusTrue}">
	<div class="flex flex-ai-c replyreplies__replyReplyList__replyContainer__box-1">
	<span class="replyreplies__writer">{$RR작성자}</span>
	<span class="flex-grow-1 replyreplies__body">{$RR내용}</span>
	<div class="flex flex-ai-c flex-jc-sa replyreplies__btns-1">
	<div class="{$RR클릭}" onclick="{$RR온클릭1}">	
	<i class="far fa-thumbs-up"></i><span>좋아요 {$RR좋아요}</span>
	</div>
	<div class="{$RR클릭}" onclick="{$RR온클릭2}">	
	<i class="far fa-thumbs-down"></i><span>싫어요 {$RR싫어요}</span>
	</div>
	</div>
	<span class="replyreplies__regDate">{$RR날짜}</span>
	</div>
	<div class="replyreplies__replyReplyList__replyContainer__box-2">
	<div class="{$RR내가쓴댓글}">
	<div class="float-r flex flex-ai-c flex-jc-sb replyreplies__btns-2">
	<span class="click" onclick="modifyReplyReplyFormOpen(this);">수정</span>
	<form class="click replyreplies__btns-2__deleteForm" action="" onsubmit="if ( confirm('정말 삭제하시겠습니까?') ) {doDeleteReplyReply(this);} return false;">
	<input class="click" type="submit" value="삭제">
	<input type="hidden" name="id" value="{$RR번호}">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	</div>
	</div>
	</div>
	</div>
	
	<div class="{$RRstatusFalse}">
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-pc__deletedReply">삭제된 댓글입니다.</div>
	</div>
	
	</div>
	
	</div>
	</div>
	
	
	<!-- 대댓글 리스트 PC버전 끝 -->
	
	<!-- 대댓글 리스트 모바일 시작 -->	
	<div class="targetReply flex replyreplies-mb">
	<div class="width-100p">
	
	<div class="replyreplies__replyReplyList__replyContainer-mb">
	<div class="{$RRstatusTrue}">
	<div class="flex flex-ai-c replyreplies__replyReplyList__replyContainer__box-1">
	<span class="replyreplies__writer-mb">{$RR작성자}</span>
	<div class="flex-grow-1"></div>
	
	<span class="replyreplies__regDate-mb">{$RR날짜}</span>
	</div>
	<div class="flex flex-ai-c replyreplies__btns-1-mb">
	<div class="{$RR클릭}" onclick="{$RR온클릭1}">
	<i class="far fa-thumbs-up"></i><span>좋아요 {$RR좋아요}</span>
	</div>
	<div  class="{$RR클릭}" onclick="{$RR온클릭2}">
	<i class="far fa-thumbs-down"></i><span>싫어요 {$RR싫어요}</span>
	</div>
	</div>
	<div class="replyreplies__body-mb"><span>{$RR내용}</span></div>
	<div class="replyreplies__replyReplyList__replyContainer__box-2">
	<div class="{$RR내가쓴댓글}">
	<div class="float-r flex flex-ai-c flex-jc-sb replyreplies__btns-2-mb">
	<span class="click" onclick="modifyReplyReplyFormOpen(this);">수정</span>
	<form class="click replyreplies__btns-2__deleteForm" action="" onsubmit="if ( confirm('정말 삭제하시겠습니까?') ) {doDeleteReplyReply(this);} return false;">
	<input class="click" type="submit" value="삭제">
	<input type="hidden" name="id" value="{$RR번호}">
	<input type="hidden" name="articleId" value="${article.id }">
	<input type="hidden" name="afterWriteReplyUrl" value="${currentUrl }">
	</form>
	</div>
	</div>
	</div>
	</div>
	
	<script>
	function doDeleteReplyReply(el){
	
		$.get(
			"${appUrl}/usr/reply/doDeleteArticleReply",
			{
				id : $(el).closest('form').get(0).id.value,
				articleId: $(el).closest('form').get(0).articleId.value
			},
			function(data) {
			loadRepliesList();
			},
			"json"
		);
	}
	</script>

	<div class="{$RRstatusFalse}">
	<div class="flex flex-ai-c articleDetailBox__articleReplyList__reply-1-pc__deletedReply">삭제된 댓글입니다.</div>
	</div>
	
	</div>
	
	</div>
	</div>
	<!-- 대댓글 리스트 모바일 끝 -->
	
	<!-- 대댓글 수정 시작 -->
	<script>
	function modifyReplyReplyFormOpen(el){
	const form = $(el).parents().parents().parents().parents().parents().parents().parents().siblings('.articleDetailBox__replyReply-modify');
	$(form).css({
		'display':'block',
		'margin-top':'15px'
		});
	}
	
	function modifyReplyReplyCancel(el){
	const form = $(el).parents().parents().parents('.articleDetailBox__replyReply-modify');
		$(form).css('display','none');
	}
	
	DoModifyForm__submited = false;
	
	function modifyReplyReplyFormCheck(el){
	
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
	
	$.get(
			"${appUrl}/usr/reply/doModifyReplyReply",
			{
				body,
				replyId : $(el).closest('form').get(0).replyId.value,
				memberId : $(el).closest('form').get(0).memberId.value,
				afterWriteReplyUrl : $(el).closest('form').get(0).afterWriteReplyUrl.value
			},
			function(data) {
			loadRepliesList();
			},
			"json"
		);
	}
	
	</script>
	
	
	<div class="articleDetailBox__replyReply-modify">
	<form name="writeReplyReplyModifyForm" class="articleDetailBox__replyReply-modifyform" action="" method="POST" onsubmit="modifyReplyReplyFormCheck(this); return false;">
	<input type="hidden" name="body">
	<input type="hidden" name="replyId" value="{$RR번호}">
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
	</div>
	<!-- 대댓글 리스트 끝 -->	
	
	
	
	
	
	

	</div>
	</div>
	<!-- 댓글 템플릿 끝 -->
	
	
	<!-- 댓글 실제 -->
	<div class="articleDetailBox__articleReplyList__replies real">
	
	
	</div>
	<!-- 댓글 실제 -->
	
	<!-- 댓글 리스트 본문 끝 -->
	</div>
	<!-- 댓글 리스트 끝 -->
	
	</div>
	<!-- 댓글 끝 -->
	
	
	
	</div>
	</main>

<%@ include file="../../part/foot.jspf"%>
