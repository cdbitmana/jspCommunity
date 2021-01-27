<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
      
   <c:set var="pageTitle" value="회원 정보"/>
<%@ include file="../../part/head.jspf"%>
<div class="con">
<div class="flex flex-dir-col flex-ai-c flex-jc-c memberInfoBox">
<form class="flex flex-dir-col flex-ai-c flex-jc-s-ar" action="doMemberModify" method="post">
<input type="hidden" name="id" value="${member.id }">
<div class="form_group id">
<div class="form_group_type">아이디</div><div class="form_group_value">${member.loginId }</div>
</div>
<div class="form_group name">
<div class="form_group_type">이름</div><div class="form_group_value">${member.name }</div>
</div>
<div class="form_group nickName">
<div class="form_group_type">닉네임 </div><div class="form_group_value"><input type="text" name="nickName" value=""></div>
</div>
<div class="form_group email">
<div class="form_group_type">이메일 </div><div class="form_group_value"><input type="email" name="email" value=""></div>
</div>
<div class="form_group phoneNo">
<div class="form_group_type">전화번호 </div><div class="form_group_value"><input type="tel" name="phoneNo" value=""></div>
</div>
<div class="submitButtonBox">
<button class="flex flex-ai-c flex-jc-c submitButton" type="submit">회원정보 수정</button>
</div>
</form>

</div>
</div>

<%@ include file="../../part/foot.jspf"%>