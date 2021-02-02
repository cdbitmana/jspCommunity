package com.sbs.example.jspCommunity.dto;

import java.util.Map;

import lombok.Data;

@Data
public class Reply {
	private int id;
	private String regDate;
	private String updateDate;
	private String relType;
	private int relId;
	private String body;
	private int memberId;
	private String extra__writer;
	
	public Reply(Map<String,Object> replyMap) {
		this.id = (int)replyMap.get("id");
		this.regDate = (String)replyMap.get("regDate");
		this.updateDate = (String)replyMap.get("updateDate");
		this.relType = (String)replyMap.get("relType");
		this.relId = (int)replyMap.get("relId");
		this.body = (String)replyMap.get("body");
		this.memberId = (int)replyMap.get("memberId");
		this.extra__writer = (String)replyMap.get("extra__writer");
	}
}
