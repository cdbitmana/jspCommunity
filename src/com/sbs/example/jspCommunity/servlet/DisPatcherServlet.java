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

import com.sbs.example.jspCommunity.App;
import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Member;
import com.sbs.example.jspCommunity.util.Util;

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

	private Map<String, Object> doBeforeAction(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		// 입력된 데이터의 문자셋은 UTF-8 이다.
		request.setCharacterEncoding("UTF-8");
		// 출력될 문서는 html(UTF-8) 이다.
		response.setContentType("text/html; charset=UTF-8");

		String requestUri = request.getRequestURI();
		String[] requestUriBits = requestUri.split("/");

		int minBitsCount = 5;

		if (App.isProductMode()) {
			minBitsCount = 4;
		}

		if (requestUriBits.length < minBitsCount) {
			response.getWriter().append("올바른 요청이 아닙니다.");
			return null;
		}

		int controllerTypeNameIndex = 2;
		int controllerNameIndex = 3;
		int actionMethodNameIndex = 4;

		if (App.isProductMode()) {
			controllerTypeNameIndex = 1;
			controllerNameIndex = 2;
			actionMethodNameIndex = 3;
		}

		String controllerType = requestUriBits[controllerTypeNameIndex];
		String controllerName = requestUriBits[controllerNameIndex];
		String actionMethodName = requestUriBits[actionMethodNameIndex];

		String actionUrl = "/" + controllerType + "/" + controllerName + "/" + actionMethodName;
		
		Map<String, Object> param = Util.getParamMap(request);
		String paramJson = Util.getJsonText(param);

		request.setAttribute("paramMap", param);
		request.setAttribute("paramJson", paramJson);

		// 데이터 추가 인터셉터
		HttpSession session = request.getSession();

		boolean isLogined = false;
		int loginedMemberId = -1;
		Member loginedMember = null;

		if (session.getAttribute("isLogined") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = Container.memberService.getMemberById(loginedMemberId);
		}

		request.setAttribute("isLogined", isLogined);
		request.setAttribute("loginedMemberId", loginedMemberId);
		request.setAttribute("loginedMember", loginedMember);

		String currentUrl = request.getRequestURI();

		if (request.getQueryString() != null) {
			currentUrl += "?" + request.getQueryString();
		}

		String encodedCurrentUrl = Util.getUrlEncoded(currentUrl);

		request.setAttribute("currentUrl", currentUrl);
		request.setAttribute("encodedCurrentUrl", encodedCurrentUrl);

		// 로그인 필요 필터링 인터셉터

		List<String> needToLoginactionUrls = new ArrayList<>();

		needToLoginactionUrls.add("/usr/article/write");
		needToLoginactionUrls.add("/usr/article/modify");
		needToLoginactionUrls.add("/usr/article/doDelete");
		needToLoginactionUrls.add("/usr/member/logout");
		needToLoginactionUrls.add("/usr/article/doWrite");
		needToLoginactionUrls.add("/usr/article/doModify");
		needToLoginactionUrls.add("/usr/member/memberInfo");
		needToLoginactionUrls.add("/usr/member/memberModifyForm");
		needToLoginactionUrls.add("/usr/member/doMemberModify");

		if (needToLoginactionUrls.contains(actionUrl)) {
			if ((boolean) request.getAttribute("isLogined") == false) {
				request.setAttribute("alertMsg", "로그인 후 이용해주세요.");
				request.setAttribute("replaceUrl", "../member/login?afterLoginUrl=" + encodedCurrentUrl);

				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp//common/redirect.jsp");
				rd.forward(request, response);
			}
		}

		// 로그인 불필요 필터링 인터셉터

		List<String> needToLogoutactionUrls = new ArrayList<>();

		needToLogoutactionUrls.add("/usr/member/login");
		needToLogoutactionUrls.add("/usr/member/doLogin");
		needToLogoutactionUrls.add("/usr/member/join");
		needToLogoutactionUrls.add("/usr/member/doJoin");
		needToLogoutactionUrls.add("/usr/member/findLoginId");
		needToLogoutactionUrls.add("/usr/member/doFindLoginId");
		needToLogoutactionUrls.add("/usr/member/findLoginPw");
		needToLogoutactionUrls.add("/usr/member/doFindLoginPw");

		if (needToLogoutactionUrls.contains(actionUrl)) {
			if ((boolean) request.getAttribute("isLogined") == true) {
				request.setAttribute("alertMsg", "로그아웃 후 이용해주세요.");
				request.setAttribute("historyBack", true);

				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/common/redirect.jsp");
				rd.forward(request, response);
			}
		}

		if (App.isProductMode()) {
			MysqlUtil.setDBInfo("127.0.0.1", "sbsstLocal", "sbs123414", "jspCommunity");
		} else {
			MysqlUtil.setDBInfo("127.0.0.1", "sbsst", "sbs123414", "jspCommunity");
			MysqlUtil.setDevMode(true);
		}

		request.setAttribute("appUrl", App.getAppUrl());

		Map<String, Object> rs = new HashMap<>();

		rs.put("controllerName", controllerName);
		rs.put("actionMethodName", actionMethodName);

		return rs;
	}

	protected abstract String doAction(HttpServletRequest request, HttpServletResponse response, String controllerName,
			String actionMethodName) throws ServletException, IOException;

	private void doAfterAction(HttpServletRequest request, HttpServletResponse response, String jspPath)
			throws ServletException, IOException {
		MysqlUtil.closeConnection();

		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/jsp/" + jspPath + ".jsp");
		rd.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		run(request, response);

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
