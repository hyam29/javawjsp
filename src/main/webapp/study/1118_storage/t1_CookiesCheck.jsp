<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t1_CookiesCheck.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>쿠키 확인! 내가 만든 쿠키~~~*'-'*</h2>
	<hr/>
<!-- 나중에 MVC 패턴으로 변경하기 -->
<!-- 쿠키는 여러개 오기 때문에, 배열로 (배열이니까 자동으로 s 붙음) import 없음 => JSP내장객체 -> 사용이 편함 (서블릿은 XXX 따라서 경로 다 작성해야 함) -->
<!-- 테이블 디자인은 알아서 상상해야 함! -->
<%
	Cookie[] cookies = request.getCookies();

	out.println("<table class='table table-hover text-center'>");
	out.println("<tr class='table-dark'><th>번호</th><th>저장된 쿠키명</th><th>저장된 쿠키 값</th></tr>");
	for(int i=0; i<cookies.length; i++) {
		out.println("<tr>");
		String strName = cookies[i].getName(); 		// .getName(); : 쿠키명(저장시켜놓은 쿠키변수명) 가져오기
		String strValue = cookies[i].getValue(); 	// .getValue(); 쿠키값(저장시켜놓은 쿠키값) 가져오기
		out.println("<td>"+(i+1)+"</td>");
		out.println("<td>"+strName+"</td>");
		out.println("<td>"+strValue+"</td>");
		out.println("</tr>");
	}
	out.println("</table>");
%>

<!-- 브라우저를 open 시 무조건 하나는 실행되는 데 => session (저장된 쿠키 없어도 session 값 하나는 출력) -->
<hr/>
<div>
	<a href="t1_CookiesMain.jsp" class="btn btn-secondary form-control">돌아가기</a>
</div>
</div>
<p><br/></p>
</body>
</html>