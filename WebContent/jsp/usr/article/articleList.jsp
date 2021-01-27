<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="게시판 리스트 페이지" />

<%@ include file="../../part/head.jspf"%>
<script>
let searchMenuOpened = false;

function showSearchMenu(){	
	if(searchMenuOpened == true){
		$('.selectmenu').css('display','none');
		searchMenuOpened = false;
		}
	else {
		$('.selectmenu').css('display','block');
		searchMenuOpened = true;
		}	
}

function searchContent(e){
	const selectedIndex = ($('.selectmenu > li').index(e));
	$('#searchselect option:eq('+selectedIndex+')').prop("selected",true);	
	$('.selectmenu').css('display','none');
	const selectedText = $(e).text();	
	$('.searchcontent').text(selectedText);
	searchMenuOpened = false;	
}

$('body').on('click',function(e){	
	if(!$(e.target).hasClass('searchcontent') && !$(e.target).hasClass('arrow') && !$(e.target).hasClass('selectmenu') && !$(e.target).hasClass('fas')){
	$('.selectmenu').css('display','none');
	searchMenuOpened = false;
		}
})
</script>
<div class="boardList con">
	<div class="boardNameTitle">
		<a href="/jspCommunity/usr/article/list?boardId=${board.id }&page=1">${board.name }
			게시판</a>
	</div>
	
	<div class="list-top flex flex-ai-c flex-jc-e">
	
<form class="flex flex-ai-c searchForm">
		<div class="searchbox">

			<div class="searcharea flex flex-ai-c" onclick="showSearchMenu();">
				<span class="searchcontent">제목</span><span class="arrow"><i class="fas fa-caret-down"></i></span>
			</div>

			<ul class="selectmenu">
				<li onclick="searchContent(this);">제목</li>
				<li onclick="searchContent(this);">내용</li>
				<li onclick="searchContent(this);">제목+내용</li>
				<li onclick="searchContent(this);">글쓴이</li>
			</ul>

			<select name="searchType" id="searchselect">
				<option value="title">제목</option>
				<option value="body">내용</option>
				<option value="titleandbody">제목+내용</option>
				<option value="writer">글쓴이</option>
			</select>
		</div>

		
			<input type="hidden" name="boardId" value="${board.id }"> <input
				class="searchInput" type="text" name="keyword">
		</form>
		<form class="write" action="write" method="POST">
			<input type="hidden" name="boardId" value="${board.id}"> <input
				type="hidden" name="memberId" value="1"> <input
				type="submit" value="글쓰기">
		</form>
	</div>
	<div class="articleList">
		<div class="article articleTag flex flex-ai-c">
			<span class="cell-id">번호</span> <span class="cell-title">제목</span> <span
				class="cell-writer">이름</span> <span class="cell-regDate">작성시간</span>
			<span class="cell-hit">조회수</span>
		</div>

		<c:forEach var="article" items="${articles }">
			<div class="article flex flex-ai-c">
				<span class="cell-id">${article.id }</span> <a
					class="flex cell-title title"
					href="/jspCommunity/usr/article/detail?id=${article.id }&page=${param.page}"><span>${article.title }</span></a>
				<span class="cell-writer">${article.extra__writer }</span> <span
					class="cell-regDate">${article.regDate }</span> <span
					class="cell-hit">${article.hitCount}</span>
			</div>
		</c:forEach>

	</div>
	<div class="flex flex-ai-c articleListPage">
	<div class="articleListPage__prev">
	<c:if test="${totalPages > 10 }">
	<a href="list?boardId=${board.id }&page=1
	<c:if test="${param.keyword != null }">&keyword=${param.keyword }</c:if>
	<c:if test="${param.searchType != null }">&searchType=${param.searchType }</c:if>
	"><i class="fas fa-angle-double-left"></i></a>
	</c:if>	
<c:if test="${page > 10 }">
<a href="list?boardId=${board.id }&page=<fmt:formatNumber value="${Math.floor((page-10)/10)*10+1}" pattern="#"/>
	<c:if test="${param.keyword != null }">&keyword=${param.keyword }</c:if>
	<c:if test="${param.searchType != null }">&searchType=${param.searchType }</c:if>
">이전</a>
</c:if>
</div>
	<div class="flex flex-jc-c flex-ai-c flex-grow-1 pages">
	<c:forEach var="page" items="${pages }">
	<c:choose>
	<c:when test="${page == param.page }">
	<span class="currentPage">${page }</span>
	</c:when>
	<c:when test="${page != param.page }">
	<a href="list?boardId=${board.id }&page=${page }
	<c:if test="${param.keyword != null }">&keyword=${param.keyword}</c:if>
	<c:if test="${param.searchType != null }">&searchType=${param.searchType }</c:if>
	">${page }
	</a>
	</c:when>
	</c:choose>	
	</c:forEach>
	</div>
	
	<div class="articleListPage__next">
	<c:if test="${totalPages > 10 && page < Math.floor(totalPages / 10)*10+1}">
<a href="list?boardId=${board.id }&page=<fmt:formatNumber value="${Math.floor((page+9)/10)*10+1}" pattern="#"/>
	<c:if test="${param.keyword != null }">&keyword=${param.keyword }</c:if>
	<c:if test="${param.searchType != null }">&searchType=${param.searchType }</c:if>
">다음</a>
</c:if>
<c:if test="${totalPages > 10 }">
	<a href="list?boardId=${board.id }&page=${totalPages}
	<c:if test="${param.keyword != null }">&keyword=${param.keyword }</c:if>
	<c:if test="${param.searchType != null }">&searchType=${param.searchType }</c:if>
	"><i class="fas fa-angle-double-right"></i></a>
	</c:if>
	</div>
	</div>
</div>



<%@ include file="../../part/foot.jspf"%>