package com.sbs.example.jspCommunity.container;

import com.sbs.example.jspCommunity.controller.AdmMemberController;
import com.sbs.example.jspCommunity.controller.UsrArticleController;
import com.sbs.example.jspCommunity.controller.UsrHomeController;
import com.sbs.example.jspCommunity.controller.UsrMemberController;
import com.sbs.example.jspCommunity.dao.ArticleDao;
import com.sbs.example.jspCommunity.dao.MemberDao;
import com.sbs.example.jspCommunity.service.ArticleService;
import com.sbs.example.jspCommunity.service.EmailService;
import com.sbs.example.jspCommunity.service.MemberService;

public class Container {

	public static MemberDao memberDao;
	public static ArticleDao articleDao;
	
	public static ArticleService articleService;
	public static MemberService memberService;
	public static UsrArticleController usrArticleController;
	public static UsrMemberController usrMemberController;
	public static AdmMemberController admMemberController;
	public static UsrHomeController usrHomeController;
	public static EmailService emailService;
	static {
		memberDao = new MemberDao();
		articleDao = new ArticleDao();
		emailService = new EmailService();
		articleService = new ArticleService();
		memberService = new MemberService();
		usrMemberController = new UsrMemberController();
		admMemberController = new AdmMemberController();
		usrArticleController = new UsrArticleController();
		usrHomeController = new UsrHomeController();

	}
}
