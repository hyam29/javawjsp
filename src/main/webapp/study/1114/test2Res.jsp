<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=utf-8");

	String mid = request.getParameter("mid");
	String name = request.getParameter("name");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test2Res.jsp</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
	이곳은 관리자 화면입니다.
	<p>전송된 아이디 : <%=mid %></p>
	<p>전송된 성명 : <%=name %></p>
	<hr/>
	<p><img src="../../images/2.jpg" width=200px/></p>
	<hr/>
		접속 전송방식 : <%=request.getMethod() %><br/>
		<!-- get방식으로 뜸 -> form 태그(test2.jsp ? 전까지)에 경로를 직접 적어주면 get방식으로 뜸 -->
		접속 URL : <%=request.getRequestURL() %><br/>
		접속 URI : <%=request.getRequestURI() %><br/>
		접속 서버이름 : <%=request.getServerName() %><br/>
		접속 포트번호 : <%=request.getServerPort() %><br/>
		요청 파라메터 길이 : <%=request.getContentLength() %><br/>
		현재 ContextPath : <%=request.getContextPath() %><br/>
		현재 사용중인 프로토콜 : <%=request.getProtocol() %><br/>
	<hr/>
	<p>
		<!-- <a href="logout.jsp">로그아웃</a> --> <!-- jsp에 생성 -->
		<a href="<%=request.getContextPath()%>/j1114_Logout?name=+<%=name%>">로그아웃</a>
	</p>
</div>
<p><br/></p>
</body>
</html>