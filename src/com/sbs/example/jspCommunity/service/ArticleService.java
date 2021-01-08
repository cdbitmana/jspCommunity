package com.sbs.example.jspCommunity.service;

import com.sbs.example.jspCommunity.dto.Article;
import com.sbs.example.jspCommunity.dao.ArticleDao;

import java.util.List;

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

	public void doDelete(int articleId, int memberId) {
		articleDao.doDelete(articleId, memberId);

	}

	public void doModify(int memberId, String title, String body, int articleId) {
		articleDao.doModify(memberId, title, body, articleId);

	}

	public void doWrite(int boardId, int memberId, String title, String body) {
		articleDao.doWrite(boardId,memberId,title,body);
		
	}
}
