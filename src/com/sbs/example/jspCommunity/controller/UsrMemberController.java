package com.sbs.example.jspCommunity.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.Attr;
import com.sbs.example.jspCommunity.dto.Member;
import com.sbs.example.jspCommunity.dto.ResultData;
import com.sbs.example.jspCommunity.service.AttrService;
import com.sbs.example.jspCommunity.service.MemberService;
import com.sbs.example.jspCommunity.util.Util;

public class UsrMemberController extends Controller {

	private MemberService memberService;
	private AttrService attrService;

	public UsrMemberController() {
		memberService = Container.memberService;
		attrService = Container.attrService;
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
			return msgAndBack( request, "이미 존재하는 아이디입니다.");
		}
		

		String loginPw = request.getParameter("loginPwReal");
		String name = request.getParameter("name");
		String nickName = request.getParameter("nickName");
		String email = request.getParameter("email");
		String phoneNo = request.getParameter("phoneNo");
		
		int id = memberService.doJoin(loginId, loginPw, name, nickName, email, phoneNo);
		
		member = memberService.getMemberById(id);
		
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
		Calendar now = Calendar.getInstance();
		now.add(Calendar.DATE, 90);
		String nowAdd90day = format.format(now.getTime());
		
		attrService.setValue("member__" + member.getId() + "__extra__loginPwUsing90day", "0", nowAdd90day);
		
		memberService.sendJoinMsgToEmail(member);
		
