<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("utf-8"); %>

<%-- <c:set var="name" value="${param.name}" />
<c:set var="age" value="${param.age}" />
<c:set var="gender" value="${param.gender}" />
<c:set var="job" value="${param.job}" />
<c:set var="address" value="${param.address}" /> --%>

<!-- 자바 클래스(VO)를 사용하여 넘어온 값들을 저장하고자 한다. -->
<!-- 자바클래스는 jsp액션태그(jsp:useBean)를 사용! -> HTML할 때 계속 사용하니까 잘 봐두기!!! (in HTML class = Bean) -->
<%-- <jsp:useBean id="vo" class="j1117.Test1VO"></jsp:useBean> --%>
<jsp:useBean id="vo" class="j1117.Test1VO" /> <!-- 상동 -->
	<!-- 
	Test1VO vo = new Test1VO (java에서 객체 생성)
	vo => id="vo"
	new Test1VO => class="j1117.Test1VO"
	class는 경로명과 함께 적는 것이 좋음 
	-->

<!-- 생성된 클래스에 값을 넣을 때 : jsp:setProperty -->
<!-- name="class의 id(vo)" property="변수명" -->
<%-- <jsp:setProperty property="age" name="vo"/>
<jsp:setProperty property="gender" name="vo"/>
<jsp:setProperty property="job" name="vo"/>
<jsp:setProperty property="address" name="vo"/> --%>

<jsp:setProperty property="*" name="vo"/>
<!-- form name = VO name = property name => property에 * 넣어도 OK!!! -->

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>testF2Ok.jsp</title>
  <jsp:include page="../../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>전송된 자료 결과 보기3</h2>
	<hr/>
	<div>
		<table class="table table-bordered">
			<tr>
				<th>성명</th>
				<!-- 생성된 클래스에 값을 꺼낼 때 : jsp:getProperty -->
				<td>${name} / <jsp:getProperty property="name" name="vo"/> </td>  <!-- JSTL에서의 변수! (EL과 JSTL은 호환 잘됨!) -->
				<%-- <%=vo.getName()%> 원래는 이렇게 쓰는데, EL 표기법으로! => VO의 필드명과 동일!!!!! --%>
			</tr>
			<tr>
				<th>나이</th>
				<td>${age} / <jsp:getProperty property="age" name="vo"/> </td> 
			</tr>
			<tr>
				<th>성별</th>
				<td>${gender} / <jsp:getProperty property="gender" name="vo"/> </td> 
			</tr>
			<tr>
				<th>직업</th>
				<td>${job} / <jsp:getProperty property="job" name="vo"/> </td> 
			</tr>
			<tr>
				<th>주소</th>
				<td>${address} / <jsp:getProperty property="address" name="vo"/> </td> 
			</tr>
		</table>
	</div>
	<hr/>
	<p><a href="${pageContext.request.contextPath}/study/1117/jspaction/test2.jsp" class="btn btn-success form-control">돌아가기</a></p>
</div>
<p><br/></p>
</body>
</html>