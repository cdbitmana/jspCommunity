package com.sbs.example.jspCommunity.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.mysql.cj.jdbc.interceptors.SessionAssociationInterceptor;
import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Member;

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

	private Map<String, Object> doBeforeAction(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
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

		String controllerType = requestUriBits[2];
		String controllerName = requestUriBits[3];
		String actionMethodName = requestUriBits[4];
		
		String actionUrl = "/" + controllerType + "/" + controllerName + "/" + actionMethodName; 
		
		// 데이터 추가 인터셉터
		HttpSession session = request.getSession();
		
		boolean isLogined = false;
		int isLoginedMemberId = -1;
		Member isLoginedMember = null;
		
		if(session.getAttribute("isLogined") != null) {
				isLogined = true;
				isLoginedMemberId = (int)session.getAttribute("isLoginedMemberId");
				isLoginedMember = Container.memberService.getMemberById(isLoginedMemberId);
		}
		
		request.setAttribute("isLogined" , isLogined);
		request.setAttribute("isLoginedMemberId" , isLoginedMemberId);
		request.setAttribute("isLoginedMember" , isLoginedMember);
		
		// 로그인 필요 필터링 인터셉터
		
		List<String> needToLoginactionUrls = new ArrayList<>();
		
		needToLoginactionUrls.add("/usr/article/write");
		needToLoginactionUrls.add("/usr/article/modify");
		needToLoginactionUrls.add("/usr/article/doDelete");
		needToLoginactionUrls.add("/usr/member/logout");
		needToLoginactionUrls.add("/usr/article/doWrite");
		needToLoginactionUrls.add("/usr/article/doModify");
		
		if(needToLoginactionUrls.contains(actionUrl)) {
			if((boolean)request.getAttribute("isLogined") == false) {
				request.setAttribute("alertMsg", "로그인 후 이용해주세요.");
				request.setAttribute("replaceUrl", "../member/login");

				RequestDispatcher rd = request.getRequestDispatcher("/jsp/common/redirect.jsp");
				rd.forward(request, response);
			}
		}
		
		// 로그인 불필요 필터링 인터셉터
		
		List<String> needToLogoutactionUrls = new ArrayList<>();
		
		needToLogoutactionUrls.add("/usr/member/login");
		needToLogoutactionUrls.add("/usr/member/doLogin");
		needToLogoutactionUrls.add("/usr/member/join");
		needToLogoutactionUrls.add("/usr/member/doJoin");
		
		if(needToLogoutactionUrls.contains(actionUrl)) {
			if((boolean)request.getAttribute("isLogined") == true) {
				request.setAttribute("alertMsg", "로그아웃 후 이용해주세요.");
				request.setAttribute("historyBack", true);

				RequestDispatcher rd = request.getRequestDispatcher("/jsp/common/redirect.jsp");
				rd.forward(request, response);
			}
		}
		

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
