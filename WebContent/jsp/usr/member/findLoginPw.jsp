<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      
   <c:set var="pageTitle" value="로그인 아이디 찾기"/>
<%@ include file="../../part/head.jspf"%>
<script>
let DoLoginForm__submited = false;

function loginFormCheck(){

	if(DoLoginForm__submited){
		alert("처리중입니다.");
		return false;
		}
		
		if (loginForm.loginId.value == "") {
			alert("아이디를 입력해 주세요.");
			return false;
		} else if (loginForm.email.value == "") {
			alert("이메일 주소를 입력해 주세요.");
			return false;
		}
		
		
		
		DoLoginForm__submited = true;
		return true;
		
}
</script>
<div class="con loginForm">
<div class="loginTitle">로그인 비밀번호 찾기</div>
<form name="loginForm" action="doFindLoginPw" method="POST" onsubmit="return loginFormCheck();">
<input id="loginIdForm" class="flex flex-jc-c" name="loginId" placeholder="아이디">
<input id="loginPwForm" type="email" name="email" placeholder="이메일 주소">
   <div class="loginSubmit">
<button id="loginSubmit" type="submit">완료</button>
  </div> 
</form>
</div>
<%@ include file="../../part/foot.jspf"%>