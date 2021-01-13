<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sbs.example.jspCommunity.dto.*"%>
<%@ page import="mysqlutil.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>
	<h1>게시물 수정</h1>

	<form action="doModify" style="display:inline-block" method="post">
		<input type="hidden" name="memberId" value="${memberId }">		
		 <input
			type="hidden" name="id" value="${id }"> 			
			<input type="text"
			name="title" placeholder="제목을 입력해주세요.">
			<hr>
		<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
		<input type="submit" value="수정">
	</form>

</body>
</html>