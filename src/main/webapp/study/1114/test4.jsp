<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>컨트롤러가 2개 이상의 URL 제어 연습</h2>
	<p>1개의 폼안에서 POST/GET 방식의 제어</p>
	<hr/>
	<%-- <form name="myform" method="post" action="<%=request.getContextPath()%>/j1114_Test4"> --%>
	<!-- // if) 해커에게 공격당했을 때, form 태그 action 뒤 주소만 바꾸면 됨 -->
	<form name="myform" method="post" action="<%=request.getContextPath()%>/j1114_T4">
		<p>
			<input type="submit" value="전송(submit:post방식)" class="btn btn-success" />
			<!-- location.href로 넘기는 건 무조건 get방식 (hidden 으로 넘기는 값 넘어오지 않음_ -->
			<input type="button" value="전송(location:get방식)" onclick="location.href='<%=request.getContextPath()%>/j1114_T4';" class="btn btn-primary" />
		</p>
		<!--
			hidden은 백에서 많이 사용하는 tag 
			value는 변수값! 변수에 담아서 처리
			소스보기로 다 보이긴 함...
			
			hidden은 무조건 post 방식 사용해야함!!!
			(get은 URL에 변수 값 담아서 보내는 방식이므로... 값을 따로 넣지 않으니까 POST)
		-->
		<input type="hidden" name="name" value="홍길동" />
	</form>
</div>
<p><br/></p>
</body>
</html>