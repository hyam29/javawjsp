<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String mid = session.getAttribute("sMid")==null ? "" : (String) session.getAttribute("sMid");
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>memberH.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	function searchMid() {
  		let mid = prompt("찾고자 하는 아이디를 입력하세요.");
  		
  		location.href="${pageContext.request.contextPath}/hworkDB/SearchMidH?mid="+mid;
  	}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>회원전용방</h2>
	<p><font color="blue"><b>${sName}</b>님 로그인 중...</font></p>
<hr/>
<p><img src="${pageContext.request.contextPath}/images/3.jpg" width="300px" /></p>
<hr/>
<p>
	현재 보유 중인 포인트 : <font color='salmon'><b>${point}</b></font><br/>
	최종 방문일자 : <font color='lightblue'><b>${sLastDate}</b></font>
</p>
<hr/>
<!-- 방문일자 . 뒤에부분 잘라 출력하기 과제, 개별회원 조회 폼 꾸미기... 성명 입력시 특정 회원만 조회되게끔 -->

<%if(mid.equals("admin")) { %>
	<div><a href="javascript:SearchMidH()" class="btn btn-outline-success form-control m-3">개별 회원 조회 (only 관리자)</a></div>
	<div><a href="${pageContext.request.contextPath}/hworkDB/MemberListH" class="btn btn-outline-warning form-control m-3">회원 전체 조회 (only 관리자)</a></div>
<%} %>
<hr/>
	<div class="row">
	<div class="col text-center"><a href="${pageContext.request.contextPath}/hworkDB/LogOutH" class="btn btn-outline-info">로그아웃</a></div>
</div>
<hr/>
</div>
<p><br/></p>
</body>
</html>