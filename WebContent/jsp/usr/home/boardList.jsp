
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="mysqlutil.*"%>

<%
	String boardName = (String) request.getAttribute("boardName");
List<Map<String, Object>> articleMapList = (List<Map<String, Object>>) request.getAttribute("articleMapList");
%>
<%
	if (request.getParameter("btnSubmit") != null) {
	SecSql sql = new SecSql();
	sql.append("DELETE FROM article where id= ?", request.getParameter("btnSubmit"));
	MysqlUtil.delete(sql);

}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%=boardName%> 게시판 리스트</title>
</head>
<body>
	<h1>
		<%=boardName%>
		게시판 리스트
	</h1>

	<%
		for (Map<String, Object> articleMap : articleMapList) {
	%>
	<div>
		번호 :
		<%=articleMap.get("id")%>
		</br> 제목 : <a
			href="http://localhost:8080/jspCommunity/usr/jspCommunity/usr/article/detail?id=<%=articleMap.get("id")%>"><%=articleMap.get("title")%></a>
		<form enctype="multipart/form-data" method="get">
			<input type="submit" id="btnSubmit" name="btnSubmit"
				value="<%=articleMap.get("id")%>">
		</form>


	</div>
	<%
		}
	%>
</body>
</html>