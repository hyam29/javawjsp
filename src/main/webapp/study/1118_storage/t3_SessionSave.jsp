<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t3_SessionSave.jsp -->

<%
	String mid = (request.getParameter("mid") == null || request.getParameter("mid") == "") ? "hkd1234" : request.getParameter("mid");
	String nickName = (request.getParameter("nickName") == null || request.getParameter("nickName") == "") ? "홍장군" : request.getParameter("nickName");
	int age = (request.getParameter("age") == null || request.getParameter("age") == "") ? 20 : Integer.parseInt(request.getParameter("age"));
	String name = (request.getParameter("name") == null || request.getParameter("name") == "") ? "홍길동" : request.getParameter("name");
	
	// session에 값 저장하기 (객체, 배열, 등 모든 걸 다 그냥 담을 수 있음)
	session.setAttribute("sMid", mid); // request 저장소와 똑같음!
	session.setAttribute("sNickName", nickName); 
	session.setAttribute("sAge", age); 
	session.setAttribute("sName", name); 
%>

<script>
	alert("${sName}님 세션 저장 완료 되었습니다!"); // 저장소 4가지는 모두 EL표기법 사용 가능
	location.href="t3_SessionMain.jsp";
</script>