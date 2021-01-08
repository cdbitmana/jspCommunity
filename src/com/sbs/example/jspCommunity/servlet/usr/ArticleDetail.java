package com.sbs.example.jspCommunity.servlet.usr;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.service.ArticleService;

import mysqlutil.MysqlUtil;
import mysqlutil.SecSql;

@WebServlet("/usr/jspCommunity/usr/article/detail")

public class ArticleDetail extends HttpServlet {
	
private ArticleService articleService;
	
	public ArticleDetail() {
		articleService = Container.articleService;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 입력된 데이터의 문자셋은 UTF-8 이다.
		request.setCharacterEncoding("UTF-8");
		// 출력될 문서는 html(UTF-8) 이다.
		response.setContentType("text/html; charset=UTF-8");

		MysqlUtil.setDBInfo("localhost", "sbsst", "sbs123414", "jspCommunity");
		
		int articleId = 1;
		
		if(request.getParameter("id") != null) {
			 articleId = Integer.parseInt(request.getParameter("id"));
		}
		
		Article article = articleService.getArticleById(articleId);		
		
		MysqlUtil.closeConnection();

		request.setAttribute("article", article);
		
		RequestDispatcher re = request.getRequestDispatcher("/jsp/usr/article/articleDetail.jsp");
		re.forward(request, response);
	
	}
}
