<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <c:set var="pageTitle" value="로그인"/>
<%@ include file="../../part/head.jspf"%>

<div class="con loginForm">
<div class="loginTitle">로그인</div>
<form action="doLogin" method="POST">
<input id="loginIdForm" class="flex flex-jc-c" name="loginId" placeholder="아이디">
<input id="loginPwForm" type="password" name="loginPw" placeholder="비밀번호">
  <div class="loginSubmit">
<button id="loginSubmit" type="submit">완료
  </div>
</form>
</div>
<%@ include file="../../part/foot.jspf"%>