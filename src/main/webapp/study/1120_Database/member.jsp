<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>member.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	function searchMid() {
  		let mid = prompt("찾고자 하는 아이디를 입력하세요.");
  		
  		location.href="${pageContext.request.contextPath}/database/SearchMid?mid="+mid;
  	}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>회원전용방</h2>
	<!-- 
	이곳을 관리자 페이지라고 생각하면, 회원가입, 가입자 조회, 정보 수정 등 모든 작업 처리(loginOk서블릿) 후 이 페이지로 와야함
	따라서, 서블릿(컨트롤러 이용)을 따로 하나 생성해주면 편함 => 업무분석
	-->
	<p><font color="blue"><b>${sName}</b>님 로그인 중...</font></p>
	<span>로그인 되셨어용... 여기는 제대로 만들어야 해용 view 니까용!</span>
<hr/>
<p><img src="${pageContext.request.contextPath}/images/3.jpg" width="300px" /></p>
<hr/>
<p>
	현재 보유 중인 포인트 : <font color='salmon'><b>${point}</b></font><br/>
	최종 방문일자 : <font color='lightblue'><b>${sLastDate}</b></font>
</p>
<hr/>
<div><a href="javascript:searchMid()" class="btn btn-outline-success form-control m-3">개별 회원 조회 (only 관리자)</a></div>
<div><a href="${pageContext.request.contextPath}/database/MemberList" class="btn btn-outline-warning form-control m-3">회원 전체 조회 (only 관리자)</a></div>
<hr/>
	<div class="row">
	<div class="col text-center"><a href="${pageContext.request.contextPath}/database/LogOut" class="btn btn-outline-info">로그아웃</a></div>
</div>
<hr/>
</div>
<p><br/></p>
</body>
</html>