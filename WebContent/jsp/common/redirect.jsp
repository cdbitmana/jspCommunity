<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script>
var alertMsg = '<c:out value="${alertMsg }"/>'.trim();
if ( alertMsg ) {
	alert(alertMsg);
}
var historyBack = '<c:out value="${historyBack }"/>' == 'true';
if ( historyBack ) {
	history.back();
}
var historyGo = '<c:out value="${historyGo }"/>' == 'true';
if ( historyGo ) {
	history.go(-2);
}
var replaceUrl = '<c:out value="${replaceUrl }"/>'.trim();
	if (replaceUrl) {
		replaceUrl = replaceUrl.replace('amp;','');
		location.replace(replaceUrl);		
	}
</script>