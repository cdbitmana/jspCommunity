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
import com.sbs.example.jspCommunity.service.ArticleService;

public class UsrArticleController {

	private ArticleService articleService;

	public UsrArticleController() {
		articleService = Container.articleService;
	}

	public String showList(HttpServletRequest request, HttpServletResponse response) {
		
		int boardId = Integer.parseInt(request.getParameter("boardId"));
		String keyword = request.getParameter("keyword");
		String searchType = request.getParameter("searchType");
		
		int page = 1;		
		
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		if(keyword != null && keyword.contains("%")) {
			keyword = keyword.replace("%" , "\\%");
		}
		if(keyword != null && keyword.contains("_")) {
			keyword = keyword.replace("_","\\_");
		}
		List<Article> Allarticles = articleService.getArticlesForList(boardId,searchType,keyword);
		
		Board board = articleService.getBoardById(boardId);
		
		int itemsInAPage = 10;
		int start = (page - 1) * itemsInAPage;
		int end = start + itemsInAPage -1;
		if(end >= Allarticles.size()) {
			end = Allarticles.size()-1;
		}
		
		List<Article> articles = new ArrayList<>();
		
		
		for(int i = start ; i <= end ; i++) {
			articles.add(Allarticles.get(i));			
		}
		
		
		int totalPages = Allarticles.size() / 10;
		
		if(Allarticles.size() % 10 != 0) {
			totalPages++;
		}
		
		List<Integer> pages = new ArrayList<>();
		
		int pageStart = page / itemsInAPage;
		if(page % itemsInAPage != 0) {
			pageStart = pageStart * itemsInAPage + 1;	
		}
		
		int pageEnd = pageStart + 9;
		if (pageEnd >= totalPages) {
			pageEnd = totalPages;
		}
		
		for(int i = pageStart ; i <= pageEnd ; i++) {
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
		
		int memberId = (int)request.getAttribute("isLoginedMemberId");
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
		
		Map<String, Object> modifyArgs = new HashMap<>();
		modifyArgs.put("id", id);
		modifyArgs.put("title", title);
		modifyArgs.put("body", body);

		articleService.doModify(modifyArgs);
		
		request.setAttribute("alertMsg", id+"번 게시물이 수정되었습니다.");
		request.setAttribute("replaceUrl", String.format("detail?id=%d", id));
		
		return "common/redirect";
	}

	public String doDelete(HttpServletRequest request, HttpServletResponse response) {
		
		int id = Integer.parseInt(request.getParameter("id"));
		int memberId = 0;
		
		memberId= (int)request.getAttribute("isLoginedMemberId");
		
		Article article = articleService.getArticleById(id);
		if(article == null) {
			request.setAttribute("alertMsg", "해당 게시물은 존재하지 않습니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}
		if(article.getMemberId() != memberId) {
			request.setAttribute("alertMsg", "접근 권한이 없습니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}
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
		
		
		int memberId = 0;
	
		memberId= (int)request.getAttribute("isLoginedMemberId");
		
		
		int boardId = Integer.parseInt(request.getParameter("boardId"));
		Board board = articleService.getBoardById(boardId);
		
		request.setAttribute("memberId", memberId);
		request.setAttribute("boardId", boardId);
		request.setAttribute("board", board);
		return "usr/article/writeForm";

	}

	public String modify(HttpServletRequest request, HttpServletResponse response) {
		
		int memberId = 0;
	
		memberId= (int)request.getAttribute("isLoginedMemberId");
		int id = Integer.parseInt(request.getParameter("id"));
		String title = request.getParameter("title");
		String body = request.getParameter("body");
		Article article = articleService.getArticleById(id);
		if(article == null) {
			request.setAttribute("alertMsg", "해당 게시물은 존재하지 않습니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}
		if(article.getMemberId() != memberId) {
			request.setAttribute("alertMsg", "접근 권한이 없습니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}
		request.setAttribute("memberId", memberId);
		request.setAttribute("id", id);
		request.setAttribute("title", title);
		request.setAttribute("body", body);
		return "usr/article/modifyForm";
		
	}

}
