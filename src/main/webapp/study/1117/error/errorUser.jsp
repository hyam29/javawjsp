<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>사용자 에러 페이지(errorUser.jsp)</title>
  <jsp:include page="../../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h3>현재 공사중입니다!</h3>
	<p>작업에 불편을 드려 죄송합니다...</p>
	<p>빠른시일 내 복구하겠사옵니다...</p>
	<p><a href="http://192.168.50.190:9090/javawjsp/" target="_blank">돌아가기</a></p>
	<hr/>
	<p><img src="${pageContext.request.contextPath}/images/4.jpg" width="300px" /></p>
	
</div>
<p><br/></p>
</body>
</html>