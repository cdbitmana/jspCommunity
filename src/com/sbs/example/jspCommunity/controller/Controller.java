package com.sbs.example.jspCommunity.controller;

import javax.servlet.http.HttpServletRequest;

import com.sbs.example.jspCommunity.dto.ResultData;

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
	
	protected String json(HttpServletRequest request, ResultData resultData) {
		request.setAttribute("data", resultData);
		return "common/json";
	}
}
