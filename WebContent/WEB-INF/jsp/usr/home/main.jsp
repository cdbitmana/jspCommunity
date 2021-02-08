
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="pageTitle" value="Indie World" />

<%@ include file="../../part/head.jspf"%>

<main class="con-min-width">
<div class="con home-articleList-container-1">

<div class="float-l article-list-box article-list-box-1">
<div class="article-list-box-1__board"><a href="${appUrl }/usr/article/list?boardId=3&page=1">새소식</a></div>
<div class="article-list-box-1__articles flex flex-dir-col">

<c:forEach var="article" items="${articlesnews }" begin="0" end="4">
<c:url var="url" value="/usr/article/detail">
<c:param name="id" value="${article.id }"></c:param>
<c:param name="listUrl" value="${appUrl }/usr/article/list?boardId=3&page=1"></c:param>
</c:url>
<a class="flex flex-ai-c article-list-box-1__article" href="${url }">
<span class="article-list-box__articles-title">${article.title }</span>
<span class="article-list-box__articles-writer">${article.extra__writer }</span>
</a>
</c:forEach>


</div>
</div>

<div class="float-l article-list-box article-list-box-1">
<div class="article-list-box-1__board"><a href="${appUrl }/usr/article/list?boardId=4&page=1">공략</a></div>
<div class="article-list-box-1__articles flex flex-dir-col">

<c:forEach var="article" items="${articlestip }" begin="0" end="4">
<c:url var="url" value="/usr/article/detail">
<c:param name="id" value="${article.id }"></c:param>
<c:param name="listUrl" value="${appUrl }/usr/article/list?boardId=4&page=1"></c:param>
</c:url>
<a class="flex flex-ai-c article-list-box-1__article" href="${url}">
<span class="article-list-box__articles-title">${article.title }</span>
<span class="article-list-box__articles-writer">${article.extra__writer }</span>
</a>
</c:forEach>


</div>
</div>

<div class="float-l article-list-box article-list-box-1">
<div class="article-list-box-1__board"><a href="${appUrl }/usr/article/list?boardId=5&page=1">자료실</a></div>
<div class="article-list-box-1__articles flex flex-dir-col">

<c:forEach var="article" items="${articlesdata }" begin="0" end="4">
<c:url var="url" value="/usr/article/detail">
<c:param name="id" value="${article.id }"></c:param>
<c:param name="listUrl" value="${appUrl }/usr/article/list?boardId=5&page=1"></c:param>
</c:url>
<a class="flex flex-ai-c article-list-box-1__article" href="${url }">
<span class="article-list-box__articles-title">${article.title }</span>
<span class="article-list-box__articles-writer">${article.extra__writer }</span>
</a>
</c:forEach>


</div>
</div>


<div class="float-l article-list-box article-list-box-1">
<div class="article-list-box-1__board"><a href="${appUrl }/usr/article/list?boardId=1&page=1">공지</a></div>
<div class="article-list-box-1__articles flex flex-dir-col">

<c:forEach var="article" items="${articlesnotice }" begin="0" end="4">
<c:url var="url" value="/usr/article/detail">
<c:param name="id" value="${article.id }"></c:param>
<c:param name="listUrl" value="${appUrl }/usr/article/list?boardId=1&page=1"></c:param>
</c:url>
<a class="flex flex-ai-c article-list-box-1__article" href="${url }">
<span class="article-list-box__articles-title">${article.title }</span>
<span class="article-list-box__articles-writer">${article.extra__writer }</span>
</a>
</c:forEach>


</div>
</div>


<div class="float-l article-list-box article-list-box-1">
<div class="article-list-box-1__board"><a href="${appUrl }/usr/article/list?boardId=2&page=1">자유</a></div>
<div class="article-list-box-1__articles flex flex-dir-col">

<c:forEach var="article" items="${articlesfree }" begin="0" end="4">
<c:url var="url" value="/usr/article/detail">
<c:param name="id" value="${article.id }"></c:param>
<c:param name="listUrl" value="${appUrl }/usr/article/list?boardId=2&page=1"></c:param>
</c:url>
<a class="flex flex-ai-c article-list-box-1__article" href="${url }">
<span class="article-list-box__articles-title">${article.title }</span>
<span class="article-list-box__articles-writer">${article.extra__writer }</span>
</a>
</c:forEach>


</div>
</div>


</div>

</main>

<%@ include file="../../part/foot.jspf"%>