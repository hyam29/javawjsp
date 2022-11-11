<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test4.jsp</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
</head>
<body>
<p><br/></p>
<div class="container">
	<%! //  % ! : jsp 변수 선언부를 뜻함 
		public int hap(int su1, int su2) {
			return su1 + su2;  
		}   
	%>
	<h2>두 수의 합</h2>
	<%
		int hap = hap(10,20);
		out.println("두수의 합은 <b>"+hap+"</b> 입니다.<br/>");
		
	%>
</div>
<p><br/></p>
</body>
</html>