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
public class AdminDispatcherServlet extends DisPatcherServlet {

	@Override
	protected String doAction(HttpServletRequest request, HttpServletResponse response, String controllerName, String actionMethodName) {

		String jspPath = null;

		if (controllerName.equals("member")) {
			AdmMemberController memberController = Container.admMemberController;

			if (actionMethodName.equals("list")) {
				jspPath = memberController.showList(request, response);
			}
				

		}
		
		return jspPath;
		
		
	}

	

}
