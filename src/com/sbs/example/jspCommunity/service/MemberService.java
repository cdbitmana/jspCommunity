package com.sbs.example.jspCommunity.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.App;
import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dao.MemberDao;
import com.sbs.example.jspCommunity.dto.Member;
import com.sbs.example.jspCommunity.dto.ResultData;
import com.sbs.example.jspCommunity.util.Util;

public class MemberService {

	private MemberDao memberDao;
	private EmailService emailService;
	public MemberService() {
		memberDao = Container.memberDao;
		emailService = Container.emailService;
	}

	public List<Member> getForPrintMembers() {
		return memberDao.getForPrintMembers();
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public int doJoin(String loginId, String loginPw, String name, String nickName, String email, String phoneNo) {
		return memberDao.doJoin(loginId, loginPw, name, nickName, email, phoneNo);
	}

	public Member getMemberByName(String name) {
		return memberDao.getMemberByName(name);
	}

	public Member getMemberById(int id) {
		return memberDao.getMemberById(id);
	}

	public ResultData sendTempLoginPwToEmail(Member actor) {
		// 메일 제목과 내용 만들기
		String siteName = App.getSite();
		String siteLoginUrl = App.getLoginUrl();
		String title = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Util.getTempPassword(6);
		String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
		body += "<a href=\"" + siteLoginUrl + "\" target=\"_blank\">로그인 하러가기</a>";

		// 메일 발송
		int sendRs = emailService.send(actor.getEmail(), title, body);

		if(sendRs != 1) {
			return new ResultData("F-1", "메일 발송에 실패하였습니다.");
		}
		
		
		// 고객의 패스워드를 방금 생성한 임시패스워드로 변경
		setTempPassword(actor, tempPassword);
		
		String resultMsg = String.format("%s님의 새 임시 비밀번호가 %s(으)로 발송되었습니다.", actor.getName(),actor.getEmail());
		
		return new ResultData("S-1",resultMsg, "loginId", actor.getLoginId(), "email" , actor.getEmail());
	}

	private void setTempPassword(Member actor, String tempPassword) {
		Map<String, Object> modifyParam = new HashMap<>();
		modifyParam.put("id", actor.getId());
		modifyParam.put("loginPw", Util.sha256(tempPassword));
		modify(modifyParam);
	}

	private void modify(Map<String, Object> modifyParam) {
		memberDao.modify(modifyParam);
	}

	public void doModifyMember(int id, String nickName, String email, String phoneNo) {
		Map<String,Object> modifyParam = new HashMap<>();
		modifyParam.put("id", id);
		modifyParam.put("nickName", nickName);
		modifyParam.put("email", email);
		modifyParam.put("phoneNo", phoneNo);
		modify(modifyParam);
		
	}

	

}
