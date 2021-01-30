<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
       <script src="https://cdnjs.cloudflare.com/ajax/libs/js-sha256/0.9.0/sha256.min.js" ></script>
   <c:set var="pageTitle" value="회원 정보 수정"/>
<%@ include file="../../part/head.jspf"%>
<script>
let DoMemberModifyForm__submited = false;

function doMemberModifyFormCheck(){

	if(DoMemberModifyForm__submited){
		alert("처리중입니다.");
		return false;
		}

	if(memberModifyForm.loginPw.value.length > 0){
		memberModifyForm.loginPwReal.value = sha256(memberModifyForm.loginPw.value);
		memberModifyForm.loginPw.value = "";
		}
		
		DoMemberModifyForm__submited = true;
		return true;
		
}
</script>
<main class="con-min-widht">
<div class="con">
<div class="flex flex-dir-col flex-ai-c flex-jc-c memberInfoBox">
<form class="flex flex-dir-col flex-ai-c flex-jc-s-ar" name="memberModifyForm" action="doMemberModify" method="post" onsubmit="doMemberModifyFormCheck();">
<input type="hidden" name="id" value="${member.id }">
<input type="hidden" name="loginPwReal" value="${member.loginPw }">
<div class="form_group id">
<div class="form_group_type">아이디</div><div class="form_group_value">${member.loginId }</div>
</div>
<div class="form_group name">
<div class="form_group_type">비밀번호</div><div class="form_group_value"><input type="password" name="loginPw" value=""></div>
</div>
<div class="form_group name">
<div class="form_group_type">이름</div><div class="form_group_value">${member.name }</div>
</div>
<div class="form_group nickName">
<div class="form_group_type">닉네임 </div><div class="form_group_value"><input type="text" name="nickName" value="${member.nickName }"></div>
</div>
<div class="form_group email">
<div class="form_group_type">이메일 </div><div class="form_group_value"><input type="email" name="email" value="${member.email }"></div>
</div>
<div class="form_group phoneNo">
<div class="form_group_type">전화번호 </div><div class="form_group_value"><input type="tel" name="phoneNo" value="${member.phoneNo }"></div>
</div>
<div class="submitButtonBox">
<button class="flex flex-ai-c flex-jc-c submitButton" type="submit">회원정보 수정</button>
</div>
</form>

</div>
</div>
</main>
<%@ include file="../../part/foot.jspf"%>