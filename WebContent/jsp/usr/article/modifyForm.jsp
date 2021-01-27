<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시판 수정 페이지"/>
<%@ include file="../../part/head.jspf"%>
<script>
let DoModifyForm__submited = false;

	function modifyFormCheck() {
		if ( DoModifyForm__submited ) {
			alert('처리중입니다.');
			return;
		}
		
		
		
		const editor = $('form').find('.toast-ui-editor').data('data-toast-editor');
		const body = editor.getMarkdown().trim();
		
		if ( body.length == 0 ) {
			alert('내용을 입력해주세요.');
			editor.focus();
			
			return;
		}
		
		modifyForm.body.value = body;
		
		return true;
	}
</script>

	<div class="con articleModifyBox">
	
<span>제목</span>

	<form class="articleModifyForm" name="modifyForm" action="doModify" style="display:inline-block" method="post" onsubmit="return modifyFormCheck();">
		<input type="hidden" name="memberId" value="${memberId }">	
		<input type="hidden" name="body"  >	
		 <input
			type="hidden" name="id" value="${id }"> 		
			<input class="articleModifyTitle" type="text"
			name="title" value="${title }">
			<span>본문</span>
			<div class="articleModifyBody">
	  <script type="text/x-template"></script>
  <div class="toast-ui-editor"></div>
  </div>		
		<input class="articleModifySubmit" type="submit" value="등록">
		
	</form>    
	
    </div>
  
<%@ include file="../../part/foot.jspf"%>