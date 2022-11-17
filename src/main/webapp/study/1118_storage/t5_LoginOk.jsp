<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- t5_loginOk.jsp -->

<%
String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");

if((mid.equals("admin") && pwd.equals("1234")) || (mid.equals("hkd1234") && pwd.equals("1234"))) {
	session.setAttribute("sMid", mid);
	
	int visitCnt = 0;
	
	if(application.getAttribute("aVisitCnt") == null) {
		application.setAttribute("aVisitCnt", 1); 
	// application 변수로 선언해야 모든 브라우저 공유
	// 로그인 성공해서 들어가자마자 뜰 숫자 (내가 첫번째 방문자니까 1로 두는 게 좋음)
	}
	else {
		visitCnt = (int) application.getAttribute("aVisitCnt") + 1; // 객체니까 강제캐스팅 해야함
		application.setAttribute("aVisitCnt", visitCnt); 
	}
	
	out.print("<script>");
	out.print("alert('"+mid+"님 로그인 되셨습니다. 환영합니다!');");
	out.print("location.href='t5_LoginMember.jsp'");
	out.print("</script>");
}
else {
	out.print("<script>");
	out.print("alert('아이디와 비밀번호를 확인하세요!');");
	out.print("history.back();");
	out.print("</script>");
}
%>