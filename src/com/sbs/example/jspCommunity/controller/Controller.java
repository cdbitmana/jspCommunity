package com.sbs.example.jspCommunity.controller;

import javax.servlet.http.HttpServletRequest;

public class Controller {
	
	protected String msgAndBack(HttpServletRequest request , String msg) {
		request.setAttribute("alertMsg", msg);
		request.setAttribute("historyBack", true);
		return "common/redirect";
	}
	
	protected String msgAndReplace(HttpServletRequest request , String msg , String replaceUrl) {
		request.setAttribute("alertMsg", msg);
		request.setAttribute("replaceUrl", replaceUrl);
		return "common/redirect";
	}
	
}
