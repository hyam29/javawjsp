<%@page import="study.j1116.Test2VO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
Test2VO vo = (Test2VO) request.getAttribute("vo");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test2Ok4_2.jsp</title>
  <%@ include file="../../include/bs4.jsp" %>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>이곳은 test2Ok4_2.jsp 입니다.</h2>
	
	<!-- MVC 1 패턴(방식) : 스파게티 코드를 한쪽으로 몰았음 (윗쪽은 server코드(백단)와 아랫쪽은 프론트코드를 작성하도록 딱딱 나눈 것), 우리는 MVC 패턴 2로 갈거임! (면접 다출) -->
	<p>학 번 : ${vo.hakbun}</p> 
	<p>성 명 : ${vo.name}</p>
	<p>국 어 : ${vo.kor}</p>
	<p>영 어 : ${vo.eng}</p>
	<p>수 학 : ${vo.mat}</p>
	<p>사 회 : ${vo.soc}</p>
	<p>과 학 : ${vo.sci}</p>
	<p>총 점 : ${vo.tot}</p>
	<p>평 균 : ${vo.avg}</p>
	<p>학 점 : ${vo.grade}</p>
	<hr/>
	<%-- <p><a href="<%=request.getContextPath()%>/study/1116/test2.jsp" class="btn bnt-secondary">돌아가기</a></p> --%>
	<p><a href="${pageContext.request.contextPath}/study/1116/test2.jsp" class="btn bnt-secondary">돌아가기</a></p>
</div>
<p><br/></p>
</body>
</html>