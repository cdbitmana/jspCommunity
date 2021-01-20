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

public class UsrHomeController {

	private ArticleService articleService;

	public UsrHomeController() {
		articleService = Container.articleService;
	}

	public String showMain(HttpServletRequest request, HttpServletResponse response) {
		
		List<Board> boards = articleService.getBoards();
		
		List<Article> articles = articleService.getArticlesForPrint();
		
		request.setAttribute("articles", articles);
		request.setAttribute("boards", boards);
		
		return "usr/home/main";
		
	}

	

}
