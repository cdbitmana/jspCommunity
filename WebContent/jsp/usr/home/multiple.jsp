<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int table = (int) request.getAttribute("dan");
	int limit = (int) request.getAttribute("limit");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>구구단 <%=table%></title>
</head>
<body>
	<h1>
		구구단 <%=table%>단
	</h1>

	<%
		for (int i = 1; i <= limit; i++) {
	%>
	<div><%=table%>
		*
		<%=i%>
		=
		<%=table * i%></div>
	<%
		}
	%>
</body>
</html>