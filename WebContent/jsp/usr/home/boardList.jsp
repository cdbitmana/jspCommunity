<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>

<% String boardName = (String)request.getAttribute("boardName");
List<Map<String, Object>> articleMapList = (List<Map<String, Object>>) request.getAttribute("articleMapList");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%=boardName%></title>
</head>
<body>
	<h1>
		<%=boardName%>
	</h1>

	<%
		for (Map<String,Object> articleMap : articleMapList) {
	%>
	<div>
	번호 : <%=articleMap.get("id") %>
	</br>
	제목 : <%=articleMap.get("title") %>
	</div>
	<%
		}
	%>
</body>
</html>