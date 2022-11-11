<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>값 전송하기(get방식)</h2>
	<!-- <form name="myform" method="get" action="../../atom/t7"> -->
	<form name="myform" method="post" action="../../test9Ok">
		name : <input type="text" name="name" value="Hong Kil Dong" class="form-control"/>
		age : <input type="number" name="age" value="25" class="form-control"/>
		<input type="submit" value="전송" class="btn btn-success"/>
	</form>
</div>
<p><br/></p>
</body>
</html>