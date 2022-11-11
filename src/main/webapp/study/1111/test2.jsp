<!-- 명령 1. 지시자(디렉티브 directive) -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test1.jsp</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
	<!-- HTML 주석 -->
	<%-- JSP 주석 --%>    
	<h2>이곳은 1111폴더의 test1.jsp입니다.</h2>  
	<% // 명령 2. 스크립틀릿(자바코드를 작성하는 공간)
		//이곳은 자바 한줄 주석입니다.  
		/*
			이곳은 자바 여러 줄 주석입니다.
		*/
		System.out.println("이곳은 jsp파일입니다.");
	
		out.println("<font color='red'>이곳은 jsp2의 out 메소드</font> 입니다."); // 웹에 뜨는 친구 -> HTML 코드 작성 가능
	%>
	<hr/>
	<%="명령3. 안녕하세요. 이곳은 <b>표현식(expression)</b> 내부입니다.<hr/>" %>
</div>
<p><br/></p>
</body> 
</html> 