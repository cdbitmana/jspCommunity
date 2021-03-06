package com.sbs.example.jspCommunity.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.dto.Reply;

import mysqlutil.MysqlUtil;
import mysqlutil.SecSql;

public class ReplyDao {

	public List<Reply> getReplysByArticleId(int id) {

		List<Reply> replies = null;

		SecSql sql = new SecSql();

		sql.append("SELECT R.* , M.nickName AS extra__writer"

				+ ",IFNULL(SUM(IF(RC.point > 0 , RC.point , 0)) , 0) AS extra__likeCount"
				+ ",IFNULL(SUM(IF(RC.point < 0 , RC.point * -1 , 0)) , 0) AS extra__dislikeCount"
				+ " FROM `reply` AS R");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON R.memberId = M.id");
		sql.append("LEFT JOIN recommend AS RC");
		sql.append("ON R.id = RC.relId");
		sql.append("WHERE R.relId = ?", id);
		sql.append("GROUP BY R.id");

		List<Map<String, Object>> replyMapList = MysqlUtil.selectRows(sql);

		if (!replyMapList.isEmpty()) {
			replies = new ArrayList<>();
			for (Map<String, Object> replyMap : replyMapList) {
				replies.add(new Reply(replyMap));
			}
		}

		return replies;
	}

	public int doWriteArticleReply(int articleId, String body, int memberId) {

		int newReplyId = 0;

		SecSql sql = new SecSql();

		sql.append("INSERT INTO reply SET");
		sql.append("regDate = NOW() , updateDate = NOW()");
		sql.append(",`relType` = 'article'");
		sql.append(",`relId` = ?", articleId);
		sql.append(",`body` = ?", body);
		sql.append(",`memberId` = ?", memberId);
		sql.append(",`status` = 1");

		newReplyId = MysqlUtil.insert(sql);

		sql = new SecSql();

		sql.append("UPDATE article SET");
		sql.append("replyCount = replyCount + 1");
		sql.append("WHERE id = ?", articleId);

		MysqlUtil.update(sql);

		return newReplyId;

	}

	public void doModifyArticleReply(int id, int articleId, String body, int memberId) {
		SecSql sql = new SecSql();

		sql.append("UPDATE `reply` SET");
		sql.append("updateDate = NOW()");
		sql.append(", `body` = ?", body);
		sql.append("WHERE id = ?", id);
		sql.append("AND `relType` = 'article'");
		sql.append("AND `relId` = ?", articleId);
		sql.append("AND memberId = ?", memberId);

		MysqlUtil.update(sql);
	}

	public void doDeleteArticleReply(int id,int articleId) {
		SecSql sql = new SecSql();

		sql.append("UPDATE `reply` SET");
		sql.append("`status` = -1");
		sql.append("WHERE id = ?", id);

		MysqlUtil.update(sql);

		sql = new SecSql();

		sql.append("UPDATE article SET");
		sql.append("replyCount = replyCount -1");
		sql.append("WHERE id = ?", articleId);

		MysqlUtil.update(sql);
	}

	public boolean isLikedReply(int id, int memberId) {

		SecSql sql = new SecSql();

		sql.append("SELECT * FROM recommend");
		sql.append("WHERE relId = ? ", id);
		sql.append("AND memberId = ?", memberId);
		sql.append("AND relType = 'reply'");
		sql.append("AND `point` = 1");

		Map<String, Object> map = MysqlUtil.selectRow(sql);

		if (!map.isEmpty()) {
			return true;
		}

		return false;

	}

	public void doDeleteReplyLike(int id, int memberId) {
		SecSql sql = new SecSql();

		sql.append("DELETE FROM recommend");
		sql.append("WHERE relId = ? ", id);
		sql.append("AND memberId = ?", memberId);
		sql.append("AND relType = 'reply'");
		sql.append("AND `point` = 1");

		MysqlUtil.delete(sql);
	}

	public Reply getReplyById(int id) {

		Reply reply = null;

		SecSql sql = new SecSql();

		sql.append("SELECT R.* " + ",IFNULL(SUM(IF(RC.point > 0 , RC.point , 0)) , 0) AS extra__likeCount"
				+ ",IFNULL(SUM(IF(RC.point < 0 , RC.point * -1 , 0)) , 0) AS extra__dislikeCount" + " FROM reply AS R");
		sql.append("LEFT JOIN recommend AS RC");
		sql.append("ON R.id = RC.relId");
		sql.append("AND RC.relType = 'reply'");
		sql.append("WHERE R.id = ? ", id);
		sql.append("GROUP BY R.id");
		Map<String, Object> map = MysqlUtil.selectRow(sql);

		if (!map.isEmpty()) {
			reply = new Reply(map);
		}

		return reply;

	}

