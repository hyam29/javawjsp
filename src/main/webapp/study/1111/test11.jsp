<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test11.jsp</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script>
  	'use strict';
  	
  	function fCheck() {
  	let name = myform.name.value;
	  	if(name == "") {
	  		alert("이름을 입력하세요.");
	  		myform.name.focus();
	  		return false;
	  	}
	  	else {
	  		myform.submit(); // 앞에꺼 다 처리 완료됐으면, myform에 submit! -> 프론트체크 모두 완료 해야함!!!
	  	}
  	}
  	
  	
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>값 전송하기(get방식)</h2>
	<!-- <form name="myform" method="get" action="../../atom/t7"> -->
	<form name="myform" method="post" action="../../test11Ok">
		name : <input type="text" name="name" value="Hong Kil Dong" class="form-control"/>
		age : <input type="number" name="age" value="25" class="form-control"/>
		<div>
			성별 : <input type="radio" name="gender" value="남자" checked />남자
						<input type="radio" name="gender" value="여자" />여자
		</div>
		<div>
			취미 : 
					<input type="checkbox" name="hobby" value="등산" />등산
					<input type="checkbox" name="hobby" value="낚시" />낚시
					<input type="checkbox" name="hobby" value="독서" />독서
					<input type="checkbox" name="hobby" value="음악감상" />음악감상
					<input type="checkbox" name="hobby" value="수영" />수영
		</div>
		<input type="button" onclick="fCheck()" value="전송" class="btn btn-success"/>
	</form>
</div>
<p><br/></p>
</body>
</html>