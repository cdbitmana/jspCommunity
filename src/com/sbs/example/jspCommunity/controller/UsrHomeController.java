package com.sbs.example.jspCommunity.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dto.Board;
import com.sbs.example.jspCommunity.service.ArticleService;

public class UsrHomeController extends Controller {

	private ArticleService articleService;

	public UsrHomeController() {
		articleService = Container.articleService;
	}

	public String showMain(HttpServletRequest request, HttpServletResponse response) {
		
		List<Board> boards = articleService.getBoards();
		
		List<Article> articles = new ArrayList<>();
		
		for(int i = 0 ; i < boards.size() ; i++) {
			 articles = articleService.getArticlesForPrintByBoardId(boards.get(i).getId());
			 request.setAttribute("articles_" + boards.get(i).getCode(), articles);
		}
		
		request.setAttribute("boards", boards);
		
		return "usr/home/main";
		
	}

	

}
