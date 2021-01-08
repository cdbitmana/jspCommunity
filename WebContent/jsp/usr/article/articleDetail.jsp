<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sbs.example.jspCommunity.dto.*"%>
<%
	Article article = (Article) request.getAttribute("article");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title><%=article.getTitle()%></title>
</head>
<body>
	<h1>
		<%=article.getTitle()%>
	</h1>

	<div>
		번호 :
		<%=article.getId()%>
		</br> 작성자 :
		<%=article.getExtra__writer()%>
		</br> 작성일 :
		<%=article.getRegDate()%>
		</br> 제목 :
		<%=article.getTitle()%>
		</br> 내용 :
		<%=article.getBody()%>
		
	</div>

</body>
</html>