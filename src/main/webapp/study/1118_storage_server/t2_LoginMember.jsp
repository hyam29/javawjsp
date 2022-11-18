<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mid = session.getAttribute("sMid") == null ? "" : (String) session.getAttribute("sMid");

	int visitCount = 0;
	if(application.getAttribute("aVisitCnt") == null) {
		application.setAttribute("aVisitCnt", 1); 
	}
	else {
		visitCount = (int) application.getAttribute("aVisitCnt") + 1; // 객체니까 강제캐스팅 해야함
		application.setAttribute("aVisitCnt", visitCount); 
	}
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t2_LogingMember.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>회원전용방</h2>
	<p><font color="blue">${sMid}님 로그인 중이십니다.</font></p>
	<span>로그인 되셨어용...! </span>
<hr/>
<div><b>방문자 수(session) - 자신만증가 : <font color='salmon'>${sVisitCnt}</font></b></div>
<div><b>전체 총 방문카운트(application) - 모든회원증가 : <font color='blue'>${aVisitCnt}</font></b></div>
<hr/>
<p><img src="${pageContext.request.contextPath}/images/3.jpg" width="300px" /></p>
<hr/>
<div style="text-align:center;">
<% 	if(mid.equals("admin")) { %>
		<a href="${pageContext.request.contextPath}/study/1118_storage/T2_Delete.jsp" class="btn btn-outline-warning m-2">전체 방문카운트 초기화(if 관리자)</a>
<%	} %>
		<a href="${pageContext.request.contextPath}/study/storage/T2_LogOut" class="btn btn-outline-info m-2">로그아웃</a>
</div>
<hr/>
</div>
<p><br/></p>
</body>
</html>