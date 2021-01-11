<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sbs.example.jspCommunity.dto.*"%>
<%@ page import="mysqlutil.*"%>

<%
int memberId = (int) request.getAttribute("memberId");
int id = (int) request.getAttribute("id");
%>

<%
if (request.getParameter("title") != null && request.getParameter("body") != null) {
	SecSql sql = new SecSql();
	sql.append("UPDATE article SET");
	sql.append("updateDate = NOW(),");
	sql.append("title = ?,", request.getParameter("title"));
	sql.append("`body` = ?", request.getParameter("body"));
	sql.append("WHERE memberId = ?", request.getParameter("memberId"));
	sql.append("AND id = ?", request.getParameter("id"));
	MysqlUtil.update(sql);

}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>게시물 수정</title>
</head>
<body>
	<h1>게시물 수정</h1>

	<form style="display:inline-block" method="post">
		<input type="hidden" name="memberId" value="<%=memberId%>">		
		 <input
			type="hidden" name="id" value="<%=id%>"> 			
			<input type="text"
			name="title" placeholder="제목을 입력해주세요.">
			<hr>
		<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
		<input type="submit" value="수정">
	</form>

</body>
</html>