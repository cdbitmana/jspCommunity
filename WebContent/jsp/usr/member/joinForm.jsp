<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <c:set var="pageTitle" value="회원 가입"/>
   <script>
function joinFormCheck(){
	
	if(joinForm.loginId.value == ""){
		alert("아이디를 입력해 주세요.");
		return false;
		}
	else if(joinForm.loginPw.value==""){
		alert("비밀번호를 입력해 주세요.");
		return false;
		}
	else if(joinForm.name.value==""){
		alert("이름을 입력해 주세요.");
		return false;
		}
	else if(joinForm.nickName.value==""){
		alert("닉네임을 입력해 주세요.");
		return false;
		}
	return true;
}
   </script>
<%@ include file="../../part/head.jspf"%>

<h1>회원 가입</h1>
<form name="joinForm" action="doJoin" method="POST" onsubmit="return joinFormCheck();">
<div>아이디
<input name="loginId">
</div>
<div>비밀번호
<input name="loginPw">
</div>
<div>이름
<input name="name">
</div>
<div>닉네임
<input name="nickName">
</div>
<input type="submit" value="완료">
</form>
<%@ include file="../../part/foot.jspf"%>