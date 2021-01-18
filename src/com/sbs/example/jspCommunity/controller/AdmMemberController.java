package com.sbs.example.jspCommunity.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Member;
import com.sbs.example.jspCommunity.service.MemberService;

public class AdmMemberController {

	private MemberService memberService;

	public AdmMemberController() {
		memberService = Container.memberService;
	}

	public String showList(HttpServletRequest request, HttpServletResponse response) {
		List<Member> members = memberService.getForPrintMembers();

		request.setAttribute("members", members);

		return "usr/member/memberlist";
	}

	public String showJoin(HttpServletRequest request, HttpServletResponse response) {
		
		return "usr/member/joinForm";
	}

	public String doJoin(HttpServletRequest request, HttpServletResponse response) {
		String loginId = request.getParameter("loginId");
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member != null) {
			request.setAttribute("alertMsg", "이미 존재하는 아이디입니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}
		
		String loginPw = request.getParameter("loginPw");
		String name = request.getParameter("name");
		String nickName = request.getParameter("nickName");
		
		int id = memberService.doJoin(loginId,loginPw,name,nickName);
		
		request.setAttribute("alertMsg", id+"번 회원으로 가입되었습니다.");
		request.setAttribute("replaceUrl", "/jspCommunity/usr/article/list?boardId=1");
		
		return "common/redirect";
	}

	public String login(HttpServletRequest request, HttpServletResponse response) {

		return "usr/member/loginForm";
	}

	public String doLogin(HttpServletRequest request, HttpServletResponse response) {

		String loginId = request.getParameter("loginId");
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if(member == null) {
			request.setAttribute("alertMsg", "존재하지 않는 아이디입니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}
		String loginPw = request.getParameter("loginPw");
		
		if(!member.getLoginPw().equals(loginPw)) {
			request.setAttribute("alertMsg", "비밀번호가 맞지 않습니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}
		
		Container.session.setLoginedMemeberId(member.getId());
		
		request.setAttribute("alertMsg", member.getName() + "님 로그인 되었습니다.");
		request.setAttribute("replaceUrl", "/jspCommunity/usr/article/list?boardId=1");
		return "common/redirect";
	}

}
