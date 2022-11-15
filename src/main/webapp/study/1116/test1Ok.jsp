<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- test1Ok.jsp 중간목적지 -->
<%@ include file="../../include/bs4.jsp" %>
<%
	request.setCharacterEncoding("utf-8");

	String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
	String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
	String name = request.getParameter("name") == null ? "" : request.getParameter("name");
			
%>
<p><br/></p>
<div class="containder">
	<p>아이디 : <%=mid %></p>
	<p>비밀번호 : <%=pwd %></p>
	<p>성명 : <%=name %></p>
	<p><a href="test1.jsp" class="btn btn-success">돌아가기</a></p>
</div>

	<!-- 
		* forward : 앞의 내용이 무엇이든 간에 상관X 무조건 page에 적힌 주소로 보냄
		=> 중간목적지인 test1Ok.jsp를 거치지 않고 res로 가버려라! 
		
		=> 웹페이지에 주소표시줄에는 중간목적지 주소(test1Ok.jsp)로 나옴! 따라서, 보안성 강화 (해커들이 찾아오기 힘듦)
		
		* jsp:param
		name: 변수, value: 값 (forward로 가져갈 값 있니? => jsp:param 이용)
	-->

<% if(mid.equals("admin") && pwd.equals("1234")) { %>
     <jsp:forward page="test1Res.jsp">
       <jsp:param value="안녕" name="flag"/> 
     </jsp:forward>
<% } else { %>
     <jsp:forward page="test1.jsp"></jsp:forward> 
<% } %>