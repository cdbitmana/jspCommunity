<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <c:set var="pageTitle" value="로그인"/>
<%@ include file="../../part/head.jspf"%>

<h1>로그인</h1>
<form action="doLogin" method="POST">
<div>아이디
<input name="loginId">
</div>
<div>비밀번호
<input name="loginPw">
</div>
<input type="submit" value="완료">
</form>
<%@ include file="../../part/foot.jspf"%>