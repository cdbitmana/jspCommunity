
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="메인" />

<%@ include file="../../part/head.jspf"%>

<div>${articles }</div>

<div class="con homeArticleList">
	<c:forEach var="board" items="${boards }">
		<span>${board.name}</span>			
		<c:forEach var="article" items="${articlesnotice}" begin="0" end="4">		
			<c:set var="boardId" value="${article.boardId }" /> 
			<c:if test="${board.id == boardId}">
				<a href="/jspCommunity/usr/article/detail?id=${article.id }">
					<div class="homeArticle">				
						<div class="flex homeArticleInfo">
							<span class="homeArticleTitle">${article.title }</span> <span
								class="homeArticleWriter">${article.extra__writer }</span> <span
								class="homeArticleRegDate">${article.regDate }</span>
						</div>
						<div class="homeArticleBody">${article.body }</div>
					</div>
				</a>
			</c:if>	
		</c:forEach>
	</c:forEach>
</div>

<%@ include file="../../part/foot.jspf"%>