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



	public List<Article> getArticlesForPrintByBoardId(int boardId) {
		return articleDao.getArticlesForPrintByBoardId(boardId);
	}

	public void doWrite(String title, String body, int memberId, int boardId) {
		articleDao.doWrite(title,body,memberId,boardId);
		
	}

	public void doModify(int id, String body, String title) {
		articleDao.doModify(id,title,body);
		
	}

	public void doDelete(int id) {
		articleDao.doDelete(id);
		
	}
}
