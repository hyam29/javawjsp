<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>green.jsp</title>
  <jsp:include page="../../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>웹사이트에 접속 시 초기 설정된 값 받아오기 연습 방법1:web.xml 방법2:GreenInit.java</h2>
	<hr/>
	<p>특정서블릿에서 설정된 초기값 받아오기</p>
	<div>
		<p>아이디 : ${mid}</p>
		<p>아이디 : ${pwd}</p>
		<p>아이디 : ${className}</p>
	</div>

	<p>공통변수로 설정된 초기값 받아오기 web.xml 에 작성</p>
	<p>회사명 : ${logoName}</p>
	<p>홈페이지주소 : <a href="${homeAddress}" target="_black">${homeAddress}</a></p> 
	<!-- 로고나, 푸터 눌렀을 때 사용하게 됨 -->

	<div>
		<input type="button" value="서블릿으로부터초기값가져오기" onclick="location.href='${pageContext.request.contextPath}/Green';" class="btn btn-success" />
		<input type="button" value="공통변수의 할당값가져오기" onclick="location.href='${pageContext.request.contextPath}/GlobalGreen';" class="btn btn-success" />
	</div>
</div>
<p><br/></p>
</body>
</html>