		return msgAndReplace( request, id + "번 회원으로 가입되었습니다.", "/jspCommunity/usr/home/main");
	}

	public String login(HttpServletRequest request, HttpServletResponse response) {

		return "usr/member/loginForm";
	}

	public String doLogin(HttpServletRequest request, HttpServletResponse response) {

		String loginId = request.getParameter("loginId");

		Member member = memberService.getMemberByLoginId(loginId);
		HttpSession session = request.getSession();
		if (member == null) {			
			return msgAndBack(request, "존재하지 않는 아이디입니다.");
		}
		
		String loginPw = request.getParameter("loginPwReal");

		if (!member.getLoginPw().equals(loginPw)) {			
			return msgAndBack(request, "비밀번호가 맞지 않습니다.");
		}
		
		Attr attr = null;
		if(attrService.get("member__" + member.getId() + "__extra__isUsingTempPassword") != null) {
			attr = attrService.get("member__" + member.getId() + "__extra__isUsingTempPassword");	
			if(attr.getValue().equals("1")) {
				request.setAttribute("alertMsg", "임시 비밀번호를 사용중입니다. 비밀번호를 변경해 주세요.");
				request.setAttribute("isTempPw", true);
				session.setAttribute("isTempPw", true);
			}
		}
		
		if(attrService.get("member__"+member.getId()+"__extra__loginPwUsing90day") == null) {
				request.setAttribute("alertMsg", "비밀번호를 사용한 지 90일이 경과되었습니다. 비밀번호를 변경해 주세요.");
				session.setAttribute("loginPwUsing90day", true);
		}
		
		
		

		session.setAttribute("loginedMemberId", member.getId());
		session.setAttribute("isLogined", true);
		session.setAttribute("loginedMember", member);

		request.setAttribute("loginedMemberId", member.getId());
		request.setAttribute("isLogined", true);
		request.setAttribute("loginedMember", member);

		request.setAttribute("replaceUrl", "/jspCommunity/usr/home/main");
		
		if ( Util.isEmpty(request.getParameter("afterLoginUrl")) == false ) {
			request.setAttribute("replaceUrl", request.getParameter("afterLoginUrl"));
		}
		
		return "common/redirect";
	}

	public String doLogout(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		session.removeAttribute("loginedMemberId");
		session.removeAttribute("isLogined");
		session.removeAttribute("loginedMember");
		session.removeAttribute("isTempPw");
		session.removeAttribute("loginPwUsing90day");
		return msgAndReplace(request,"로그아웃 되었습니다.","/jspCommunity/usr/home/main");

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

		return json(request, new ResultData(resultCode, msg, "loginId", loginId));
	}

	public String showFindLoginId(HttpServletRequest request, HttpServletResponse response) {

		return "usr/member/findLoginId";
	}

	public String doFindLoginId(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		if (session.getAttribute("loginedMemberId") != null) {
			
			return msgAndBack(request,"로그아웃 후 진행해주세요.");
		}

		String name = request.getParameter("name");
		String email = request.getParameter("email");

		Member member = memberService.getMemberByName(name);

		String resultCode = "";
		String msg = "";

		if (member == null) {

			resultCode = "F-1";
			msg = "일치하는 이름이 없습니다.";
		} else if (!member.getEmail().equals(email)) {
			resultCode = "F-1";
			msg = "잘못된 이메일 주소입니다.";

		} else {
			resultCode = "S-1";
			msg = String.format("%s님의 아이디는 %s입니다.", member.getName(), member.getLoginId());
		}

		ResultData data = new ResultData(resultCode, msg, "name", name, "email", email);
		request.setAttribute("data", data);
		return "usr/member/findLoginIdRs";
	}

	public String showFindLoginPw(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		if (session.getAttribute("loginedMemberId") != null) {
			return msgAndBack(request,"로그아웃 후 진행해주세요.");
		}

		return "usr/member/findLoginPw";
	}

	public String doFindLoginPw(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		if (session.getAttribute("loginedMemberId") != null) {
			return msgAndBack(request,"로그아웃 후 진행해주세요.");
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
			sendTempLoginPwToEmailRs = new ResultData(resultCode, msg);
		} else if (!member.getEmail().equals(email)) {
			resultCode = "F-1";
			msg = "잘못된 이메일 주소입니다.";
			sendTempLoginPwToEmailRs = new ResultData(resultCode, msg);
		} else {
			sendTempLoginPwToEmailRs = memberService.sendTempLoginPwToEmail(member);
			if(sendTempLoginPwToEmailRs.getResultCode().startsWith("S-")) {
				session.removeAttribute("loginPwUsing90day");
			}
		}
		
		request.setAttribute("data", sendTempLoginPwToEmailRs);
		return "usr/member/findLoginPwRs";

	}

	public String showMemberInfo(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();

		if (session.getAttribute("loginedMemberId") == null) {
			return msgAndBack(request,"로그인 후 진행해주세요.");
			
		}

		request.setAttribute("member", session.getAttribute("loginedMember"));

		return "usr/member/memberInfo";

	}

	public String showMemberModifyForm(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();

		if (session.getAttribute("loginedMemberId") == null) {
			return msgAndBack(request,"로그인 후 진행해주세요.");
		}

		request.setAttribute("member", session.getAttribute("loginedMember"));

		return "usr/member/memberInfoModifyForm";
	}

	public String doMemberModify(HttpServletRequest request, HttpServletResponse response) {

		int id = Integer.parseInt(request.getParameter("id"));
		String loginPw = request.getParameter("loginPwReal");
		Member member = memberService.getMemberById(id);
		HttpSession session = request.getSession();
		if(loginPw != null && loginPw.length() == 0) {
			loginPw = null;
		}
		
		String tempPw = attrService.getValue("member__"+member.getId()+"__extra__isUsingTempPassword");
		
		if( !member.getLoginPw().equals(loginPw) && tempPw.equals("1")) {
			attrService.remove("member__"+member.getId()+"__extra__isUsingTempPassword");
			session.removeAttribute("isTempPw");
		}
		
		if(!member.getLoginPw().equals(loginPw)) {
			SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
			Calendar now = Calendar.getInstance();
			now.add(Calendar.DATE, 90);
			String nowAdd90day = format.format(now.getTime());
			
			attrService.setValue("member__" + member.getId() + "__extra__loginPwUsing90day", "0", nowAdd90day);
			session.removeAttribute("loginPwUsing90day");
		}
		
		
		String nickName = request.getParameter("nickName");
		if(nickName != null && nickName.length() == 0) {
			nickName = null;
		}
		String email = request.getParameter("email");
		if(email != null && email.length() == 0) {
			email = null;
		}
		String phoneNo = request.getParameter("phoneNo");
		if(phoneNo != null && phoneNo.length() == 0) {
			phoneNo = null;
		}

		memberService.doModifyMember(id, loginPw, nickName, email, phoneNo);
		
		

		

		session.removeAttribute("loginedMember");

		session.setAttribute("loginedMember", member);

		return msgAndReplace(request,"회원 정보가 수정되었습니다.","../member/memberInfo");

	}

}
