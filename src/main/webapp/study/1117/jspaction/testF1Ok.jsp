<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("utf-8"); %>
<!-- 
	필터는 서블릿에 해둔거라, 한글처리 해줘야 함! 
	제일 위의 코드는 response.setContentType("text/html; charset=utf-8"); 해당부분 코드 
	따라서, request만 추가해주면 됨
-->

<!-- 앞에서 전송된 값들을 변수에 담아보자! -->
<c:set var="name" value="${param.name}" />
<c:set var="age" value="${param.age}" />
<c:set var="gender" value="${param.gender}" />
<c:set var="job" value="${param.job}" />
<c:set var="address" value="${param.address}" />
<!-- EL 표기는 저장소인 모델에 값을 담았을 때만 사용 가능! 따라서, jsp에서의 값을 매개변수로 받을래! => param  -->

<!-- 
JSP의 core Library (사용을 위해서는 외부의 core lib 불러와야 함... (함수사용을 위해서) 
fmt(format) : 날짜, 화폐단위 뭐 이런거
functions : java의 웬만한 함수 모두 있음
sql : DAO에서 SQL 사용하는 게 더 편함 따라서 사용 잘 XXX
-> import
1.page지시자 (일반적 java파일) 
2.tag lib 불러오기 위해 주소지정(스프링에서 배움) or lib 가져오기(현재 우리가 할 방법) 
WEB-INF 폴더 안 lib 폴더에 JSTL 외부 라이브러리 넣어주기! => 사용준비 완료
현재는, tool이 나와서 업데이트 X
-->
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>testF1Ok.jsp</title>
  <jsp:include page="../../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>전송된 자료 결과 보기2</h2>
	<hr/>
	<div>
		<table class="table table-bordered">
			<tr>
				<th>성명</th>
				<td>${name}</td>  <!-- JSTL에서의 변수! (EL과 JSTL은 호환 잘됨!) -->
				<%-- <%=vo.getName()%> 원래는 이렇게 쓰는데, EL 표기법으로! => VO의 필드명과 동일!!!!! --%>
			</tr>
			<tr>
				<th>나이</th>
				<td>${age}</td> 
			</tr>
			<tr>
				<th>성별</th>
				<td>${gender}</td> 
			</tr>
			<tr>
				<th>직업</th>
				<td>${job}</td> 
			</tr>
			<tr>
				<th>주소</th>
				<td>${address}</td> 
			</tr>
		</table>
	</div>
	<hr/>
	<p><a href="${pageContext.request.contextPath}/study/1117/jspaction/test1.jsp" class="btn btn-success form-control">돌아가기</a></p>
</div>
<p><br/></p>
</body>
</html>