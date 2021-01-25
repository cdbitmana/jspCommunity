<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js" integrity="sha512-szJ5FSo9hEmXXe7b5AUVtn/WnL8a5VofnFeYC2i2z03uS2LhAch7ewNLbl5flsEmTTimMN0enBZg/3sQ+YOSzQ==" crossorigin="anonymous"></script>
   <c:set var="pageTitle" value="로그인"/>
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
<div class="con loginForm">
<div class="loginTitle">로그인</div>
<form name="loginForm"action="doLogin" method="POST" onsubmit="return loginFormCheck();">
<input id="loginIdForm" class="flex flex-jc-c" name="loginId" placeholder="아이디">
<input type="hidden" name="loginPwReal">
<input id="loginPwForm" type="password" name="loginPw" placeholder="비밀번호">
  <div class="loginSubmit">
<button id="loginSubmit" type="submit">완료</button>
  </div>
</form>
</div>
<%@ include file="../../part/foot.jspf"%>