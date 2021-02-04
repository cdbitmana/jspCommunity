<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="pageTitle" value="${board.name }" />

<%@ include file="../../part/head.jspf"%>
<script>
	let searchMenuOpened = false;

	function showSearchMenu() {
		if (searchMenuOpened == true) {
			$('.selectmenu').css('display', 'none');
			searchMenuOpened = false;
		} else {
			$('.selectmenu').css('display', 'block');
			searchMenuOpened = true;
		}
	}

	function searchContent(e) {
		const selectedIndex = ($('.selectmenu > li').index(e));
		$('#searchselect option:eq(' + selectedIndex + ')').prop("selected",
				true);
		$('.selectmenu').css('display', 'none');
		const selectedText = $(e).text();
		$('.searchcontent').text(selectedText);
		searchMenuOpened = false;
	}

	

	
	$(document).on('click','.articleList_writer',function(e){
		let menuTop = e.pageY;
		let menuLeft = e.clientX;
		const writer = e.target.innerText;
		
		$('.articleList__writerMenuBox > .articleList__writerMenuBox__search > a').attr('href','/jspCommunity/usr/article/list?boardId='+${param.boardId}+'&page=1&searchType=writer&keyword='+writer);
		$('.articleList__writerMenuBox').css({
				"display": "block",
				"top": menuTop,
				"left": menuLeft
		});
		});

	$('body').on(
			'click',
			function(e) {
				
				if (!$(e.target).hasClass('searchcontent')
						&& !$(e.target).hasClass('arrow')
						&& !$(e.target).hasClass('selectmenu')
						&& !$(e.target).hasClass('fas')) {
					$('.selectmenu').css('display', 'none');
					searchMenuOpened = false;
				}

				if(!$(e.target).hasClass('articleList_writer')){
					$('.articleList__writerMenuBox').css('display','none');
					}
			});

	
</script>
<main class="con-min-width">
<div class="boardList con">
	<div class="boardNameTitle">
		<a href="/jspCommunity/usr/article/list?boardId=${board.id }&page=1">${board.name }
			게시판</a>
	</div>

	<div class="list-top flex flex-ai-c flex-jc-e">

		<form class="flex flex-ai-c searchForm">
		<input type="hidden" name="page" value="1">
			<div class="searchbox">

				<div class="searcharea flex flex-ai-c" onclick="showSearchMenu();">
					<span class="searchcontent">제목</span><span class="arrow"><i
						class="fas fa-caret-down"></i></span>
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
		<form class="write" action="write" method="GET">
		<input type="hidden" name="listUrl" value="${encodedCurrentUrl} ">	
			<input type="hidden" name="boardId" value="${board.id}"> 
			<input type="hidden" name="memberId" value="1">		
			
			 <input type="submit" value="글쓰기">
		</form>
	</div>
	<!-- 게시물 리스트 PC버전 시작 -->
	<div class="articleList articleList-pc">
		<div class="article articleTag flex flex-ai-c">
			<span class="cell-id">번호</span> <span class="cell-title">제목</span> <span
				class="cell-writer">이름</span> <span class="cell-regDate">작성시간</span>
			<span class="cell-hit">조회수</span><span class="cell-likeCount">좋아요</span>
				 <span class="cell-dislikeCount">싫어요</span>
		</div>

		<c:forEach var="article" items="${articles }">
			<div class="article flex flex-ai-c">
				<span class="cell-id">${article.id }</span> <a
					class="flex cell-title title"
					href="/jspCommunity/usr/article/detail?id=${article.id }&listUrl=${encodedCurrentUrl}"><span>${article.title }</span></a>
				<span class="cell-writer articleList_writer">${article.extra__writer }</span>
				 <span class="cell-regDate">${article.regDate }</span> 
				 <span class="cell-hit">${article.hitCount}</span>
				 <span class="cell-likeCount">${article.likeCount }</span>
				 <span class="cell-dislikeCount">${article.dislikeCount }</span>
			</div>
		</c:forEach>

	</div>
	<!-- 게시물 리스트 PC버전 끝 -->
	
	<!-- 게시물 리스트 모바일 버전 시작 -->
	<div class="articleList-mb">
	
	<c:forEach var="article" items="${articles }">
			<div class="article-mb">
			<a href="/jspCommunity/usr/article/detail?id=${article.id }&listUrl=${encodedCurrentUrl}">
			<div class="flex article-mb-1">
			<span class="cell-id-mb">${article.id } ) </span>
			<span class="flex-grow-1 cell-title-mb">${article.title }</span>
			</div>
			<div class="flex flex-ai-c article-mb-2">
			<span class="cell-writer-mb">${article.extra__writer }</span>
			<span class="cell-hit-mb">조회수 ${article.hitCount }</span>			
			<span class="cell-likeCount-mb">좋아요 ${article.likeCount }</span>
			<span class="cell-dislikeCount-mb">싫어요 ${article.dislikeCount }</span>
			<span class="flex-grow-1 cell-regDate-mb">${article.regDate }</span>
			</div>
			</a>
			</div>
		</c:forEach>
		
	</div>
	<!-- 게시물 리스트 모바일 버전 끝 -->	
	
	<!--  페이지 버튼 PC버전 시작 -->
	<div class="flex flex-ai-c articleListPage">
		<div class="articleListPage__prev">
			<c:if test="${totalPages > 10 }">
				<a
					href="list?boardId=${board.id }&page=1
	<c:if test="${param.keyword != null }">&keyword=${param.keyword }</c:if>
	<c:if test="${param.searchType != null }">&searchType=${param.searchType }</c:if>
	"><i
					class="fas fa-angle-double-left"></i></a>
			</c:if>
			<c:if test="${page > 10 }">
				<a
					href="list?boardId=${board.id }&page=<fmt:formatNumber value="${Math.floor((page-10)/10)*10+1}" pattern="#"/>
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
						<a
							href="list?boardId=${board.id }&page=${page }
	<c:if test="${param.keyword != null }">&keyword=${param.keyword}</c:if>
	<c:if test="${param.searchType != null }">&searchType=${param.searchType }</c:if>
	">${page }
						</a>
					</c:when>
				</c:choose>
			</c:forEach>
		</div>




		<div class="articleListPage__next">
			<c:if
				test="${totalPages > 10 && page < Math.floor(totalPages / 10)*10+1}">
				<a
					href="list?boardId=${board.id }&page=<fmt:formatNumber value="${Math.floor((page+9)/10)*10+1}" pattern="#"/>
	<c:if test="${param.keyword != null }">&keyword=${param.keyword }</c:if>
	<c:if test="${param.searchType != null }">&searchType=${param.searchType }</c:if>
">다음</a>
			</c:if>
			<c:if test="${totalPages > 10 }">
				<a
					href="list?boardId=${board.id }&page=${totalPages}
	<c:if test="${param.keyword != null }">&keyword=${param.keyword }</c:if>
	<c:if test="${param.searchType != null }">&searchType=${param.searchType }</c:if>
	"><i
					class="fas fa-angle-double-right"></i></a>
			</c:if>
		</div>
	</div>
	<!--  페이지 버튼 PC버전 끝 -->

	
</div>


</main>
<div class="articleList__writerMenuBox">
	<div><a href="">쪽지 보내기</a></div>
		<div class="articleList__writerMenuBox__search"><a href="">작성글 검색</a>
		</div>
	</div>
<%@ include file="../../part/foot.jspf"%>