package com.sbs.example.jspCommunity.dto;

import java.util.LinkedHashMap;
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
	
	private Map<String, Object> extra;
	
	private String extra__writer;
	private int extra__likeCount;
	private int extra__dislikeCount;
	
	public Reply(Map<String,Object> replyMap) {
		this.id = (int)replyMap.get("id");
		this.regDate = (String)replyMap.get("regDate");
		this.updateDate = (String)replyMap.get("updateDate");
		this.relType = (String)replyMap.get("relType");
		this.relId = (int)replyMap.get("relId");
		this.body = (String)replyMap.get("body");
		this.memberId = (int)replyMap.get("memberId");
		
		if(replyMap.containsKey("extra__writer")) {
			this.extra__writer = (String)replyMap.get("extra__writer");
		}
		if(replyMap.containsKey("extra__likeCount")) {
			this.extra__likeCount = Integer.parseInt(String.valueOf(replyMap.get("extra__likeCount")));
		}
		if(replyMap.containsKey("extra__dislikeCount")) {
			this.extra__dislikeCount = Integer.parseInt(String.valueOf(replyMap.get("extra__dislikeCount"))) ;
		}
		
		this.extra = new LinkedHashMap<>();
	}
}
