<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
   <c:set var="pageTitle" value="회원 목록"/>
<%@ include file="../../part/head.jspf"%>
<h1>
	회원 목록
	</h1>
	
	<c:forEach var="member" items="${members }">
	<div>
	번호 : ${member.id }
	</div>
	<div>
	가입일 : ${member.regDate }
	</div>
	<div>
	수정일 : ${member.updateDate }
	</div>
	<div>
	아이디 : ${member.loginId }
	</div>
	<div>
	이름 : ${member.name }
	</div>
	<div>
	닉네임 : ${member.nickName }
	</div>
	<div>
	등급 : ${member.authLevel }
	</div>
	<hr>
	</c:forEach>
<%@ include file="../../part/foot.jspf"%>