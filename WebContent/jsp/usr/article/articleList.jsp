
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="articleBoardName" value="${articles[0].extra__boardName }"/>
<c:set var="articleId" value="${articles[0].id }"/>
<c:set var="pageTitle" value="게시판 리스트 페이지"/>

<%@ include file="../../part/head.jspf"%>
	
<div class="boardList con">
<div class="boardNameTitle">
<a href="/jspCommunity/usr/article/list?boardId=${articles[0].boardId }">${articleBoardName } 게시판</a>
</div>
	<div>
		<form class="write" action="write" method="POST">
			<input type="hidden" name="boardId"
				value="${param.boardId }"> <input
				type="hidden" name="memberId" value="1"> <input
				type="submit" value="글쓰기">
		</form>
	</div>
  <div class="articleList">
    <div class="article articleTag flex flex-ai-c">
      <span class="cell-id">번호</span>
      <span class="cell-title">제목</span>
      <span class="cell-writer">이름</span>
      <span class="cell-regDate">날짜</span>
      <span class="cell-hit">조회수</span>
    </div>
    
	<c:forEach var="article" items="${articles }">    
	<div class="article flex flex-ai-c">
	<span class="cell-id">${article.id }</span>
	<a class="flex cell-title title" href="/jspCommunity/usr/article/detail?id=${article.id }"><span >${article.title }</span></a>	
    <span class="cell-writer">${article.extra__writer }</span>
    <span class="cell-regDate">${article.regDate }</span>
    <span class="cell-hit">${article.hitCount}</span>	
    </div>  
    </c:forEach>	
		
  </div>
  </div>
  
 

<%@ include file="../../part/foot.jspf"%>