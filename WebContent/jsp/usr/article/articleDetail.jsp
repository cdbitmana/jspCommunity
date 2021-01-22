<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시판 상세 페이지"/>
<%@ include file="../../part/head.jspf"%>
<div class="con articleDetailBox">
<span class="articleDetailTitle">${article.title}</span>
    <div class="flex flex-ai-c articleDetailInfo">
    <span class="articleDetailWriter">${article.extra__writer}</span>
      <span class="articleDetailRegDate">${article.regDate}</span>
       <c:if test="${article.memberId == isLoginedMemberId }">
     <form class="articleDetailModify" action="/jspCommunity/usr/article/modify" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="hidden" name="title" value="${article.title }">
	<input type="hidden" name="body" value="${article.body }">
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
    
    <div class="articleDetailBody">
      ${article.body}
    </div>
    
	<div class="articleDetailToList">
	<a href="/jspCommunity/usr/article/list?boardId=${article.boardId }">목록</a>
	</div>
	</div>
<%@ include file="../../part/foot.jspf"%>
