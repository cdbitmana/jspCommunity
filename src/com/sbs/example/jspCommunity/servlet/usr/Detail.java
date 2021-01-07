package com.sbs.example.jspCommunity.servlet.usr;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import mysqlutil.MysqlUtil;
import mysqlutil.SecSql;

@WebServlet("/usr/jspCommunity/usr/article/detail")

public class Detail extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// 입력된 데이터의 문자셋은 UTF-8 이다.
		request.setCharacterEncoding("UTF-8");
		// 출력될 문서는 html(UTF-8) 이다.
		response.setContentType("text/html; charset=UTF-8");

		MysqlUtil.setDBInfo("localhost", "sbsst", "sbs123414", "jspCommunity");

			
		SecSql sql = new SecSql();
		
		sql.append("SELECT * FROM article ");		
		sql.append("WHERE id = ?",request.getParameter("id"));
		
		Map<String,Object> articleMap = MysqlUtil.selectRow(sql);
		
		MysqlUtil.closeConnection();

		request.setAttribute("articleMap", articleMap);
		
		RequestDispatcher re = request.getRequestDispatcher("/jsp/usr/home/articleDetail.jsp");
		re.forward(request, response);
	
	}
}
