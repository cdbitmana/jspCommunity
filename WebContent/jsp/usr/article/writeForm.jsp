<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sbs.example.jspCommunity.dto.*"%>
<%@ page import="mysqlutil.*"%>
<%
int memberId = (int) request.getAttribute("memberId");
int boardId = (int) request.getAttribute("boardId");

if (request.getParameter("title") != null && request.getParameter("body") != null) {
	SecSql sql = new SecSql();
	sql.append("INSERT INTO article SET");
	sql.append("regDate = NOW(), updateDate = NOW(),");
	sql.append("title = ?,", request.getParameter("title"));
	sql.append("`body` = ?,", request.getParameter("body"));
	sql.append("memberId = ?,", Integer.parseInt(request.getParameter("memberId")));
	sql.append("boardId = ?,", Integer.parseInt(request.getParameter("boardId")));
	sql.append("hitCount = 0");
	int id = MysqlUtil.insert(sql);	
	request.setAttribute("replaceUrl","/jsp/usr/article/detail="+id);
	RequestDispatcher re = request.getRequestDispatcher("/jsp/common/redirect.jsp");
	re.forward(request, response);
}
%>

<!DOCTYPE html>

<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시물 작성</title>
</head>
<body>
	<h1>게시물 작성</h1>
	<form style="display: inline-block" method="post">
		<input type="hidden" name="memberId" value="<%=memberId%>"> <input
			type="hidden" name="boardId" value="<%=boardId%>"> <input
			type="text" name="title" placeholder="제목을 입력해주세요.">
		<hr>
		<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
		<input type="submit" value="작성">
	</form>
</body>
</html>