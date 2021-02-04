package com.sbs.example.jspCommunity.dto;

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
	private int likeCount;
	private int dislikeCount;
	private int boardId;
	private String extra__writer;
	private String extra__boardName;
	private String extra__boardCode;

	public Article(Map<String, Object> articleMap) {
		this.id = (int) articleMap.get("id");
		this.regDate = (String) articleMap.get("regDate");
		this.updateDate = (String) articleMap.get("updateDate");
		this.title = (String) articleMap.get("title");
		this.body = (String) articleMap.get("body");
		this.memberId = (int) articleMap.get("memberId");
		this.hitCount = (int) articleMap.get("hitCount");
		this.likeCount = (int) articleMap.get("likeCount");
		this.dislikeCount = (int) articleMap.get("dislikeCount");
		this.boardId = (int) articleMap.get("boardId");
		this.extra__writer = (String) articleMap.get("extra__writer");
		this.extra__boardName = (String) articleMap.get("extra__boardName");
		this.extra__boardCode = (String) articleMap.get("extra__boardCode");
	}

	

}
