<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memMain.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2>회원 정보 및 설정</h2>
	<hr/>
	<p><font color="salmon"><b>${sNickName}</b></font>님 반갑습니다!</p>
	<p>현재 회원님의 등급은 "<font color="lightsalmon"><b>${strLevel}</b></font>" 입니다.</p>
	<!-- 아래 4개 DB에서 찾아서 커맨드객체에서 session에 담아서 여기에 뿌려줌 -->
	<p>회원님의 보유 포인트 : ${point}</p>
	<p>최종 접속일 : ${lastDate}</p>
	<p>총 방문횟수 : ${visitCnt}</p>
	<p>오늘 방문횟수 : ${todayCnt}</p>
	
	<h4>활동 내역</h4>
	<p>방명록에 올린 글 수 : </p>
	<p>게시판에 올린 글 수 : </p>
	<p>자료실에 올린 글 수  : </p>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>