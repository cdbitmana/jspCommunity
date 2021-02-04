package com.sbs.example.jspCommunity.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.dto.Reply;

import mysqlutil.MysqlUtil;
import mysqlutil.SecSql;

public class ReplyDao {

	public List<Reply> getArticleReplysByArticleId(int id) {
		
		List<Reply> replys = null;
		
		SecSql sql = new SecSql();
		
		sql.append("SELECT R.* , M.nickName AS extra__writer FROM `reply` AS R");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON R.memberId = M.id");
		sql.append("WHERE R.relType = 'article'");
		sql.append("AND R.relId = ?", id);
		
		List<Map<String,Object>> replyMapList = MysqlUtil.selectRows(sql);
		
		if(!replyMapList.isEmpty()) {
			replys = new ArrayList<>();
			for(Map<String,Object> replyMap : replyMapList) {
				replys.add(new Reply(replyMap));
			}
		}
		
		return replys;
	}
	
	public void doWriteArticleReply(int articleId,String body, int memberId) {
		SecSql sql = new SecSql();
		
		sql.append("INSERT INTO reply SET");
		sql.append("regDate = NOW() , updateDate = NOW()");
		sql.append(",`relType` = 'article'");
		sql.append(",`relId` = ?",articleId);
		sql.append(",`body` = ?",body);
		sql.append(",`memberId` = ?",memberId);
		
		MysqlUtil.insert(sql);
		
		sql = new SecSql();
		
		sql.append("UPDATE article SET");
		sql.append("replyCount = replyCount + 1");
		sql.append("WHERE id = ?" , articleId);
		
		MysqlUtil.update(sql);
		
	}

	public void doModifyArticleReply(int id,int articleId, String body, int memberId) {
		SecSql sql = new SecSql();
		
		sql.append("UPDATE `reply` SET");
		sql.append("updateDate = NOW()");
		sql.append(", `body` = ?",body);
		sql.append("WHERE id = ?",id);
		sql.append("AND `relType` = 'article'");
		sql.append("AND `relId` = ?",articleId);
		sql.append("AND memberId = ?",memberId);
		
		MysqlUtil.update(sql);
	}

	public void doDeleteArticleReply(int id) {
		SecSql sql = new SecSql();
		
		sql.append("DELETE FROM `reply`");
		sql.append("WHERE id = ?" , id);
		
		MysqlUtil.delete(sql);
	}

}
