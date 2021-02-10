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

		int newReplyId = replyService.doWriteArticleReply(articleId, body, memberId);

		String afterWriteReplyUrl = request.getParameter("afterWriteReplyUrl");
		afterWriteReplyUrl = afterWriteReplyUrl.replace("[NEW_REPLY_ID]", newReplyId + "");

		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", afterWriteReplyUrl);
		}

		return "common/redirect";
	}

	public String doModifyArticleReply(HttpServletRequest request, HttpServletResponse response) {
		int id = Integer.parseInt(request.getParameter("id"));
		String body = request.getParameter("body");
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int articleId = Integer.parseInt(request.getParameter("articleId"));
		replyService.doModifyArticleReply(id, articleId, body, memberId);

		String afterWriteReplyUrl = request.getParameter("afterWriteReplyUrl");
		afterWriteReplyUrl = afterWriteReplyUrl.replace("[NEW_REPLY_ID]", id + "");

		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", afterWriteReplyUrl);
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

	public String doLikeReply(HttpServletRequest request, HttpServletResponse response) {

		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int id = Integer.parseInt(request.getParameter("replyId"));

		boolean isLikedReply = replyService.isLikedReply(id, memberId);
		int likeCount = 0;
		Reply reply = null;
		String resultCode = null;
		Map<String, Object> map = new HashMap<>();

		if (isLikedReply) {
			replyService.doDeleteReplyLike(id, memberId);
			reply = replyService.getReplyById(id);
			likeCount = reply.getExtra__likeCount();
			resultCode = "F-1";
			map.put("replyLikeCount", likeCount);
		} else {
			replyService.doIncreaseReplyLike(id, memberId);
			reply = replyService.getReplyById(id);
			likeCount = reply.getExtra__likeCount();
			resultCode = "S-1";
			map.put("replyLikeCount", likeCount);
		}

		return json(request, new ResultData(resultCode, "", map));

	}

	public String doDisLikeReply(HttpServletRequest request, HttpServletResponse response) {
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int id = Integer.parseInt(request.getParameter("replyId"));

		boolean isDisLikedReply = replyService.isDisLikedReply(id, memberId);
		int likeCount = 0;
		Reply reply = null;
		String resultCode = null;
		Map<String, Object> map = new HashMap<>();

		if (isDisLikedReply) {
			replyService.doDeleteReplyDisLike(id, memberId);
			reply = replyService.getReplyById(id);
			likeCount = reply.getExtra__dislikeCount();
			resultCode = "F-1";
			map.put("replyDislikeCount", likeCount);
		} else {
			replyService.doIncreaseReplyDisLike(id, memberId);
			reply = replyService.getReplyById(id);
			likeCount = reply.getExtra__dislikeCount();
			resultCode = "S-1";
			map.put("replyDislikeCount", likeCount);
		}

		return json(request, new ResultData(resultCode, "", map));

	}

	public String doWriteReplyReply(HttpServletRequest request, HttpServletResponse response) {

		String body = request.getParameter("body");
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int replyId = Integer.parseInt(request.getParameter("replyId"));
		String relType = "reply";
		int newReplyId = replyService.doWriteReply(relType, replyId, body, memberId);

		String afterWriteReplyUrl = request.getParameter("afterWriteReplyUrl");
		afterWriteReplyUrl = afterWriteReplyUrl.replace("[NEW_REPLY_ID]", newReplyId + "");

		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", afterWriteReplyUrl);
		}

		return "common/redirect";
	}

	public String doModifyReplyReply(HttpServletRequest request, HttpServletResponse response) {

		String body = request.getParameter("body");
		int memberId = Integer.parseInt(request.getParameter("memberId"));
		int id = Integer.parseInt(request.getParameter("id"));

		replyService.doModifyReplyReply(id, body, memberId);

		String afterWriteReplyUrl = request.getParameter("afterWriteReplyUrl");
		afterWriteReplyUrl = afterWriteReplyUrl.replace("[NEW_REPLY_ID]", id + "");

		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", afterWriteReplyUrl);
		}

		return "common/redirect";

	}

	public String doDeleteReplyReply(HttpServletRequest request, HttpServletResponse response) {
		
		int id = Integer.parseInt(request.getParameter("id"));

		replyService.doDeleteReplyReply(id);

		if (Util.isEmpty(request.getParameter("afterWriteReplyUrl")) == false) {

			request.setAttribute("replaceUrl", request.getParameter("afterWriteReplyUrl"));
		}

		return "common/redirect";
	}

}
