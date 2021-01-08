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

		request.setAttribute("articles", articles);

		return "usr/article/articleList";

	}

	public void doWrite(HttpServletRequest request, HttpServletResponse response) {

		String title = request.getParameter("title");
		String body = request.getParameter("body");
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int boardId = Integer.parseInt(request.getParameter("boardId"));

		articleService.doWrite(title, body, memberId, boardId);
	}

	public void doModify(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String body = request.getParameter("body");
	

		articleService.doModify(id, title, body);
	}

	public void doDelete(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		
		articleService.doDelete(id);
		
	}

	public String showDetail(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		Article article = articleService.getArticleById(id);
		
		request.setAttribute("article", article);
		
		return "usr/article/articleDetail";
		
	}

}
