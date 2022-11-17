<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t5_LogOut.jsp -->

<%
	String mid = (String) session.getAttribute("sMid");
	session.invalidate();
%>

<script>
	alert("<%=mid%>님 로그아웃 되셨습니다!"); // 저장소 4가지는 모두 EL표기법 사용 가능
	location.href="t5_Login.jsp";
</script>