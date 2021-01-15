package com.sbs.example.jspCommunity.service;

import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dao.ArticleDao;

import java.util.List;
import java.util.Map;

import com.sbs.example.jspCommunity.container.Container;

public class ArticleService {

	private ArticleDao articleDao;

	public ArticleService() {

		articleDao = Container.articleDao;

	}

	public List<Article> getArticlesForPrintByBoardCode(String boardCode) {
		return articleDao.getArticlesForPrintByBoardCode(boardCode);

	}

	public Article getArticleById(int articleId) {
		return articleDao.getArticleById(articleId);
	}

	public List<Article> getArticlesForPrintByBoardId(int boardId) {
		return articleDao.getArticlesForPrintByBoardId(boardId);
	}

	public int doWrite(String title, String body, int memberId, int boardId) {
		return articleDao.doWrite(title, body, memberId, boardId);

	}

	public int doModify(Map<String,Object> modifyArgs) {
		return articleDao.doModify(modifyArgs);

	}

	public void doDelete(int id) {
		articleDao.doDelete(id);

	}
}
