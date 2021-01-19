<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:set var="pageTitle" value="게시판 수정 페이지"/>
<%@ include file="../../part/head.jspf"%>
	
<div class="con writeFormTitle">${board.name} 게시판</div>
<div class="con writeForm">
	<form class="writeFormBox" action="doWrite" style="display: inline-block" method="post">
		<input type="hidden" name="memberId" value="${memberId }">
		 <input	type="hidden" name="boardId" value="${boardId }">
    <span>제목</span>
			<input  class="writeTitleInput" type="text" name="title">	
    <span>본문</span>
		<textarea class="writeBodyInput" name="body"></textarea>
		<input class="writeFormSubmit" type="submit" value="등록">
	</form>
  </div>
<%@ include file="../../part/foot.jspf"%>