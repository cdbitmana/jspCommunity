<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.List"%>
<%@ page import="com.sbs.example.jspCommunity.dto.*"%>
<%@ page import="mysqlutil.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<c:set var="pageTitle" value="게시판 수정 페이지"/>
<%@ include file="../../part/head.jspf"%>
	<h1>게시물 작성</h1>
	<form action="doWrite" style="display: inline-block" method="post">
		<input type="hidden" name="memberId" value="${memberId }">
		 <input	type="hidden" name="boardId" value="${boardId }">
			<input type="text" name="title" placeholder="제목을 입력해주세요.">
		<hr>
		<textarea name="body" placeholder="내용을 입력해주세요."></textarea>
		<input type="submit" value="작성">
	</form>
<%@ include file="../../part/foot.jspf"%>