<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test1.jsp</title>
  <jsp:include page="../../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>회원정보</h2>
	<%-- <form name="myform" method="post" action="${pageContext.request.contextPath}/j1117/Test1Ok"> --%>
	<!-- if) 회사를 갔는데, java를 몰라서 프론트만... JSP로만 작업중이라면? (서블릿 사용XXX 회사라면!) -->
	<form name="myform" method="post" action="testF1Ok.jsp">
		<p>
			성명 : <input type="text" name="name" value="홍길동" autofocus class="form-control" />
		</p>
		<p>
			나이 : <input type="number" name="age" value="20" class="form-control" />
		</p>
		<p>
			성별 : <input type="radio" name="gender" value="남자" checked />남자
						<input type="radio" name="gender" value="여자" />여자
		</p>
		<p>
			직업 : <input type="text" name="job" value="프리랜서" class="form-control" />
		</p>
		<p>
			주소 : <input type="text" name="address" value="서울" class="form-control" />
		</p>
		<p>
			<input type="submit" value="전송" class="btn btn-info" />
		</p>
	</form>
</div>
<p><br/></p>
</body>
</html>