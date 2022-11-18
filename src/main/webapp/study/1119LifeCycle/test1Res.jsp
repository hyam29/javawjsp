<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test1Res.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>JSP/Servlet Life Cycle 연습(test1Res.jsp)</h2>
	<form name="myform" method="post" action="${pageContext.request.contextPath}/1119/LifeCycle">
		<table class="table">
			<tr>
				<th>제 목</th>
				<td>${title}</td>
			</tr>
			<tr>
				<td>내 용</td>
				<td>${content}</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="돌아가기" onclick="location.href='${pageContext.request.contextPath}/study/1119LifeCycle/test1.jsp';" class="btn btn-outline-secondary form-control" />
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
</body>
</html>