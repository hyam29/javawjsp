<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memUpdatePwd.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	
  	function fCheck() {
  		let regPwd = /(?=.*[0-9a-zA-Z]).{4,24}/;
			
  		let oldPwd = document.getElementById("oldPwd").value;
  		let newPwd = document.getElementById("newPwd").value;
  		let rePwd = document.getElementById("rePwd").value;
  		
  		if(oldPwd.trim() == "") {
  			alert("기존 비밀번호를 입력하세요.");
  			document.getElementById("oldPwd").focus();
  		}
  		else if(newPwd.trim() == "") {
  			alert("변경할 비밀번호를 입력하세요.");
  			document.getElementById("newPwd").focus();
  		}
  		else if(rePwd.trim() == "") {
  			alert("변경할 비밀번호를 한번 더 입력하세요.");
  			document.getElementById("rePwd").focus();
  		}
  		else if(!regPwd.test(newPwd)) {
  			alert("비밀번호는 6~20 자리로 작성해주세요.");
  			myform.newPwd.focus();
  			return;
  		}
  		else if(newPwd != rePwd) {
  			alert("변경하실 비밀번호가 일치하지 않습니다.");
  			myform.rePwd.focus();
  		}
  		else if(oldPwd == newPwd) {
  			alert("기존 비밀번호와 변경할 비밀번호가 같습니다.");
  			myform.newPwd.focus();
  		}
  		else {
  			/* alert("비밀번호 변경이 완료되었습니다."); */
  			myform.submit();
  		}
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<form name="myform" method="post" action="${ctp}/memUpdatePwdOk.mem" class="was-validated">
		<h2 class="text-center">비밀번호 변경</h2>
		<table class="table table-bordered">
			<tr>
				<th>기존 비밀번호</th>
				<td>
					<input type="password" name="oldPwd" id="oldPwd" autofocus required class="form-control" />
		      <div class="invalid-feedback">기존 비밀번호를 입력하세요.</div>
				</td>
			</tr>
			<tr>
				<th>변경 비밀번호</th>
				<td>
					<input type="password" name="newPwd" id="newPwd" required class="form-control" />
		      <div class="invalid-feedback">변경할 비밀번호를 입력하세요.</div>
				</td>
			</tr>
			<tr>
				<th>변경 비밀번호 재입력</th>
				<td>
					<input type="password" name="rePwd" id="rePwd" required class="form-control" />
		      <div class="invalid-feedback">변경할 비밀번호를 한번 더 입력하세요.</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="비밀번호 변경" onclick="fCheck()" class="btn btn-outline-success" /> &nbsp;
					<input type="reset" value="다시입력" class="btn btn-outline-success" /> &nbsp;
					<input type="button" value="돌아가기" onclick="location.href='${ctp}/memMain.mem';" class="btn btn-outline-success" />
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>