package com.sbs.example.jspCommunity.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.container.Container;
import com.sbs.example.jspCommunity.dto.*;

import mysqlutil.MysqlUtil;
import mysqlutil.SecSql;

public class ArticleDao {

	public List<Article> getArticlesForPrintByBoardCode(String boardCode) {

		List<Article> articles = new ArrayList<>();

		SecSql sql = new SecSql();

		sql.append("SELECT A.* , M.name AS extra__writer, B.name AS extra__boardName FROM article AS A");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("INNER JOIN `board` AS B");
		sql.append("ON A.boardId = B.id");
		sql.append("WHERE B.code = ?", boardCode);

		List<Map<String, Object>> articleMapList = MysqlUtil.selectRows(sql);

		for (Map<String, Object> articleMap : articleMapList) {
			articles.add(new Article(articleMap));
		}

		return articles;
	}

	private Board getBoardByCode(String boardCode) {

		Board board = null;

		SecSql sql = new SecSql();

		sql.append("SELECT * FROM `board`");
		sql.append("WHERE `code` = ?", boardCode);

		Map<String, Object> boardMap = MysqlUtil.selectRow(sql);

		if (!boardMap.isEmpty()) {
			board = new Board(boardMap);
		}
		return board;
	}

	public Article getArticleById(int articleId) {
		Article article = null;
		SecSql sql = new SecSql();

		sql.append("SELECT A.* , M.name AS extra__writer , B.name AS extra__boardName");
		sql.append(",IFNULL(SUM(IF(R.point > 0 , R.point , 0)) , 0) AS extra__likeCount");
		sql.append(",IFNULL(SUM(IF(R.point < 0 , R.point * -1 , 0)) , 0) AS extra__dislikeCount");
		sql.append(" FROM article AS A ");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("INNER JOIN `board` AS B");
		sql.append("ON A.boardId = B.id");
		sql.append("LEFT JOIN recommend AS R");
		sql.append("ON A.id = R.relId");
		sql.append("AND R.relType = 'article'");
		sql.append("WHERE A.id = ?", articleId);
		sql.append("GROUP BY A.id");
		Map<String, Object> articleMap = MysqlUtil.selectRow(sql);
		if (articleMap != null) {
			article = new Article(articleMap);
		}
		return article;
	}

	public List<Article> getArticlesForPrintByBoardId(int boardId) {

		List<Article> articles = null;

		SecSql sql = new SecSql();

		sql.append(
				"SELECT A.id,A.updateDate,A.title,A.body,A.memberId,A.boardId,A.hitCount,"
				+ "IFNULL(SUM(IF(R.point > 0 , R.point , 0)) , 0) AS extra__likeCount , "
				+ "IFNULL(SUM(IF(R.point < 0 , R.point , 0)) , 0) AS extra__dislikeCount,"
				+ "A.replyCount,"
				+ "IF( DATE_FORMAT(A.regDate,'%d') = DATE_FORMAT(NOW(),'%d') , DATE_FORMAT( A.regDate , '%H:%i:%s') , A.regDate) AS regDate,"
				+ " M.name AS extra__writer, "
				+ "B.name AS extra__boardName "
				+ "FROM article AS A");
		sql.append("LEFT JOIN recommend AS R");
		sql.append("ON A.id = R.relId");
		sql.append("AND R.relType = 'article'");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("INNER JOIN `board` AS B");
		sql.append("ON A.boardId = B.id");
		sql.append("WHERE A.boardId = ?", boardId);
		sql.append("GROUP BY A.id");
		sql.append("ORDER BY A.id DESC");

		List<Map<String, Object>> articleMapList = MysqlUtil.selectRows(sql);

		if (!articleMapList.isEmpty()) {
			articles = new ArrayList<>();
			for (Map<String, Object> articleMap : articleMapList) {

				articles.add(new Article(articleMap));
			}
		}

		return articles;
	}

	public int doWrite(String title, String body, int memberId, int boardId) {

		SecSql sql = new SecSql();

		sql.append("INSERT INTO article SET");
		sql.append("regDate = NOW() , updateDate = NOW(),");
		sql.append("title = ?,", title);
		sql.append("`body` = ?,", body);
		sql.append("memberId = ?,", memberId);
		sql.append("boardId = ?,", boardId);
		sql.append("hitCount = ?,", 0);
		sql.append("replyCount = 0");
		return MysqlUtil.insert(sql);

	}

