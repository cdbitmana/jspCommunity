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

@WebServlet("/usr/*")
public class UsrDispatcherServlet extends DisPatcherServlet {

	@Override
	protected String doAction(HttpServletRequest request, HttpServletResponse response, String controllerName,
			String actionMethodName) {

		String jspPath = null;
		if (controllerName.equals("home")) {
			jspPath = "usr/home/main";
		} else if (controllerName.equals("member")) {
			UsrMemberController memberController = Container.usrMemberController;

			if (actionMethodName.equals("join")) {
				jspPath = memberController.showJoin(request, response);
			} else if (actionMethodName.equals("doJoin")) {
				jspPath = memberController.doJoin(request, response);
			} else if (actionMethodName.equals("login")) {
				jspPath = memberController.login(request, response);
			} else if (actionMethodName.equals("doLogin")) {
				jspPath = memberController.doLogin(request, response);
			} else if (actionMethodName.equals("logout")) {
				jspPath = memberController.doLogout(request, response);
			}

		} else if (controllerName.equals("article")) {
			UsrArticleController articleController = Container.usrArticleController;

			if (actionMethodName.equals("list")) {
				jspPath = articleController.showList(request, response);
			} else if (actionMethodName.equals("write")) {
				jspPath = articleController.write(request, response);
			} else if (actionMethodName.equals("doWrite")) {
				jspPath = articleController.doWrite(request, response);
			} else if (actionMethodName.equals("detail")) {
				jspPath = articleController.showDetail(request, response);
			} else if (actionMethodName.equals("modify")) {
				jspPath = articleController.modify(request, response);
			} else if (actionMethodName.equals("doModify")) {
				jspPath = articleController.doModify(request, response);
			} else if (actionMethodName.equals("doDelete")) {
				jspPath = articleController.doDelete(request, response);
			}
		}

		return jspPath;

	}

}
