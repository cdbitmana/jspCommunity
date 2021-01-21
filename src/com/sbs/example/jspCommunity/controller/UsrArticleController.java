package com.sbs.example.jspCommunity.controller;

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

		List<Article> articles = articleService.getArticlesForPrintByBoardId(boardId);
		Board board = articleService.getBoardById(boardId);
		/*
		if(articles == null) {
			request.setAttribute("alertMsg", "게시물이 없습니다.");
			request.setAttribute("historyBack", "true");
			return "common/redirect";
		}
		*/
		
		request.setAttribute("articles", articles);
		request.setAttribute("board", board);
		return "usr/article/articleList";

	}

	public String doWrite(HttpServletRequest request, HttpServletResponse response) {

		
		String title = request.getParameter("title");
		String body = request.getParameter("body");
		HttpSession session = request.getSession();
		int memberId = (int)session.getAttribute("loginedMemberId");
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
		HttpSession session = request.getSession();
		int memberId = 0;
		if(session.getAttribute("loginedMemberId") == null) {
			request.setAttribute("alertMsg", "로그인 후 이용해주세요.");
			request.setAttribute("replaceUrl", "/jspCommunity/usr/member/login");
			return "common/redirect";
		}
		memberId= (int)session.getAttribute("loginedMemberId");
		
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
		
		HttpSession session = request.getSession();
		int memberId = 0;
		if(session.getAttribute("loginedMemberId") == null) {
			request.setAttribute("alertMsg", "로그인 후 이용해주세요.");
			request.setAttribute("replaceUrl", "/jspCommunity/usr/member/login");
			return "common/redirect";
		}
		memberId= (int)session.getAttribute("loginedMemberId");
		
		
		int boardId = Integer.parseInt(request.getParameter("boardId"));
		Board board = articleService.getBoardById(boardId);
		
		request.setAttribute("memberId", memberId);
		request.setAttribute("boardId", boardId);
		request.setAttribute("board", board);
		return "usr/article/writeForm";

	}

	public String modify(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		int memberId = 0;
		if(session.getAttribute("loginedMemberId") == null) {
			request.setAttribute("alertMsg", "로그인 후 이용해주세요.");
			request.setAttribute("replaceUrl", "/jspCommunity/usr/member/login");
			return "common/redirect";
		}
		memberId= (int)session.getAttribute("loginedMemberId");
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
