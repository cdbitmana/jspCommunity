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
	<form action="/jspCommunity/usr/article/modify" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="<%=article.getMemberId()%>">
	<input type="hidden" name="id" value="<%=article.getId()%>">
	<input type="submit" value="수정">
	</form>
	
	<form action="/jspCommunity/usr/article/doDelete" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="<%=article.getMemberId()%>">
	<input type="hidden" name="id" value="<%=article.getId()%>">
	<input type="submit" value="삭제">
	</form>
	
	

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
	
	<div>
	<a href="/jspCommunity/usr/article/list?boardId=<%=article.getBoardId()%>">목록으로</a>
	</div>

</body>
</html>