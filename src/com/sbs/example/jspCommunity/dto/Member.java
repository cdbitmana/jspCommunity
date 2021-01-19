package com.sbs.example.jspCommunity.dto;

import java.util.Map;

import lombok.*;

@Data
public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	private String loginId;
	private String loginPw;
	private String name;
	private String nickName;
	private String email;
	private String phoneNo;
	private int authLevel;
	

	
	
	public Member(Map<String,Object> memberMap) {
		this.id = (int)memberMap.get("id");
		this.regDate = (String)memberMap.get("regDate");
		this.updateDate = (String)memberMap.get("updateDate");
		this.loginId = (String)memberMap.get("loginId");
		this.loginPw = (String)memberMap.get("loginPw");
		this.name = (String)memberMap.get("name");
		this.nickName = (String)memberMap.get("nickName");
		this.email = (String)memberMap.get("email");
		this.phoneNo = (String)memberMap.get("phoneNo");
		this.authLevel = (int)memberMap.get("authLevel");
	}
	
}
