<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t2_LogingMember.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>회원전용방</h2>
	<p><font color="blue">${sMid}님 로그인 중이십니다.</font></p>
	<span>로그인 되셨어용... 여기는 제대로 만들어야 해용 view 니까용!</span>
<hr/>
<p><img src="${pageContext.request.contextPath}/images/3.jpg" width="300px" /></p>
<hr/>
<div>
	<a href="${pageContext.request.contextPath}/study/1118_storage/t2_LoginDelete.jsp" class="btn btn-outline-warning">쿠키의 아이디삭제</a>
	<a href="${pageContext.request.contextPath}/study/storage/T2_LogOut" class="btn btn-outline-info">로그아웃</a>
</div>
<hr/>
</div>
<p><br/></p>
</body>
</html>