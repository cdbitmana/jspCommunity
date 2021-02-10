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

	public List<Reply> getReplysByArticleId(int id) {
		return replyDao.getReplysByArticleId(id);
	}

	public int doWriteArticleReply(int articleId,String body, int memberId) {
		return replyDao.doWriteArticleReply(articleId,body,memberId);
		
	}

	public void doModifyArticleReply(int id,int articleId, String body, int memberId) {
		replyDao.doModifyArticleReply(id,articleId,body,memberId);
	}

	public void doDeleteArticleReply(int id) {
		replyDao.doDeleteArticleReply(id);
	}

	public boolean isLikedReply(int id, int memberId) {
		return replyDao.isLikedReply(id,memberId);
	}

	public void doDeleteReplyLike(int id, int memberId ) {
		replyDao.doDeleteReplyLike(id,memberId);
	}

	public Reply getReplyById(int id) {
		return replyDao.getReplyById(id);
	}

	public void doIncreaseReplyLike(int id, int memberId) {
		replyDao.doIncreaseReplyLike(id,memberId);
	}

	public boolean isDisLikedReply(int id, int memberId) {
		return replyDao.isDisLikedReply(id,memberId);
	}

	public void doDeleteReplyDisLike(int id, int memberId) {
		replyDao.doDeleteReplyDisLike(id,memberId);
		
	}

	public void doIncreaseReplyDisLike(int id, int memberId) {
		replyDao.doIncreaseReplyDisLike(id,memberId);
		
	}

	public List<Reply> getReplys() {
		return replyDao.getReplys();
	}

	public int doWriteReply(String relType, int relId, String body, int memberId) {
		return replyDao.doWriteReply(relType,relId,body,memberId);
	}

	public void doModifyReplyReply(int id, String body, int memberId) {
		replyDao.doModifyReplyReply(id,body,memberId);
	}

	public void doDeleteReplyReply(int id) {
		replyDao.doDeleteReplyReply(id);
	}

}
