package com.sbs.example.jspCommunity.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dto.Board;
import com.sbs.example.jspCommunity.dto.Reply;
import com.sbs.example.jspCommunity.dto.ResultData;
import com.sbs.example.jspCommunity.service.ArticleService;
import com.sbs.example.jspCommunity.service.ReplyService;
import com.sbs.example.jspCommunity.util.Util;

public class UsrArticleController extends Controller {

	private ArticleService articleService;
	private ReplyService replyService;

	public UsrArticleController() {
		articleService = Container.articleService;
		replyService = Container.replyService;
	}

	public String showList(HttpServletRequest request, HttpServletResponse response) {

		int boardId = Integer.parseInt(request.getParameter("boardId"));
		String keyword = request.getParameter("keyword");
		String searchType = request.getParameter("searchType");

		int page = Util.getAsInt(request.getParameter("page"), 1);

		if (keyword != null && keyword.contains("%")) {
			keyword = keyword.replace("%", "\\%");
		}
		if (keyword != null && keyword.contains("_")) {
			keyword = keyword.replace("_", "\\_");
		}
		List<Article> Allarticles = articleService.getArticlesForList(boardId, searchType, keyword);

		Board board = articleService.getBoardById(boardId);

		int itemsInAPage = 10;

		int limitStart = (page - 1) * itemsInAPage;
		List<Article> articles = articleService.getArticlesForPrintListByBoardId(boardId, limitStart, itemsInAPage,
				searchType, keyword);

		int totalPages = Allarticles.size() / 10;

		if (Allarticles.size() % 10 != 0) {
			totalPages++;
		}

		List<Integer> pages = new ArrayList<>();

		int pageStart = page / itemsInAPage;
		pageStart = pageStart * itemsInAPage + 1;
		if (page % itemsInAPage == 0) {
			pageStart = pageStart - itemsInAPage;
		}

		int pageEnd = pageStart + 9;
		if (pageEnd >= totalPages) {
			pageEnd = totalPages;
		}

		for (int i = pageStart; i <= pageEnd; i++) {
			pages.add(i);
		}

		request.setAttribute("totalPages", totalPages);
		request.setAttribute("pages", pages);
		request.setAttribute("articles", articles);
		request.setAttribute("board", board);
		request.setAttribute("page", page);
		return "usr/article/articleList";

	}

	public String doWrite(HttpServletRequest request, HttpServletResponse response) {

		String title = request.getParameter("title");
		String body = request.getParameter("body");

		int memberId = (int) request.getAttribute("loginedMemberId");
		int boardId = Integer.parseInt(request.getParameter("boardId"));

		int newArticleId = articleService.doWrite(title, body, memberId, boardId);

		request.setAttribute("alertMsg", newArticleId + "번 게시물이 생성되었습니다.");
		request.setAttribute("replaceUrl", String.format("detail?id=%d&page=1", newArticleId));
		return "common/redirect";
	}

	public String doModify(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String body = request.getParameter("body");
		int page = Integer.parseInt(request.getParameter("page"));
		Map<String, Object> modifyArgs = new HashMap<>();
		modifyArgs.put("id", id);
		modifyArgs.put("title", title);
		modifyArgs.put("body", body);

		articleService.doModify(modifyArgs);
		request.setAttribute("page", page);
		request.setAttribute("alertMsg", id + "번 게시물이 수정되었습니다.");
		request.setAttribute("replaceUrl", "detail?id=" + id + "&page=" + page);

		return "common/redirect";
	}

	public String doDelete(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		int memberId = 0;

		memberId = (int) request.getAttribute("loginedMemberId");

		Article article = articleService.getArticleById(id);
		if (article == null) {
			return msgAndBack(request, "해당 게시물은 존재하지 않습니다.");
		}
		if (article.getMemberId() != memberId) {
			return msgAndBack(request, "접근 권한이 없습니다.");
		}
		articleService.doDelete(id);
		request.setAttribute("alertMsg", id + "번 게시물이 삭제되었습니다.");
		request.setAttribute("replaceUrl", String.format("list?boardId=%d", article.getBoardId()));
		return "common/redirect";

	}

