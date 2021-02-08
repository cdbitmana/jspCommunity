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
			UsrHomeController homeController = Container.usrHomeController;
			jspPath = homeController.showMain(request, response);
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
			} else if (actionMethodName.equals("findLoginId")) {
				jspPath = memberController.showFindLoginId(request, response);
			} else if (actionMethodName.equals("doFindLoginId")) {
				jspPath = memberController.doFindLoginId(request, response);
			} else if (actionMethodName.equals("findLoginPw")) {
				jspPath = memberController.showFindLoginPw(request, response);
			} else if (actionMethodName.equals("doFindLoginPw")) {
				jspPath = memberController.doFindLoginPw(request, response);
			} else if (actionMethodName.equals("logout")) {
				jspPath = memberController.doLogout(request, response);
			} else if (actionMethodName.equals("getLoginIdDup")) {
				jspPath = memberController.getLoginIdDup(request, response);
			} else if (actionMethodName.equals("memberInfo")) {
				jspPath = memberController.showMemberInfo(request,response);
			} else if (actionMethodName.equals("memberModifyForm")) {
				jspPath = memberController.showMemberModifyForm(request,response);
			} else if (actionMethodName.equals("doMemberModify")) {
				jspPath = memberController.doMemberModify(request,response);
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
			} else if (actionMethodName.equals("doLikeArticle")) {
				jspPath = articleController.doLike(request,response);
			} else if (actionMethodName.equals("doDislikeArticle")) {
				jspPath = articleController.doDislike(request,response);
			}  else if (actionMethodName.equals("doIncreaseArticleHit")) {
				jspPath = articleController.doIncreaseArticleHit(request,response);
			} 
			
		} else if (controllerName.equals("reply")) {
			UsrReplyController replyController = Container.usrReplyController;
			
			if (actionMethodName.equals("doWriteArticleReply")) {
				jspPath = replyController.doWriteArticleReply(request,response);
			} else if (actionMethodName.equals("doModifyArticleReply")) {
				jspPath = replyController.doModifyArticleReply(request,response);
			} else if (actionMethodName.equals("doDeleteArticleReply")) {
				jspPath = replyController.doDeleteArticleReply(request,response);
			} else if (actionMethodName.equals("doLikeReply")) {
				jspPath = replyController.doLikeReply(request,response);
			} else if (actionMethodName.equals("doDisLikeReply")) {
				jspPath = replyController.doDisLikeReply(request,response);
			} 
			
		}

		return jspPath;

	}

}
