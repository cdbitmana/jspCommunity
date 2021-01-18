package com.sbs.example.jspCommunity.container;

import com.sbs.example.jspCommunity.controller.AdmMemberController;
import com.sbs.example.jspCommunity.controller.ArticleController;
import com.sbs.example.jspCommunity.controller.UsrMemberController;
import com.sbs.example.jspCommunity.dao.ArticleDao;
import com.sbs.example.jspCommunity.dao.MemberDao;
import com.sbs.example.jspCommunity.service.ArticleService;
import com.sbs.example.jspCommunity.service.MemberService;
import com.sbs.example.jspCommunity.session.Session;

public class Container {

	public static Session session;
	public static ArticleDao articleDao;
	public static MemberDao memberDao;
	public static ArticleService articleService;
	public static MemberService memberService;
	public static ArticleController articleController;
	public static UsrMemberController usrMemberController;
	public static AdmMemberController admMemberController;

	static {
		session = new Session();
		articleDao = new ArticleDao();
		memberDao = new MemberDao();
		articleService = new ArticleService();
		memberService = new MemberService();
		usrMemberController = new UsrMemberController();
		admMemberController = new AdmMemberController();
		articleController = new ArticleController();

	}
}
