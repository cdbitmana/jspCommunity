<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="${article.title }"/>

<%@ include file="../../part/head.jspf"%>
<main class="con-min-width">
<div class="con articleDetailBox">
<span class="articleDetailTitle">${article.title}</span>
<!-- 게시물 상세보기 상단 정보 PC버전 시작 -->
    <div class="flex flex-ai-c articleDetailInfo articleDetailInfo-pc">
    <span class="articleDetailWriter">${article.extra__writer}</span>
      <span class="articleDetailRegDate">${article.regDate}</span>
       <c:if test="${article.memberId == loginedMemberId }">
     <form class="articleDetailModify" action="/jspCommunity/usr/article/modify" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="hidden" name="title" value="${article.title }">
	<input type="hidden" name="body" value="${article.body }">
	<input type="hidden" name="page" value="${param.page }">
	<input type="submit" value="수정">
	</form>
    <form class="articleDetailDelete" action="/jspCommunity/usr/article/doDelete" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="submit" value="삭제">
	</form>
	</c:if>
      <span class="articleDetailHit">조회수: ${article.hitCount}</span>
      </div>	
<!-- 게시물 상세보기 상단 정보 PC버전 끝 -->

<!-- 게시물 상세보기 상단 정보 모바일 버전 시작 -->
<div class="articleDetailInfo articleDetailInfo-mb">
<div>
    <span class="articleDetailWriter">${article.extra__writer}</span>
      <span class="articleDetailRegDate">${article.regDate}</span>
      <span class="articleDetailHit">조회수: ${article.hitCount}</span>
      </div>
      <div>
      <c:if test="${article.memberId == loginedMemberId }">
     <form class="articleDetailModify" action="/jspCommunity/usr/article/modify" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="hidden" name="title" value="${article.title }">
	<input type="hidden" name="body" value="${article.body }">
	<input type="hidden" name="page" value="${param.page }">
	<input type="submit" value="수정">
	</form>
    <form class="articleDetailDelete" action="/jspCommunity/usr/article/doDelete" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="submit" value="삭제">
	</form>
	</c:if>  
	</div> 
      </div>
<!-- 게시물 상세보기 상단 정보 모바일 버전 끝 -->      
    
    <div class="articleDetailBody">
      <script type="text/x-template">${article.body }</script>
  <div class="toast-ui-viewer"></div>
    </div>
    
	<div class="articleDetailToList">
	<a href="/jspCommunity/usr/article/list?boardId=${article.boardId }&page=${param.page}">목록</a>
	</div>
	</div>
	</main>
<%@ include file="../../part/foot.jspf"%>
