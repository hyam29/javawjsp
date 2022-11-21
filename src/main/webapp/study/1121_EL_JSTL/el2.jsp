<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>el2.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h3>form값을 통해 전달받은 배열 값들의 처리</h3>
	<p>
		선택한 취미 
		${hobbys[0]} / ${hobbys[1]} / ${hobbys[2]} / ${hobbys[3]} / ${hobbys[4]} / 
	</p>
	<h5>forEach문을 활용한 배열 값 출력</h5>
	<c:forEach var="hobby" items="${hobbys}" varStatus="st">
		${hobby} / 
	</c:forEach>
	<hr/>
	<p>
		<a href="${ctp}/study/1121_EL_JSTL/form2.jsp" class="btn btn-outline-secondary">돌아가기</a>
	</p>
</div>
<p><br/></p>
</body>
</html>