<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memIdCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	
  	// 중복 아이디 재검색
  	function idCheck() {
  		let mid = childForm.mid.value;
  		
  		if(mid.trim() == "") {
  			alert("아이디를 입력하세요.")
  			childForm.mid.focus();
  		}
  		else {
  			childForm.submit();
  		}
  	}
  	
  	// 최종 아이디 부모form에 전달하기 (opener : 부모페이지 여는 명령어)
  	function sendCheck() {
  		opener.window.document.myform.mid.value	= '${mid}'; 
  		opener.window.document.myform.pwd.focus();
  		window.close();
  	}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h3>아이디(ID) 중복확인</h3>
	<c:if test="${res == 1}">
		<h4><font color="blue"><b>${mid}</b></font>아이디는 사용가능합니다.</h4>
		<!-- <p><input type="button" value="닫기" onclick="windows.close()" /></p> window.close() 사용하면, 중복이 안된다면 괜찮지만, 다시 검색할 경우 처음 아이디가 부모form에 계속 저장되어 있음 -->
		<p><input type="button" value="아이디(ID) 사용하기" onclick="sendCheck()" /></p>
	</c:if>
	<c:if test="${res != 1}">
		<h4><font color="red"><b>${mid}</b></font>은(는) 이미 사용중인 아이디입니다.</h4>
		<form name="childForm" method="post" action="${ctp}/memIdCheck.mem">
			<p>
				<input type="text" name="mid" /> <!-- 동일한 mid name을 넣어야 함 -->
				<input type="button" value="재검색" onclick="idCheck()" />
			</p>
		</form>
	</c:if>
</div>
</body>
</html>