<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Cookie[] cookies = request.getCookies();
	String mid = ""; // 밑에도 뿌려야하니까, 전역변수 설정

	if(cookies != null) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue(); // cMid의 값을 가져와서 변수에 담기!
				pageContext.setAttribute("mid", mid); // pageContext 저장소에 값 담음으로써 EL표기법 사용 가능
				break;
			}
		}
	} 
	
	String imsiMid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
	if(mid.equals("")) pageContext.setAttribute("mid", imsiMid);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>회원전용방</h2>
	<p><font color="blue">${mid}님 로그인 중이십니다.</font></p>
	<span>로그인 되셨어용... 여기는 제대로 만들어야 해용 view 니까용!</span>
<hr/>
<p><img src="${pageContext.request.contextPath}/images/3.jpg" width="300px" /></p>
<hr/>
<p><a href="${pageContext.request.contextPath}/study/1118_storage/t2_LoginDelete.jsp" class="btn btn-outline-warning">쿠키의 아이디삭제</a></p>
<p><a href="${pageContext.request.contextPath}/study/1118_storage/t2_LogOut.jsp?mid=${mid}" class="btn btn-outline-info">로그아웃</a></p>
<hr/>
</div>
<p><br/></p>
</body>
</html>