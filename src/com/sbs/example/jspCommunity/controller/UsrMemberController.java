package com.sbs.example.jspCommunity.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Member;
import com.sbs.example.jspCommunity.dto.ResultData;
import com.sbs.example.jspCommunity.service.MemberService;
import com.sbs.example.jspCommunity.util.Util;

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

		if (member != null) {
			request.setAttribute("alertMsg", "이미 존재하는 아이디입니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}

		String loginPw = request.getParameter("loginPwReal");
		String name = request.getParameter("name");
		String nickName = request.getParameter("nickName");
		String email = request.getParameter("email");
		String phoneNo = request.getParameter("phoneNo");
		int id = memberService.doJoin(loginId, loginPw, name, nickName, email, phoneNo);

		request.setAttribute("alertMsg", id + "번 회원으로 가입되었습니다.");
		request.setAttribute("replaceUrl", "/jspCommunity/usr/home/main");

		return "common/redirect";
	}

	public String login(HttpServletRequest request, HttpServletResponse response) {

		return "usr/member/loginForm";
	}

	public String doLogin(HttpServletRequest request, HttpServletResponse response) {

		String loginId = request.getParameter("loginId");

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			request.setAttribute("alertMsg", "존재하지 않는 아이디입니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}
		String loginPw = request.getParameter("loginPwReal");

		if (!member.getLoginPw().equals(loginPw)) {
			request.setAttribute("alertMsg", "비밀번호가 맞지 않습니다.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}

		HttpSession session = request.getSession();

		session.setAttribute("isLoginedMemberId", member.getId());
		session.setAttribute("isLogined", true);
		session.setAttribute("isLoginedMember", member);

		request.setAttribute("alertMsg", member.getName() + "님 로그인 되었습니다.");
		request.setAttribute("replaceUrl", "/jspCommunity/usr/home/main");
		return "common/redirect";
	}

	public String doLogout(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		session.removeAttribute("loginedMemberId");
		session.removeAttribute("isLogined");
		session.removeAttribute("loginedMember");

		request.setAttribute("alertMsg", "로그아웃 되었습니다.");
		request.setAttribute("replaceUrl", "/jspCommunity/usr/home/main");
		return "common/redirect";

	}

	public String getLoginIdDup(HttpServletRequest request, HttpServletResponse response) {
		String loginId = request.getParameter("loginId");

		Member member = memberService.getMemberByLoginId(loginId);

		String resultCode = null;
		String msg = null;

		if (member != null) {
			resultCode = "F-1";
			msg = "이미 사용중인 아이디입니다.";
		} else {
			resultCode = "S-1";
			msg = "사용 가능한 아이디입니다.";
		}

		request.setAttribute("data", new ResultData(resultCode,msg,"loginId",loginId));
		return "common/json";
	}

	public String showFindLoginId(HttpServletRequest request, HttpServletResponse response) {

		return "usr/member/findLoginId";
	}

	public String doFindLoginId(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		if (session.getAttribute("loginedMemberId") != null) {
			request.setAttribute("alertMsg", "로그아웃 후 진행해주세요.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}

		String name = request.getParameter("name");
		String email = request.getParameter("email");

		Member member = memberService.getMemberByName(name);

		String resultCode = "";
		String msg = "";
		
		if (member == null) {
			
			resultCode = "F-1";
			msg = "일치하는 이름이 없습니다.";
		}else if (!member.getEmail().equals(email)) {			
			resultCode = "F-1";
			msg = "잘못된 이메일 주소입니다.";	
			
			
		} else {
			resultCode = "S-1";
			msg = String.format("%s님의 아이디는 %s입니다.", member.getName(), member.getLoginId());	
		}
		
	
		ResultData data = new ResultData(resultCode , msg , "name" , name , "email", email);
		request.setAttribute("data", data);
		return "usr/member/findLoginIdRs";
	}

	public String showFindLoginPw(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		if (session.getAttribute("loginedMemberId") != null) {
			request.setAttribute("alertMsg", "로그아웃 후 진행해주세요.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}

		return "usr/member/findLoginPw";
	}

	public String doFindLoginPw(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		if (session.getAttribute("loginedMemberId") != null) {
			request.setAttribute("alertMsg", "로그아웃 후 진행해주세요.");
			request.setAttribute("historyBack", true);
			return "common/redirect";
		}

		String loginId = request.getParameter("loginId");
		String email = request.getParameter("email");

		Member member = memberService.getMemberByLoginId(loginId);

		String resultCode = "";
		String msg = "";
		ResultData sendTempLoginPwToEmailRs = null;
		if (member == null) {			
			resultCode = "F-1";
			msg = "일치하는 아이디가 없습니다.";
			sendTempLoginPwToEmailRs = new ResultData(resultCode , msg);
		}else if (!member.getEmail().equals(email)) {			
			resultCode = "F-1";
			msg = "잘못된 이메일 주소입니다.";	
			sendTempLoginPwToEmailRs = new ResultData(resultCode , msg);
		} else {
			sendTempLoginPwToEmailRs = memberService.sendTempLoginPwToEmail(member);
			
		}
		
		
				
		request.setAttribute("data", sendTempLoginPwToEmailRs);
		return "usr/member/findLoginPwRs";

	}

	

}
