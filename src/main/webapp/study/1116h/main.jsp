<%@page import="study.j1116_me.InputVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 <%
 	String sw = request.getParameter("sw") == null ? "" : request.getParameter("sw"); // null값 처리
 %>
 
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>main.jsp</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <style>
  	body {
  		width: 1000px;
  		margin: 0px auto; /* 가운데 정렬 */
  		padding: 0px;
  	}
  	#header {
  		background-color: #eef;
  		text-align: center;
  		height: 90px;
  		font-weight: bolder;
  		font-size: 1.5em;
  	}
  	#header a, #header a:hover {
  		text-decoration: none;
  		color: black;
  	}
  	#footer {
  		background-color: #eef;
  		text-align: center;
  		height: 75px;
  	}
  	#content {
  		background-color: #fff;
  		text-align: center;
  	}
  	
  </style>
</head>
<body>
<div class="container text-center">
	<!-- 헤더영역 ('메뉴/로고' 를 표시한다.) -->
	<div id="header">
	<br/>
		<%@ include file="menu.jsp" %>
	</div>
	
	<!-- 본문영역 -->
	<div id="content">
	<br/>
	<br/>
	<!-- include 지시자 사용해서 외부 파일 불러와준다! (menu에 작성해둔 sw 변수 불러옴) -->
	<%if(sw.equals("input")) { %>
		<%@ include file="input.jsp" %>
	<%} else if(sw.equals("list")) { %>
		<%@ include file="list.jsp" %>

	<%} else { %>
			<h2>상품 등록 및 조회 서비스</h2>
			<hr/>
			<p><img src="../../images/4.jpg" width="600px" /></p>
	<%} %>	
		<br/>
	</div>
	
	<!-- 푸터영역 (Copyright or 주소, 소속, 작성자 등을 기술한다.) -->
	<div id="footer">
		<%@ include file="footer.jsp" %>
	</div>
</div>
</body>
</html>