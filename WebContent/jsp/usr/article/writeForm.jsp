<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../../part/head.jspf"%>
<script>
let DoWriteForm__submited = false;

	function writeFormCheck() {
		if ( DoWriteForm__submited ) {
			alert('처리중입니다.');
			return;
		}
		
		writeForm.title.value = writeForm.title.value.trim();
		
		if (writeForm.title.value.length == 0) {
			alert("제목을 입력해야 합니다.");
			return false;
		} 
		
		const editor = $('form').find('.toast-ui-editor').data('data-toast-editor');
		const body = editor.getMarkdown().trim();
		
		if ( body.length == 0 ) {
			alert('내용을 입력해주세요.');
			editor.focus();
			
			return;
		}
		
		writeForm.body.value = body;
		
		return true;
	}
</script>

<c:set var="pageTitle" value="${board.name } 게시물 작성"/>

	<main class="con-min-width">
	
<div class="con">
<div class="writeFormContainer">
<div class="writeFormTitle">${board.name} 게시판</div>
<div class="writeForm">
	<form name="writeForm" class="writeFormBox" action="doWrite" style="display: inline-block" method="post" onsubmit="return writeFormCheck();">
	<input type="hidden" name="page" value="1">
		<input type="hidden" name="memberId" value="${memberId }">
		 <input	type="hidden" name="boardId" value="${boardId }">
		 <input type="hidden" name="body">
    <span>제목</span>
    
			<input  class="writeTitleInput" type="text" name="title">
			
    <span>본문</span>
    <div class="writeBodyInput">
		 <script type="text/x-template"></script>
  <div class="toast-ui-editor"></div>
  </div>
		<input class="writeFormSubmit" type="submit" value="등록">
	</form>
	</div>
  </div>
  </div>
  </main>
<%@ include file="../../part/foot.jspf"%>