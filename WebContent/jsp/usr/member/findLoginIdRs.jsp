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
		
		if (loginForm.name.value == "") {
			alert("이름을 입력해 주세요.");
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
<div class="loginTitle">로그인 아이디 찾기</div>
<div class="flex flex-dir-col flex-jc-c flex-ai-c findLoginIdRs">
<div>${data.msg }</div>
<c:if test="${data.isFail() }">
<form name="loginForm"action="doFindLoginId" method="POST" onsubmit="return loginFormCheck();">
<input id="loginIdForm" class="flex flex-jc-c" name="name" placeholder="이름" value="${data.body.get('name') }">
<div class="findLoginIdFormNameCheckRs"></div>
<input id="loginPwForm" type="email" name="email" placeholder="이메일 주소" value="${data.body.get('email') }">
   <div class="loginSubmit">
<button id="loginSubmit" type="submit">완료</button>
  </div> 
</form>
</c:if>
<div class="flex flex-jc-c flex-ai-c flex-jc-s-ar findLoginIdRs__login">
<a href="login">로그인</a>
<a href="findLoginPw">비밀번호 찾기</a>
</div>
</div>
</div>
<%@ include file="../../part/foot.jspf"%>