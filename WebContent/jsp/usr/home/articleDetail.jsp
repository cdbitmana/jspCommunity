<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%
	Map<String, Object> articleMap = (Map) request.getAttribute("articleMap");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%=articleMap.get("title")%></title>
</head>
<body>
	<h1>
		<%=articleMap.get("title")%>
	</h1>

	<div>
		번호 :
		<%=articleMap.get("id")%>
		</br> 제목 :
		<%=articleMap.get("title")%>
		</br> 내용 :
		<%=articleMap.get("body")%>
	</div>

</body>
</html>