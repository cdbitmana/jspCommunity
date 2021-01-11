package com.sbs.example.jspCommunity.servlet;

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
import com.sbs.example.jspCommunity.controller.ArticleController;
import com.sbs.example.jspCommunity.controller.MemberController;
import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.service.ArticleService;

import mysqlutil.MysqlUtil;
import mysqlutil.SecSql;

@WebServlet("/usr/*")

public class DispatcherServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 입력된 데이터의 문자셋은 UTF-8 이다.
		request.setCharacterEncoding("UTF-8");
		// 출력될 문서는 html(UTF-8) 이다.
		response.setContentType("text/html; charset=UTF-8");

		String requestUri = request.getRequestURI();
		String[] requestUriBits = requestUri.split("/");

		if (requestUriBits.length < 5) {
			response.getWriter().append("올바른 요청이 아닙니다.");
			return;
		}

		String controllerName = requestUriBits[3];
		String actionMethodName = requestUriBits[4];

		MysqlUtil.setDBInfo("localhost", "sbsst", "sbs123414", "jspCommunity");

		String boardCode = request.getParameter("boardCode");

		if (boardCode == null) {
			boardCode = "notice";
		}

		String jspPath = null;

		if (controllerName.equals("member")) {
			MemberController memberController = Container.memberController;

			if (actionMethodName.equals("list")) {
				jspPath = memberController.showList(request, response);
			}

		} else if (controllerName.equals("article")) {
			ArticleController articleController = Container.articleController;

			if (actionMethodName.equals("list")) {
				jspPath = articleController.showList(request, response);
			} else if (actionMethodName.equals("write")) {
				jspPath = articleController.write(request, response);
			} else if (actionMethodName.equals("doWrite")) {
				articleController.doWrite(request, response);
				return;
			} else if (actionMethodName.equals("modify")) {
				jspPath = articleController.modify(request, response);
			} else if (actionMethodName.equals("doModify")) {
				articleController.doModify(request, response);
				return;
			} else if (actionMethodName.equals("doDelete")) {
				articleController.doDelete(request, response);
				return;
			} else if (actionMethodName.equals("detail")) {
				jspPath = articleController.showDetail(request, response);
			}
		}
		
		MysqlUtil.closeConnection();

		RequestDispatcher re = request.getRequestDispatcher("/jsp/" + jspPath + ".jsp");
		re.forward(request, response);

	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}
	
}
