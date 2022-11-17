<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t3_SessionGroup.jsp -->

<%
	Enumeration names = session.getAttributeNames();
	
	while(names.hasMoreElements()) {
		String name = (String) names.nextElement(); // names.nextElement() 이건 객체니까 String으로 강제 형변환
		
		out.print("세션명 : " + name + "<br/>");
	}
%>

<p>
	<a href="t3_SessionMain.jsp" class="btn btn-ouline-secondary form-control">돌아가기</a>
</p>