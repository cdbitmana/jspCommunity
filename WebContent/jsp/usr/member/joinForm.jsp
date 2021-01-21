<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="회원 가입" />

<script>
	let DoJoinForm__submited = false;
	let DoJoinForm__checkedLoginId = "";
	
	function DoJoinForm__checkLoginIdDup(el) {
		const from = $(el).closest('form').get(0);
		
		const loginId = from.loginId.value;
		
		if(loginId.length == 0){
		$('.rs').text('아이디를 입력해주세요.');
		$('.rs').css('color','black');
		$('.loginIdCheckBox').prop("checked",false);
					$('.loginIdInput').focus();
		return;
		}
		
		$.get(
			"getLoginIdDup",
			{
				loginId
			},
			function(data) {
			console.log(data);
				if ( data.resultCode.substr(0,2) == "S-" ) {
					$('.rs').text('해당 아이디는 사용가능합니다.');
					$('.rs').css('color','green');
					DoJoinForm__checkedLoginId = loginId;
				}
				else {
					$('.rs').text("해당 로그인 아이디는 이미 사용중 입니다.");
					$('.loginIdCheckBox').prop("checked",false);
					$('.loginIdInput').focus();
					$('.rs').css('color','red');
					DoJoinForm__checkedLoginId = "";
				}
			},
			"json"
		);
	}
	
	function joinFormCheck() {
		if(DoJoinForm__submited){
		alert("처리중입니다.");
		return false;
		}
		
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
		} else if (DoJoinForm__checkedLoginId ==""){
			alert("아이디는 중복될 수 없습니다.");
			return false;
		 }
		DoJoinForm__submited = true;
		return true;
	}
</script>

<%@ include file="../../part/head.jspf"%>

<div class="con joinForm ">
	<div class="joinTitle">회원가입</div>
	<form class="flex flex-dir-col flex-jc-c flex-ai-c" name="joinForm" action="doJoin" method="POST"
		onsubmit="return joinFormCheck();">
		<div class="joinForm__loginId">
		<input class="loginIdInput" name="loginId" placeholder="아이디"> 
		<input class="loginIdCheckBox" onclick="DoJoinForm__checkLoginIdDup(this);" name="btnLoginIdDupCheck" type="checkbox">		
		</div>
		<div class="rs"></div>
		<input type="password" name="loginPw" placeholder="비밀번호">
		<input name="name" placeholder="이름">
		<input name="nickName" placeholder="닉네임">
		<input type="email" name="email"	placeholder="이메일">
		<input name="phoneNo" placeholder="전화번호">
		<div class="joinSubmit">
			<input id="joinSubmit" type="submit" value="가입">
		</div>
	</form>
</div>
<%@ include file="../../part/foot.jspf"%>