package com.sbs.example.jspCommunity.dto;

import java.util.Map;

public class Member {
	private int id;
	private String regDate;
	private String updateDate;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getLoginPw() {
		return loginPw;
	}

	public void setLoginPw(String loginPw) {
		this.loginPw = loginPw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public int getAuthLevel() {
		return authLevel;
	}

	public void setAuthLevel(int authLevel) {
		this.authLevel = authLevel;
	}

	private String loginId;
	private String loginPw;
	private String name;
	private String nickName;
	private int authLevel;
	
	public Member(Map<String,Object> memberMap) {
		this.id = (int)memberMap.get("id");
		this.regDate = (String)memberMap.get("regDate");
		this.updateDate = (String)memberMap.get("updateDate");
		this.loginId = (String)memberMap.get("loginId");
		this.loginPw = (String)memberMap.get("loginPw");
		this.name = (String)memberMap.get("name");
		this.nickName = (String)memberMap.get("nickName");
		this.authLevel = (int)memberMap.get("authLevel");
	}
	
}