	public int doModify(Map<String, Object> modifyArgs) {

		SecSql sql = new SecSql();

		sql.append("UPDATE article SET");
		sql.append("updateDate = NOW()");

		boolean needToUpdate = false;
		String title = (String) modifyArgs.get("title");
		String body = (String) modifyArgs.get("body");
		if (title.length() != 0) {
			needToUpdate = true;
			sql.append(",title = ?", modifyArgs.get("title"));
		}
		if (body.length() != 0) {
			needToUpdate = true;
			sql.append(",`body` = ?", modifyArgs.get("body"));
		}

		sql.append("WHERE id = ?", modifyArgs.get("id"));

		if (needToUpdate == false) {
			return 0;
		}
		MysqlUtil.update(sql);

		return (int) modifyArgs.get("id");

	}

	public void doDelete(int id) {

		SecSql sql = new SecSql();

		sql.append("DELETE FROM article");
		sql.append("WHERE id = ?", id);

		MysqlUtil.delete(sql);

	}

	public Board getBoardById(int boardId) {
		SecSql sql = new SecSql();

		sql.append("SELECT * FROM `board` WHERE id = ?", boardId);

		Map<String, Object> boardMap = MysqlUtil.selectRow(sql);

		Board board = null;

		if (!boardMap.isEmpty()) {
			board = new Board(boardMap);
		}

		return board;

	}

	public List<Board> getBoards() {

		SecSql sql = new SecSql();

		sql.append("SELECT * FROM `board`");

		List<Board> boards = null;

		List<Map<String, Object>> boardMapList = MysqlUtil.selectRows(sql);

		if (!boardMapList.isEmpty()) {
			boards = new ArrayList<>();
			for (Map<String, Object> boardMap : boardMapList) {
				boards.add(new Board(boardMap));
			}
		}

		return boards;

	}

	public List<Article> getArticlesForPrint() {
		List<Article> articles = new ArrayList<>();

		SecSql sql = new SecSql();

		sql.append("SELECT A.* , M.name AS extra__writer, B.name AS extra__boardName FROM article AS A");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("INNER JOIN `board` AS B");
		sql.append("ON A.boardId = B.id");
		sql.append("ORDER BY A.id DESC");

		List<Map<String, Object>> articleMapList = MysqlUtil.selectRows(sql);

		for (Map<String, Object> articleMap : articleMapList) {
			articles.add(new Article(articleMap));
		}

		return articles;
	}

	public List<Article> getArticlesForList(int boardId, String search, String keyword) {

		List<Article> articles = new ArrayList<>();

		SecSql sql = new SecSql();

		sql.append("SELECT A.* , M.name AS extra__writer, B.name AS extra__boardName "
				+ ",IFNULL(SUM(IF(R.point > 0 , R.point , 0)) , 0) AS extra__likeCount "
				+ ",IFNULL(SUM(IF(R.point < 0 , R.point * -1, 0)) , 0) AS extra__dislikeCount"
				+ " FROM article AS A");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("INNER JOIN `board` AS B");
		sql.append("ON A.boardId = B.id");
		sql.append("LEFT JOIN recommend AS R");
		sql.append("ON A.id = R.relId");
		sql.append("AND R.relType = 'article'");
		sql.append("WHERE A.boardId = ?", boardId);

		if (keyword != null) {
			if (search.equals("writer")) {
				sql.append("AND M.name LIKE '%" + keyword + "%'");
			} else if (search.equals("titleandbody")) {
				sql.append("AND (title LIKE '%" + keyword + "%'");
				sql.append("OR `body` LIKE '%" + keyword + "%')");
			} else {
				sql.append("AND `" + search + "` LIKE '%" + keyword + "%'");
			}

		}
		sql.append("GROUP BY A.id");
		sql.append("ORDER BY A.id DESC");

		List<Map<String, Object>> articleMapList = MysqlUtil.selectRows(sql);

		for (Map<String, Object> articleMap : articleMapList) {
			articles.add(new Article(articleMap));
		}

		return articles;

	}

