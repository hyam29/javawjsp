<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t1_CookiesDelete.jsp -->

<%
	Cookie[] cookies = request.getCookies();

	if(cookies != null) {
		for(int i=0; i<cookies.length; i++) {
			cookies[i].setMaxAge(0); // 쿠키의 만료시간을 0으로 설정 = 모든 쿠키 제거
					
			// 사용자 컴퓨터에서 저장된(위에서 이미삭제된쿠키)쿠키 add 하면 사용자 컴퓨터에서도 삭제된 쿠키 저장
			response.addCookie(cookies[i]);
		}
	}
%>

<script>
	alert("내가 만든 쿠키 삭제 완료!");
	location.href="t1_CookiesMain.jsp";
</script>