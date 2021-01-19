<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 가입" />
<script>
	function joinFormCheck() {

		if (joinForm.loginId.value == "") {
			alert("아이디를 입력해 주세요.");
			return false;
		} else if (joinForm.loginPw.value == "") {
			alert("비밀번호를 입력해 주세요.");
			return false;
		} else if (joinForm.name.value == "") {
			alert("이름을 입력해 주세요.");
			return false;
		} else if (joinForm.nickName.value == "") {
			alert("닉네임을 입력해 주세요.");
			return false;
		} else if (joinForm.email.value == "") {
			alert("이메일을 입력해 주세요.");
			return false;
		} else if (joinForm.phoneNo.value == "") {
			alert("전화번호를 입력해 주세요.");
			return false;
		}
		return true;
	}
</script>
<%@ include file="../../part/head.jspf"%>

<div class="joinForm">
	<div class="joinTitle">회원가입</div>
	<form name="joinForm" action="doJoin" method="POST"
		onsubmit="return joinFormCheck();">
		<input name="loginId" placeholder="아이디"> <input
			type="password" name="loginPw" placeholder="비밀번호"> <input
			name="name" placeholder="이름"> <input name="nickName"
			placeholder="닉네임"> <input type="email" name="email"
			placeholder="이메일"> <input name="phoneNo" placeholder="전화번호">
		<div class="joinSubmit">
			<input id="joinSubmit" type="submit" value="완료">
		</div>
	</form>
</div>
<%@ include file="../../part/foot.jspf"%>