package com.sbs.example.jspCommunity.servlet;

import java.io.IOException;

import java.util.HashMap;

import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import mysqlutil.MysqlUtil;


public abstract class DisPatcherServlet extends HttpServlet {

	public void run(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Map<String, Object> doBeforeActionRs = doBeforeAction(request, response);

		if (doBeforeActionRs == null) {
			return;
		}

		String jspPath = doAction(request, response, (String) doBeforeActionRs.get("controllerName"),
				(String) doBeforeActionRs.get("actionMethodName"));

		if (jspPath == null) {
			response.getWriter().append("jsp 정보가 없습니다.");
			return;
		}

		doAfterAction(request, response, jspPath);
	}

	private Map<String, Object> doBeforeAction(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 입력된 데이터의 문자셋은 UTF-8 이다.
		request.setCharacterEncoding("UTF-8");
		// 출력될 문서는 html(UTF-8) 이다.
		response.setContentType("text/html; charset=UTF-8");

		String requestUri = request.getRequestURI();
		String[] requestUriBits = requestUri.split("/");

		if (requestUriBits.length < 5) {
			response.getWriter().append("올바른 요청이 아닙니다.");
			return null;
		}

		String controllerName = requestUriBits[3];
		String actionMethodName = requestUriBits[4];

		MysqlUtil.setDBInfo("localhost", "sbsst", "sbs123414", "jspCommunity");
		
		Map<String, Object> rs = new HashMap<>();
		
		rs.put("controllerName", controllerName);
		rs.put("actionMethodName", actionMethodName);
		
		return rs;
	}

	protected abstract String doAction(HttpServletRequest request, HttpServletResponse response, String controllerName, String actionMethodName) throws ServletException, IOException;
	

	private void doAfterAction(HttpServletRequest request, HttpServletResponse response, String jspPath) throws ServletException, IOException {
		MysqlUtil.closeConnection();

		RequestDispatcher rd = request.getRequestDispatcher("/jsp/" + jspPath + ".jsp");
		rd.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	run(request,response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
