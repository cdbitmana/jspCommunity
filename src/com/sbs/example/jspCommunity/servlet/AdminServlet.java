package com.sbs.example.jspCommunity.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.controller.*;

import mysqlutil.MysqlUtil;

@WebServlet("/adm/*")
public class AdminServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

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
		
		String jspPath = null;

		if (controllerName.equals("member")) {
			AdmMemberController memberController = Container.admMemberController;

			if (actionMethodName.equals("list")) {
				jspPath = memberController.showList(request, response);
			}
				

		}
		
		MysqlUtil.closeConnection();
		
		RequestDispatcher re = request.getRequestDispatcher("/jsp/" + jspPath + ".jsp");
		re.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