	public String showDetail(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		Article article = articleService.getArticleById(id);

		request.setAttribute("article", article);

		articleService.doIncreaseArticleHitCount(article);

		article = articleService.getArticleById(id);

		int memberId = 0;

		HttpSession session = request.getSession();
		if (session.getAttribute("loginedMemberId") != null) {

			memberId = (int) session.getAttribute("loginedMemberId");
		}

		boolean isLikedArticle = articleService.isLikedArticle(id, memberId);
		boolean isDislikedArticle = articleService.isDislikedArticle(id, memberId);

		List<Reply> replys = replyService.getArticleReplysByArticleId(id);

		int totalReplyCount = 0;

		if (replys != null) {
			totalReplyCount = replys.size();
		}

		request.setAttribute("article", article);
		request.setAttribute("isLikedArticle", isLikedArticle);
		request.setAttribute("isDislikedArticle", isDislikedArticle);
		request.setAttribute("replys", replys);
		request.setAttribute("totalReplyCount", totalReplyCount);

		return "usr/article/articleDetail";

	}

	public String write(HttpServletRequest request, HttpServletResponse response) {

		int memberId = 0;

		memberId = (int) request.getAttribute("loginedMemberId");

		int boardId = Integer.parseInt(request.getParameter("boardId"));
		Board board = articleService.getBoardById(boardId);

		request.setAttribute("memberId", memberId);
		request.setAttribute("boardId", boardId);
		request.setAttribute("board", board);
		return "usr/article/writeForm";

	}

	public String modify(HttpServletRequest request, HttpServletResponse response) {

		int memberId = 0;

		memberId = (int) request.getAttribute("loginedMemberId");
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String body = request.getParameter("body");
		Article article = articleService.getArticleById(id);
		int page = Integer.parseInt(request.getParameter("page"));
		if (article == null) {
			return msgAndBack(request, "해당 게시물은 존재하지 않습니다.");
		}
		if (article.getMemberId() != memberId) {
			return msgAndBack(request, "접근 권한이 없습니다.");
		}
		request.setAttribute("page", page);
		request.setAttribute("memberId", memberId);
		request.setAttribute("id", id);
		request.setAttribute("title", title);
		request.setAttribute("body", body);
		return "usr/article/modifyForm";

	}

	public String doLike(HttpServletRequest request, HttpServletResponse response) {

		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int id = Integer.parseInt(request.getParameter("articleId"));

		boolean isLikedArticle = articleService.isLikedArticle(id, memberId);

		String resultCode = null;

		if (isLikedArticle) {
			articleService.removeLikeArticle(id, memberId);
			resultCode = "F-1";
		} else {
			articleService.doLikeArticle(id, memberId);
			resultCode = "S-1";
		}

		return json(request, new ResultData(resultCode, ""));

	}

	public String doDislike(HttpServletRequest request, HttpServletResponse response) {
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int id = Integer.parseInt(request.getParameter("articleId"));

		boolean isDislikedArticle = articleService.isDislikedArticle(id, memberId);

		String resultCode = null;

		if (isDislikedArticle) {
			articleService.removeDislikeArticle(id, memberId);
			resultCode = "F-1";
		} else {
			articleService.doDislikeArticle(id, memberId);
			resultCode = "S-1";
		}

		return json(request, new ResultData(resultCode, ""));
	}

	public String doWriteArticleReply(HttpServletRequest request, HttpServletResponse response) {

		String body = request.getParameter("body");
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		
		replyService.doWriteArticleReply(articleId, body, memberId);

		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", request.getParameter("afterWriteReplyUrl"));
		}

		return "common/redirect";
	}

	public String doModifyArticleReply(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		String body = request.getParameter("body");
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		replyService.doModifyArticleReply(id,articleId,body,memberId);
		
		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", request.getParameter("afterWriteReplyUrl"));
		}

		return "common/redirect";

	}

	public String doDeleteArticleReply(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		
		replyService.doDeleteArticleReply(id);
		
		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", request.getParameter("afterWriteReplyUrl"));
		}

		return "common/redirect";
	}

}
