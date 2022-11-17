<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t3_SessionDeleteAll.jsp -->
<%
	String imsiName = (String) session.getAttribute("sName"); // String으로 강제 타입변환 해야함!!!
	pageContext.setAttribute("imsiName", imsiName);
	
	session.invalidate(); // 현재 저장된 모든 세션 삭제
%>

<script>
	alert("${imsiName}님의 모든 세션 삭제 완!!!"); // session 저장된 걸 날린 적 없으니까 그냥 둬도 사용 가능... 왜?
	location.href="t3_SessionMain.jsp";
</script>