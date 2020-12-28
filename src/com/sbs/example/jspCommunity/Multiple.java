package com.sbs.example.jspCommunity;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/99dan")


public class Multiple extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		int dan = request.getParameter("dan") != null ? Integer.parseInt(request.getParameter("dan")) : 1;
		int limit = request.getParameter("limit") != null ? Integer.parseInt(request.getParameter("limit")) : 9;		
		for (int i = 1; i <= limit; i++) {
			int result = dan * i;
			response.getWriter().append(dan + " * "+ i + " = " + result);
			response.getWriter().append("<br>");
		}

	}

}