	public List<Article> getArticlesForPrintListByBoardId(int boardId, int limitStart, int itemsInAPage,
			String searchType, String keyword) {
		List<Article> articles = new ArrayList<>();

		SecSql sql = new SecSql();

		sql.append("SELECT A.* , M.name AS extra__writer, B.name AS extra__boardName"				
				+ ",IFNULL(SUM(IF(R.point > 0 , R.point , 0)) , 0) AS extra__likeCount "
				+ ",IFNULL(SUM(IF(R.point < 0 , R.point * -1, 0)) , 0) AS extra__dislikeCount"
				+ " FROM article AS A");
		sql.append("INNER JOIN `member` AS M");
		sql.append("ON A.memberId = M.id");
		sql.append("INNER JOIN `board` AS B");
		sql.append("ON A.boardId = B.id");
		sql.append("LEFT JOIN recommend AS R");
		sql.append("ON A.id = R.relId");
		sql.append("AND R.relType = 'article'");
		sql.append("WHERE A.boardId = ?", boardId);

		if (keyword != null) {
			if (searchType.equals("writer")) {
				sql.append("AND M.name LIKE '%" + keyword + "%'");
			} else if (searchType.equals("titleandbody")) {
				sql.append("AND (title LIKE '%" + keyword + "%'");
				sql.append("OR `body` LIKE '%" + keyword + "%')");
			} else {
				sql.append("AND `" + searchType + "` LIKE '%" + keyword + "%'");
			}

		}
		sql.append("GROUP BY A.id");
		sql.append("ORDER BY A.id DESC");
		if (itemsInAPage != -1) {
			sql.append("LIMIT ?, ?", limitStart, itemsInAPage);
		}

		List<Map<String, Object>> articleMapList = MysqlUtil.selectRows(sql);

		for (Map<String, Object> articleMap : articleMapList) {
			articles.add(new Article(articleMap));
		}

		return articles;
	}


	public boolean isLikedArticle(int id, int memberId) {

		SecSql sql = new SecSql();

		sql.append("SELECT * FROM `recommend`");
		sql.append("WHERE `relType` = 'article'");
		sql.append("AND `point` = 1");
		sql.append("AND `relId` = ?", id);
		sql.append("AND `memberId` = ?", memberId);

		Map<String, Object> recommendMap = MysqlUtil.selectRow(sql);

		if (!recommendMap.isEmpty()) {
			return true;
		}

		return false;

	}

	public void doLikeArticle(int id, int memberId) {

		SecSql sql = new SecSql();

		sql.append("INSERT INTO `recommend` SET");
		sql.append("`relType` = 'article'");
		sql.append(",`point` = 1");
		sql.append(", `relId` = ?", id);
		sql.append(", memberId = ?", memberId);

		MysqlUtil.insert(sql);

		sql = new SecSql();


	}

	public void removeLikeArticle(int id, int memberId) {

		SecSql sql = new SecSql();

		sql.append("DELETE FROM `recommend`");
		sql.append("WHERE `relType` = 'article'");
		sql.append("AND `point` = 1");
		sql.append("AND `relId` = ?", id);
		sql.append("AND memberId = ?", memberId);

		MysqlUtil.delete(sql);

		

	}

	public boolean isDislikedArticle(int id, int memberId) {
		SecSql sql = new SecSql();

		sql.append("SELECT * FROM `recommend`");
		sql.append("WHERE `relType` = 'article'");
		sql.append("AND `point` = -1");
		sql.append("AND `relId` = ?", id);
		sql.append("AND `memberId` = ?", memberId);

		Map<String, Object> recommendMap = MysqlUtil.selectRow(sql);

		if (!recommendMap.isEmpty()) {
			return true;
		}

		return false;
	}

	public void doDislikeArticle(int id, int memberId) {
		SecSql sql = new SecSql();

		sql.append("INSERT INTO `recommend` SET");
		sql.append("`relType` = 'article'");
		sql.append(",`point` = -1");
		sql.append(", `relId` = ?", id);
		sql.append(", memberId = ?", memberId);

		MysqlUtil.insert(sql);

		
	}

	public void removeDislikeArticle(int id, int memberId) {
		SecSql sql = new SecSql();

		sql.append("DELETE FROM `recommend`");
		sql.append("WHERE `relType` = 'article'");
		sql.append("AND `point` = -1");
		sql.append("AND `relId` = ?", id);
		sql.append("AND memberId = ?", memberId);

		MysqlUtil.delete(sql);

	
	}

	public void doIncreaseArticleHitCount(int articleId, int memberId) {
		
		SecSql sql = new SecSql();

		sql.append("UPDATE article SET");
		sql.append("hitCount = hitCount + 1");
		sql.append("WHERE id = ?", articleId);

		MysqlUtil.update(sql);

	}

	

}
