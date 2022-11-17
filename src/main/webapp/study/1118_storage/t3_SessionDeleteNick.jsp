<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t3_SessionDeleteNick.jsp -->
<%
	session.removeAttribute("sNickName");
%>

<script>
	alert("${sName}님의 닉네임 세션 삭제!"); // session 저장된 걸 날린 적 없으니까 그냥 둬도 사용 가능... 왜?
	location.href="t3_SessionMain.jsp";
</script>