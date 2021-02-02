package com.sbs.example.jspCommunity.service;

import java.util.List;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dao.ReplyDao;
import com.sbs.example.jspCommunity.dto.Reply;

public class ReplyService {
	
	private ReplyDao replyDao;
	
	public ReplyService() {
		replyDao = Container.replyDao;
	}

	public List<Reply> getArticleReplysByArticleId(int id) {
		return replyDao.getArticleReplysByArticleId(id);
	}

	public void doWriteArticleReply(int articleId,String body, int memberId) {
		replyDao.doWriteArticleReply(articleId,body,memberId);
		
	}

	public void doModifyArticleReply(int id,int articleId, String body, int memberId) {
		replyDao.doModifyArticleReply(id,articleId,body,memberId);
	}

	public void doDeleteArticleReply(int id) {
		replyDao.doDeleteArticleReply(id);
	}

}
