package com.sbs.example.jspCommunity.container;

import com.sbs.example.jspCommunity.controller.AdmMemberController;
import com.sbs.example.jspCommunity.controller.UsrArticleController;
import com.sbs.example.jspCommunity.controller.UsrHomeController;
import com.sbs.example.jspCommunity.controller.UsrMemberController;
import com.sbs.example.jspCommunity.controller.UsrReplyController;
import com.sbs.example.jspCommunity.dao.ArticleDao;
import com.sbs.example.jspCommunity.dao.AttrDao;
import com.sbs.example.jspCommunity.dao.MemberDao;
import com.sbs.example.jspCommunity.dao.ReplyDao;
import com.sbs.example.jspCommunity.service.ArticleService;
import com.sbs.example.jspCommunity.service.AttrService;
import com.sbs.example.jspCommunity.service.EmailService;
import com.sbs.example.jspCommunity.service.MemberService;
import com.sbs.example.jspCommunity.service.ReplyService;

public class Container {
	
	public static ReplyDao replyDao;
	public static AttrDao attrDao;
	public static MemberDao memberDao;
	public static ArticleDao articleDao;
	
	public static ReplyService replyService;
	public static AttrService attrService;
	public static ArticleService articleService;
	public static MemberService memberService;
	
	public static UsrReplyController usrReplyController;
	public static UsrArticleController usrArticleController;
	public static UsrMemberController usrMemberController;
	public static AdmMemberController admMemberController;
	public static UsrHomeController usrHomeController;
	public static EmailService emailService;
	
	static {
		replyDao = new ReplyDao();
		attrDao = new AttrDao();
		memberDao = new MemberDao();
		articleDao = new ArticleDao();
		
		replyService = new ReplyService();
		attrService = new AttrService();
		emailService = new EmailService();
		articleService = new ArticleService();
		memberService = new MemberService();
		
		usrReplyController = new UsrReplyController();
		usrMemberController = new UsrMemberController();
		admMemberController = new AdmMemberController();
		usrArticleController = new UsrArticleController();
		usrHomeController = new UsrHomeController();

	}
}
