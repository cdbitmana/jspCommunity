package com.sbs.example.jspCommunity.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Member;
import com.sbs.example.jspCommunity.service.MemberService;

public class UsrMemberController {

	private MemberService memberService;

	public UsrMemberController() {
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
		String email = request.getParameter("email");
		String phoneNo = request.getParameter("phoneNo");
		int id = memberService.doJoin(loginId,loginPw,name,nickName,email,phoneNo);
		
		request.setAttribute("alertMsg", id+"번 회원으로 가입되었습니다.");
		request.setAttribute("replaceUrl", "/jspCommunity/usr/article/list?boardId=1");
		
		return "common/redirect";
	}

	public String login(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginedMemberId") != null) {
			request.setAttribute("alertMsg", "이미 로그인 상태입니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}
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
		
		HttpSession session = request.getSession();
		
		session.setAttribute("loginedMemberId", member.getId());
		session.setAttribute("isLogined", true);
		session.setAttribute("loginedMember", member);
		
		request.setAttribute("alertMsg", member.getName() + "님 로그인 되었습니다.");
		request.setAttribute("historyGo", true);
		return "common/redirect";
	}

	public String doLogout(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		session.removeAttribute("loginedMemberId");
		session.removeAttribute("isLogined");
		session.removeAttribute("loginedMember");
		
		request.setAttribute("alertMsg", "로그아웃 되었습니다.");
		request.setAttribute("replaceUrl", "/jspCommunity/usr/article/list?boardId=1");
		return "common/redirect";
		
	}

}
