<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberSearchH.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>개별 회원 조회</h2>
	<table class="table table-bordered">
		<tr>
			<th>번호</th>
			<td>${vo.idx}</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${vo.mid}</td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<td>${vo.pwd}</td>
		</tr>
		<tr>
			<th>성명</th>
			<td>${vo.name}</td>
		</tr>
		<tr>
			<th>보유 포인트</th>
			<td>${vo.point}</td>
		</tr>
		<tr>
			<th>최근 방문일</th>
			<td>${sLastDate}</td>
		</tr>
	</table>
	<br/>
	<div><a href="${pageContext.request.contextPath}/hworkDB/MemberMainH" class="btn btn-outline-info">돌아가기</a></div>
	
</div>
<p><br/></p>
</body>
</html>