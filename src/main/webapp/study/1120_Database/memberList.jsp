<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberList.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container text-center">
	<h2>전체 회원 리스트</h2>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>아이디</th>
			<th>비밀번호</th>
			<th>성명</th>
			<th>보유 포인트</th>
			<th>최근 방문일</th>
		</tr>
<%-- 원래 사용하던 방법은 스파게티 코드로 꺼냈음. => <% for() %> but, 저장소에 담아둔 값이라서 EL로 바로 못 꺼냄 --%>
<%-- JSTL의 forEach문 = 반복문(for문)
<c:forEach var="변수명" items="객체명" varStatus="매개변수(상태코드)"> --%>
		<c:forEach var="vo" items="${vos}" varStatus="st"> 
			<tr>
				<td>${vo.idx}</td>
				<td>${vo.mid}</td>
				<td>${vo.pwd}</td>
				<td>${vo.name}</td>
				<td>${vo.point}</td>
				<td>${vo.lastDate}</td>
			</tr>		
		</c:forEach>
		<!-- 방문일자 . 뒤에부분 잘라 출력하기 과제, 개별회원 조회 폼 꾸미기... 성명 입력시 특정 회원만 조회되게끔 -->
	</table>
	<br/>
	<div><a href="${pageContext.request.contextPath}/database/MemberMain" class="btn btn-outline-info">돌아가기</a></div>
</div>
<p><br/></p>
</body>
</html>