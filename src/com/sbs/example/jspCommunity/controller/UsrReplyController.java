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
import com.sbs.example.jspCommunity.dto.Reply;
import com.sbs.example.jspCommunity.dto.ResultData;
import com.sbs.example.jspCommunity.service.ArticleService;
import com.sbs.example.jspCommunity.service.ReplyService;
import com.sbs.example.jspCommunity.util.Util;

public class UsrReplyController extends Controller {

	private ArticleService articleService;
	private ReplyService replyService;

	public UsrReplyController() {
		articleService = Container.articleService;
		replyService = Container.replyService;
	}

	public String doWriteArticleReply(HttpServletRequest request, HttpServletResponse response) {

		String body = request.getParameter("body");
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		
		replyService.doWriteArticleReply(articleId, body, memberId);

		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", request.getParameter("afterWriteReplyUrl"));
		}

		return "common/redirect";
	}

	
	public String doModifyArticleReply(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		String body = request.getParameter("body");
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		replyService.doModifyArticleReply(id,articleId,body,memberId);
		
		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", request.getParameter("afterWriteReplyUrl"));
		}

		return "common/redirect";

	}
	

	

	public String doDeleteArticleReply(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		
		replyService.doDeleteArticleReply(id);
		
		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", request.getParameter("afterWriteReplyUrl"));
		}

		return "common/redirect";
	}

}
