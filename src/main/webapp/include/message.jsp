<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<%-- <%
	String msg = (String) request.getAttribute("msg");
	String url = (String) request.getAttribute("url");
%> --%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>message.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  
  <script>
  	'use strict';
  	// EL표기법은 태그라서 순차적으로 진행. 그럼 실행이 안되므로 서버프로그램에 담아 먼저 실행위해 < % %>에 작성
  	<%-- let msg = "<%=msg%>"; 
  	let url = "<%=url%>"; --%>
  	let msg = "${msg}";
  	let url = "${url}";
  	let val = "${val}";
  	
  	// guest
  	if(msg == "guInputOk") msg = "방명록에 글이 등록되었습니다!";
  	else if(msg == "guInputNo") msg = "글 등록에 실패하였습니다.";
  	else if(msg == "adminLoginOk") msg = "관리자 인증 성공!";
  	else if(msg == "adminLoginNo") msg = "관리자 인증 실패.";
  	else if(msg == "adminLogoutOk") msg = "관리자님 로그아웃 되었습니다.";
  	else if(msg == "guDeleteOk") msg = "방명록의 글이 삭제되었습니다.";
  	else if(msg == "guDeleteNo") msg = "삭제를 취소하셨습니다.";
  	
  	// member
  	else if(msg == "loginOk") msg = val+"님 반갑습니다!";
  	else if(msg == "loginNo") msg = "로그인에 실패하였습니다.";
  	else if(msg == "memLogoutOk") msg = val+"님 로그아웃 되었습니다. 좋은하루 되세요!";
  	else if(msg == "idCheckNo") msg = "중복된 아이디 입니다.";
  	else if(msg == "nickCheckNo") msg = "중복된 닉네임 입니다.";
  	else if(msg == "memJoinOk") msg = "회원가입 되었습니다. 환영합니다!";
  	else if(msg == "memJoinNo") msg = "회원가입 실패. 입력된 정보를 확인해주세요.";
  	else if(msg == "passwordNo") msg = "기존 비밀번호가 일치하지 않습니다.";
  	else if(msg == "passwordOk") msg = "비밀번호가 변경되었습니다.";
  	else if(msg == "passwordOkNo") msg = "비밀번호 변경에 실패하였습니다.";
  	else if(msg == "passwordYes") msg = "회원정보 변경페이지로 이동합니다.";
  	else if(msg == "memUpdateOk") msg = "회원정보가 변경되었습니다.";
  	else if(msg == "memUpdateNo") msg = "회원정보 변경에 실패했습니다.";
  	
  	alert(msg);
  	if(url != "") location.href = url;
  	
  	/*
  		여기는 '메세지 컨트롤러'
  	
	  	alert("방명록에 글이 등록되었습니다!");
	  	location.href="${ctp}/guList.gu";
	  	위의 코드 두줄(안내메세지+하이퍼링크)은 쌍으로 다녀야 함!!!
	  	변수에 담으면 여러 메세지 창 띄우기 가능해서 18행부터 다시 작성
  	*/
  	
  </script>
  
</head>
<body>

</body>
</html>