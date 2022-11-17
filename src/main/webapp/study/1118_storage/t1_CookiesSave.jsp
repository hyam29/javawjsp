<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t1_CookiesSave.jsp -->
<!-- 쿠키는 저장만 하면 되니까 뷰 따로 필요 XXX ->JSP에 뷰가 필요없다면 디자인 부분(템플릿) 다 지우기!!! -->
<%
	//쿠키는 기본생성자만 생성하면 error
	String mid = "hkd1234";
	Cookie cookieMid = new Cookie("cMid", mid); 
	// => 생성할 때 name, value 같이 있어야 함! Cookie("쿠키의변수명(해당쿠키값의변수명)", "쿠키값")
	// 앞으로 우리끼리 약속 -> 변수명에서 mid만 작성시, 헷갈리니까 c(cookie), s(session) 등으로 앞 문자 붙이고 mid 붙이기!
	cookieMid.setMaxAge(60*60*24); 
	// .setMaxAge() : 쿠키의 생명주기(만료시간) : 단위 '초', 1일(60*60*24) -> 일반적인 java의 초(1/1000)XXX 여기서는 1초는 그냥 1초!!!
	// 쿠키를 지우지 않으면, 용량이 계속해서 늘어남
	
	String pwd = "1234";
	Cookie cookiePwd = new Cookie("cPwd", pwd);
	cookiePwd.setMaxAge(60*60*24);
	
	String job = "학생";
	Cookie cookieJob = new Cookie("cJob", job);
	cookieJob.setMaxAge(60*60*24);
	
	
	// 쿠키를 클라이언트에 저장하기(즉, 사용자 컴퓨터에 저장된다.)
	response.addCookie(cookieMid);
	response.addCookie(cookiePwd);
	response.addCookie(cookieJob);
%>
<script>
	alert("쿠키 저장 완료!");
	location.href="t1_CookiesMain.jsp";
</script>