	public void doIncreaseReplyLike(int id, int memberId) {
		SecSql sql = new SecSql();

		sql.append("INSERT INTO recommend SET");
		sql.append("relType = 'reply'");
		sql.append(",`point` = 1");
		sql.append(",relId = ?", id);
		sql.append(",memberId = ?", memberId);

		MysqlUtil.update(sql);
	}

	public boolean isDisLikedReply(int id, int memberId) {
		SecSql sql = new SecSql();

		sql.append("SELECT * FROM recommend");
		sql.append("WHERE relId = ? ", id);
		sql.append("AND memberId = ?", memberId);
		sql.append("AND relType = 'reply'");
		sql.append("AND `point` = -1");

		Map<String, Object> map = MysqlUtil.selectRow(sql);

		if (!map.isEmpty()) {
			return true;
		}

		return false;
	}

	public void doDeleteReplyDisLike(int id, int memberId) {
		SecSql sql = new SecSql();

		sql.append("DELETE FROM recommend");
		sql.append("WHERE relId = ? ", id);
		sql.append("AND memberId = ?", memberId);
		sql.append("AND relType = 'reply'");
		sql.append("AND `point` = -1");

		MysqlUtil.delete(sql);
	}

	public void doIncreaseReplyDisLike(int id, int memberId) {
		SecSql sql = new SecSql();

		sql.append("INSERT INTO recommend SET");
		sql.append("relType = 'reply'");
		sql.append(",`point` = -1");
		sql.append(",relId = ?", id);
		sql.append(",memberId = ?", memberId);

		MysqlUtil.update(sql);
	}

	public List<Reply> getReplies() {
		List<Reply> replies = null;

		SecSql sql = new SecSql();

		sql.append("SELECT R.* , M.nickName AS extra__writer"

				+ ",IFNULL(SUM(IF(RC.point > 0 , RC.point , 0)) , 0) AS extra__likeCount"
				+ ",IFNULL(SUM(IF(RC.point < 0 , RC.point * -1 , 0)) , 0) AS extra__dislikeCount"
				+ " FROM `reply` AS R");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON R.memberId = M.id");
		sql.append("LEFT JOIN recommend AS RC");
		sql.append("ON R.id = RC.relId");
		sql.append("AND RC.relType = 'reply'");
		sql.append("GROUP BY R.id");

		List<Map<String, Object>> replyMapList = MysqlUtil.selectRows(sql);

		if (!replyMapList.isEmpty()) {
			replies = new ArrayList<>();
			for (Map<String, Object> replyMap : replyMapList) {
				replies.add(new Reply(replyMap));
			}
		}

		return replies;

	}

	public int doWriteReply(String relType, int relId, String body, int memberId,int articleId) {
		
		SecSql sql = new SecSql();

		sql.append("INSERT INTO `reply` SET");
		sql.append("regDate = NOW(), updateDate = NOW()");
		sql.append(", `relType` = ?", relType);
		sql.append(", `relId` = ?", relId);
		sql.append(", `body` = ?", body);
		sql.append(", `memberId` = ?", memberId);
		sql.append(", `status` = 1");

		int id = MysqlUtil.insert(sql);
		
		sql = new SecSql();

		sql.append("UPDATE article SET");
		sql.append("replyCount = replyCount + 1");
		sql.append("WHERE id = ?", articleId);

		MysqlUtil.update(sql);
		
		return id;

	}

	public void doModifyReplyReply(int id, String body, int memberId) {
		SecSql sql = new SecSql();

		sql.append("UPDATE `reply` SET");
		sql.append("updateDate = NOW()");
		sql.append(", `body` = ?", body);
		sql.append("WHERE id = ?", id);
		sql.append("AND `relType` = 'reply'");
		sql.append("AND memberId = ?", memberId);

		MysqlUtil.update(sql);
	}

	public void doDeleteReplyReply(int id, int articleId) {
		SecSql sql = new SecSql();

		sql.append("UPDATE `reply` SET");
		sql.append("`status` = -1");
		sql.append("WHERE id = ?", id);

		MysqlUtil.update(sql);

		sql = new SecSql();

		sql.append("UPDATE article SET");
		sql.append("replyCount = replyCount -1");
		sql.append("WHERE id = ?", articleId);

		MysqlUtil.update(sql);

	}

}
