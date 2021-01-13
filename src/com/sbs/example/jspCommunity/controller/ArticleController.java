package com.sbs.example.jspCommunity.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.service.ArticleService;

public class ArticleController {

	private ArticleService articleService;

	public ArticleController() {
		articleService = Container.articleService;
	}

	public String showList(HttpServletRequest request, HttpServletResponse response) {
		
		int boardId = Integer.parseInt(request.getParameter("boardId"));

		List<Article> articles = articleService.getArticlesForPrintByBoardId(boardId);
		if(articles == null) {
			request.setAttribute("alertMsg", "게시물이 없습니다.");
			request.setAttribute("historyBack", "true");
			return "common/redirect";
		}
		request.setAttribute("articles", articles);
	
		return "usr/article/articleList";

	}

	public String doWrite(HttpServletRequest request, HttpServletResponse response) {

		String title = request.getParameter("title");
		String body = request.getParameter("body");
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int boardId = Integer.parseInt(request.getParameter("boardId"));

		int newArticleId = articleService.doWrite(title, body, memberId, boardId);
		
		request.setAttribute("alertMsg", newArticleId+ "번 게시물이 생성되었습니다.");
		request.setAttribute("replaceUrl", String.format("detail?id=%d", newArticleId));
		return "common/redirect";
	}

	public String doModify(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String body = request.getParameter("body");

		articleService.doModify(id, title, body);
		
		request.setAttribute("alertMsg", id+"번 게시물이 수정되었습니다.");
		request.setAttribute("replaceUrl", String.format("detail?id=%d", id));
		
		return "common/redirect";
	}

	public String doDelete(HttpServletRequest request, HttpServletResponse response) {
		
		int id = Integer.parseInt(request.getParameter("id"));
		Article article = articleService.getArticleById(id);
		articleService.doDelete(id);
		request.setAttribute("alertMsg", id+"번 게시물이 삭제되었습니다.");
		request.setAttribute("replaceUrl", String.format("list?boardId=%d", article.getBoardId()) );
		return "common/redirect";

	}

	public String showDetail(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		Article article = articleService.getArticleById(id);

		request.setAttribute("article", article);

		return "usr/article/articleDetail";

	}

	public String write(HttpServletRequest request, HttpServletResponse response) {
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int boardId = Integer.parseInt(request.getParameter("boardId"));
		
		request.setAttribute("memberId", memberId);
		request.setAttribute("boardId", boardId);
		return "usr/article/writeForm";

	}

	public String modify(HttpServletRequest request, HttpServletResponse response) {
		
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int id = Integer.parseInt(request.getParameter("id"));
		request.setAttribute("memberId", memberId);
		request.setAttribute("id", id);
		return "usr/article/modifyForm";
	}

}
