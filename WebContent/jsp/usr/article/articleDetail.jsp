<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sbs.example.jspCommunity.dto.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="게시판 상세 페이지"/>
<%@ include file="../../part/head.jspf"%>

	<h1>
		${article.title }
	</h1>
	<form action="/jspCommunity/usr/article/modify" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="submit" value="수정">
	</form>
	
	<form action="/jspCommunity/usr/article/doDelete" style="display:inline-block" method="post">	
	<input type="hidden" name="memberId" value="${article.memberId }">
	<input type="hidden" name="id" value="${article.id }">
	<input type="submit" value="삭제">
	</form>

	<div>
		번호 :
		${article.id }
		</br> 작성자 :
		${article.extra__writer }
		</br> 작성일 :
		${article.regDate }
		</br> 제목 :
		${article.title }
		</br> 내용 :
		${article.body }		
	</div>
	
	<div>
	<a href="/jspCommunity/usr/article/list?boardId=${article.boardId }">목록으로</a>
	</div>
<%@ include file="../../part/foot.jspf"%>
