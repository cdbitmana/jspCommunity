<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
	function writeFormCheck() {
		if (writeForm.title.value == "") {
			alert("제목은 입력해야 합니다.");
			return false;
		} else if (writeForm.body.value == "") {
			alert("내용을 입력해야 합니다.");
			return false;
		} 
		return true;
	}
</script>

<c:set var="pageTitle" value="게시판 수정 페이지"/>
<%@ include file="../../part/head.jspf"%>
	
<div class="con writeFormTitle">${board.name} 게시판</div>
<div class="con writeForm">
	<form name="writeForm" class="writeFormBox" action="doWrite" style="display: inline-block" method="post" onsubmit="return writeFormCheck();">
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