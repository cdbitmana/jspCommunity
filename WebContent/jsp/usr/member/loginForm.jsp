<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <%@ include file="../../part/head.jspf"%>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js" ></script>
   <c:set var="pageTitle" value="로그인"/>

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
		} else if (loginForm.loginPw.value == "") {
			alert("비밀번호를 입력해 주세요.");
			return false;
		}
		
		 loginForm.loginPwReal.value = sha256(loginForm.loginPw.value);
		 loginForm.loginPw.value = "";
		
		DoLoginForm__submited = true;
		return true;
		
}
</script>
<main class="con-min-width">
<div class="con loginForm">
<div class="loginTitle">로그인</div>
<form name="loginForm"action="doLogin" method="POST" onsubmit="return loginFormCheck();">
<input type="hidden" name="afterLoginUrl" value="${param.afterLoginUrl }"/>
<input id="loginIdForm" class="flex flex-jc-c" name="loginId" placeholder="아이디">
<input type="hidden" name="loginPwReal">
<input id="loginPwForm" type="password" name="loginPw" placeholder="비밀번호">
 <div class="findMember flex flex-ai-c flex-jc-c">
  <a href="findLoginId">아이디 찾기</a>
  <a href="findLoginPw">비밀번호 찾기</a>
  </div>
  <div class="submitButtonBox">
<button class="submitButton" type="submit">완료</button>
  </div>
 
</form>
</div>
</main>
<%@ include file="../../part/foot.jspf"%>