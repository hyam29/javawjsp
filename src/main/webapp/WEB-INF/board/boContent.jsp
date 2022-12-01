<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boContent.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	function goodCheck() {
  		$.ajax({
  			type: "post",
  			url: "${ctp}/boGood.bo",
  			data: {idx : ${vo.idx}},
  			success: function() {
  				location.reload();
  			},
  			error: function() {
  				alert("좋아용 전송 오류");
  			}
  		});
  	}
  	 /* data : idx는 int라서 그냥 작성! String이라면, idx: "$ { vo . 변수명}" 따옴표 꼭 필요!!!!!!! */
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="text-center">글 내 용 보 기</h2>
	<hr/>
	<br/>
	<table class="table table-borderless">
		<tr>
			<td class="text-right">hostIp : ${vo.hostIp}</td>
		</tr>
	</table>
	<table class="table table-bordered">
		<tr>
			<th>글쓴이</th>
			<td>${vo.nickName}</td>
			<th>작성일</th>
			<td>${vo.wDate}</td>
		</tr>
		<tr>
			<th>글제목</th>
			<td colspan="3">${vo.title}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${vo.email}</td>
			<th>조회수</th>
			<td>${vo.readNum}</td>
		</tr>
		<tr>
			<th>홈페이지(블로그)</th>
			<td>${vo.homePage}</td>
			<th>좋아용</th>
			<td><a href="javascript:goodCheck()">💟	</a> ${vo.good} , 👍🏻 👎🏻 </td> <!-- 좋아요는 동일페이지에서 변경돼야 하므로 ajax 사용해야함. -->
		</tr>
		<tr>
			<th>글내용</th>
			<td colspan="3" style="height:220px">${vo.content}</td>
		</tr>
		<tr>
			<td colspan="4" class="text-center">
				<input type="button" value="글 목록보기" onclick="location.href='${ctp}/boList.bo?pageSize=${pageSize}&pag=${pag}';" class="btn btn-outline-secondary" />
			</td>
		</tr>
	</table>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>