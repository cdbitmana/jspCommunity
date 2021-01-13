
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="mysqlutil.*"%>
<%@ page import="com.sbs.example.jspCommunity.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="articleBoardName" value="${articles[0].extra__boardName }"/>
<c:set var="articleBoardId" value="${articles[0].boardId }"/>
<c:set var="articleId" value="${articles[0].id }"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>
${articleBoardName } 게시판 리스트</title>
</head>
<body>
	<h1>
		${articleBoardName } 게시판 리스트
	</h1>
	<div>
		<form action="write" method="POST">
			<input type="hidden" name="boardId"
				value="${articleBoardId }"> <input
				type="hidden" name="memberId" value="1"> <input
				type="submit" value="글 작성">
		</form>
	</div>
	<hr>
	<c:forEach var="article" items="${articles }">
	<div>
	<div>번호 : ${article.id }</div>
	<div>작성자 : ${article.extra__writer }</div>
	<div>작성일 : ${article.regDate }</div>
	<div>제목 : <a href="/jspCommunity/usr/article/detail?id=${article.id }">${article.title }</a></div>	
	<form action="modify" style="display: inline-block" method="POST">
			<input type="hidden" name="memberId"
				value="${article.memberId }"> <input type="hidden"
				name="id" value="${article.id }"> <input type="submit"
				value="수정">
		</form>
		<form action="doDelete" style="display: inline-block" method="POST">
			<input type="hidden" name="id" value="${article.id }">
			<input type="submit" value="삭제">
		</form>		
		</div>
	<hr>
	</c:forEach>

	
</body>
</html>