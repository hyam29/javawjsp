<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>nickNameCheck.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	let openJoinMyForm = opener.document.myform;
  	
  	// 중복 닉네임 재검색
  	function nickNameCheck() {
  		let nickName = childForm.nickName.value;
  		
  		if(nickName.trim() == "") {
  			alert("닉네임을 입력하세요.")
  			childForm.nickName.focus();
  		}
  		else {
  			childForm.submit();
  		}
  	}
  	
  	// 최종 닉네임 부모form에 전달하기 (opener : 부모페이지 여는 명령어)
  	function sendCheck() {
  		/* opener.window.document.myform.nickName.value = '${nickName}'; 
  		opener.window.document.myform.name.focus();
  		window.close(); */
  		
  		openJoinMyForm.nickDuplication.value="nickCheck";
  		openJoinMyForm.nickNameBtn.disabled=true;
  		openJoinMyForm.nickNameBtn.style.opacity=0.6;
  		openJoinMyForm.nickNameBtn.style.cursor="default";
  		opener.window.document.myform.nickName.value	= '${nickName}'; 
  		opener.window.document.myform.name.focus();
  		window.close();
  	}
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
	<h3>닉네임(별명) 중복확인</h3>
	<c:if test="${nickRes == 1}">
		<h4>입력하신 <font color="blue"><b>${nickName}</b></font>은(는) 사용가능합니다.</h4>
		<p><input type="button" value="닉네임(별명) 사용하기" onclick="sendCheck()" /></p>
	</c:if>
	<c:if test="${nickRes != 1}">
		<h4><font color="red"><b>${nickName}</b></font>은(는) 이미 사용중인 닉네임입니다.</h4>
		<form name="childForm" method="post" action="${ctp}/nickNameCheck.mem">
			<p>
				<input type="text" name="nickName" /> <!-- 동일한 mid name을 넣어야 함 -->
				<input type="button" value="재검색" onclick="nickNameCheck()" />
			</p>
		</form>
	</c:if>
</div>
</body>
</html>