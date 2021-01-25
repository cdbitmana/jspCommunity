<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      
   <c:set var="pageTitle" value="로그인 아이디 찾기"/>
<%@ include file="../../part/head.jspf"%>

<div class="con loginForm">
<div class="loginTitle">로그인 비밀번호 찾기</div>
<div class="flex flex-dir-col flex-jc-c flex-ai-c findLoginIdRs">
<div>${data.msg}</div>
<c:if test="${data.isFail() }">
<form name="loginForm"action="doFindLoginPw" method="POST" onsubmit="return loginFormCheck();">
<input id="loginIdForm" class="flex flex-jc-c" name="loginId" placeholder="아이디" value="${data.body.get('loginId') }">
<div class="findLoginIdFormNameCheckRs"></div>
<input id="loginPwForm" type="email" name="email" placeholder="이메일 주소" value="${data.body.get('email') }">
   <div class="loginSubmit">
<button id="loginSubmit" type="submit">완료</button>
  </div> 
</form>
</c:if>
<div class="flex flex-jc-c flex-ai-c flex-jc-s-ar findLoginIdRs__login">
<a href="login">로그인</a>
</div>
</div>
</div>
<%@ include file="../../part/foot.jspf"%>