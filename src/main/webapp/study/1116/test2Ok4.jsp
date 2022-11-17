<%@page import="study.j1116.Test2VO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Test2VO vo = (Test2VO) request.getAttribute("vo");
	/* System.out.println("jsp에서 vo : "+vo); */
%>
<!-- 
	Test2VO 객체로 값 담아오기 때문에 객체를 생성 1. new 로 생성 2. 값 바로 담으면서 생성 => 2번으로!
	vo 는 앞에서(Test2_4) 적은 변수명1
-->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test2Ok4.jsp</title>
  <%@ include file="../../include/bs4.jsp" %>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>이곳은 test2Ok4.jsp 입니다.</h2>
	<p>jsp에서의 vo : <%=vo %></p>
	<p>학 번 : <%=vo.getHakbun()%></p>
	<p>성 명 : <%=vo.getName()%></p>
	<p>국 어 : <%=vo.getKor()%></p>
	<p>영 어 : <%=vo.getEng()%></p>
	<p>수 학 : <%=vo.getMat()%></p>
	<p>사 회 : <%=vo.getSoc()%></p>
	<p>과 학 : <%=vo.getSci()%></p>
	<p>총 점 : <%=vo.getTot()%></p>
	<p>평 균 : <%=vo.getAvg()%></p>
	<p>학 점 : <%=vo.getGrade()%></p>
	<hr/>
	<p><a href="<%=request.getContextPath()%>/study/1116/test2.jsp" class="btn bnt-secondary">돌아가기</a></p>
</div>
<p><br/></p>
</body>
</html>