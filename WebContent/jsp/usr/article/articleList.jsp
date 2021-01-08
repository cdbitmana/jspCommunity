
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="mysqlutil.*"%>
<%@ page import="mysqlutil.*"%>
<%@ page import="com.sbs.example.jspCommunity.dto.*"%>

<%
	List<Article> articles = (List<Article>) request.getAttribute("articles");
%>

<%
	if (request.getParameter("btnSubmit") != null) {
	SecSql sql = new SecSql();
	sql.append("DELETE FROM article where id= ?", Integer.parseInt(request.getParameter("btnSubmit")));
	MysqlUtil.delete(sql);

}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%=articles.get(0).getExtra__boardName()%> 게시판 리스트</title>
</head>
<body>
	<h1>
		<%=articles.get(0).getExtra__boardName()%>게시판 리스트
	</h1>

	<%
		for (Article article : articles) {
	%>
	<div>
		번호 :
		<%=article.getId()%>		
		</br> 제목 : <a
			href="http://localhost:8080/jspCommunity/usr/article/detail?id=<%=article.getId()%>"><%=article.getTitle()%></a>
		<form enctype="multipart/form-data" method="get">
		<button>삭제</button>
		<input type="hidden" name="boardId" value="<%=article.getBoardId() %>">
			<input type="hidden" id="btnSubmit" name="btnSubmit"
				value="<%=article.getId()%>">
		</form>


	</div>
	<%
		}
	%>
</body>
</html>