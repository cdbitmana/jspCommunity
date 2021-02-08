package com.sbs.example.jspCommunity.dto;

import java.util.LinkedHashMap;
import java.util.Map;

import lombok.*;

@Data
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private String title;
	private String body;
	private int memberId;
	private int hitCount;	
	private int replyCount;
	private int boardId;
	
	private Map<String, Object> extra;
	
	private String extra__writer;
	private String extra__boardName;
	private String extra__boardCode;
	private int extra__likeCount;
	private int extra__dislikeCount;

	public Article(Map<String, Object> articleMap) {
		this.id = (int) articleMap.get("id");
		this.regDate = (String) articleMap.get("regDate");
		this.updateDate = (String) articleMap.get("updateDate");
		this.title = (String) articleMap.get("title");
		this.body = (String) articleMap.get("body");
		this.memberId = (int) articleMap.get("memberId");
		this.hitCount = (int) articleMap.get("hitCount");
		this.replyCount = (int) articleMap.get("replyCount");
		this.boardId = (int) articleMap.get("boardId");
		
		if(articleMap.containsKey("extra__writer")) {
			this.extra__writer = (String) articleMap.get("extra__writer");
		}
		
		if(articleMap.containsKey("extra__boardCode")) {
			this.extra__boardCode = (String) articleMap.get("extra__boardCode");
		}
		if(articleMap.containsKey("extra__boardName")) {
			this.extra__boardName = (String) articleMap.get("extra__boardName");
		}
		if(articleMap.containsKey("extra__likeCount")) {
			this.extra__likeCount = Integer.parseInt(String.valueOf(articleMap.get("extra__likeCount")));
		}
		if(articleMap.containsKey("extra__dislikeCount")) {
			this.extra__dislikeCount = Integer.parseInt(String.valueOf(articleMap.get("extra__dislikeCount"))) ;
		}
		
		this.extra = new LinkedHashMap<>();
	}

	

}
