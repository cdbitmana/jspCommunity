package com.sbs.example.jspCommunity.service;

import java.util.List;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dao.MemberDao;
import com.sbs.example.jspCommunity.dto.Member;

public class MemberService {
	
	private MemberDao memberDao;
	
	public MemberService() {
		memberDao = Container.memberDao;
	}

	public List<Member> getForPrintMembers() {
		return memberDao.getForPrintMembers();
	}

	public Member getMemberByLoginId(String loginId) {
		return memberDao.getMemberByLoginId(loginId);
	}

	public int doJoin(String loginId, String loginPw, String name, String nickName, String email, String phoneNo) {
		return memberDao.doJoin(loginId,loginPw,name,nickName,email,phoneNo);
	}
	
	public Member getMemberByName(String name) {
		return memberDao.getMemberByName(name);
	}

}
