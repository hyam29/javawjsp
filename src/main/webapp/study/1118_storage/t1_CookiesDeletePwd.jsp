<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t1_CookiesDeletePwd.jsp -->
<%
	//if) 특정 쿠키만 삭제하고 싶다면? 읽어온 쿠키명을 if조건문으로 설정하면 됨 (=> null 유효성검사 필수)
	Cookie[] cookies = request.getCookies();

	if(cookies != null) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cPwd")) {
				cookies[i].setMaxAge(0); 
				response.addCookie(cookies[i]);
			}
		}
	}
%>

<script>
	alert("내가 만든 쿠키 비밀번호 삭제 완료!");
	location.href="t1_CookiesMain.jsp";
</script>
