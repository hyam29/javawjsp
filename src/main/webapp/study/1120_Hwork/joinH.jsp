<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>joinH.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
  <script>
  	'use restrict';
  	
	 	// 폼의 내용을 가져와서 유효성 검사! (아이디, 비밀번호, 성명은 모두 20자 이하 조건 달기)
  	function fCheck() {
  		
  		let mid = document.getElementById("mid").value;
  		let pwd = document.getElementById("pwd").value;
  		let name = document.getElementById("name").value;
  		
  		let regMid = /^[A-Za-z0-9]{1,20}$/g;
  		let regName = /^[a-zA-Z가-힣]{1,20}$/g;
  		
  		if(mid.trim() == "") {
  			alert("아이디를 입력해주세요.");
  			document.getElementById("mid").focus();
  			return;
  		}
  		else if(!regMid.test(mid)) {
  			alert("아이디는 20자리 이하의 영문 대/소문자, 숫자, _ 만 입력가능 합니다!")
  			return;
  		}
  		else if(pwd.trim() == "") {
	      alert("비밀번호를 입력해주세요.")
	      document.getElementById("pwd").focus();
	      return;
  	  }
  		else if(pwd.length > 21) {
	      alert("비밀번호는 최대 20자까지 입력가능 합니다!")
	      document.getElementById("pwd").focus();
	      return;
  	  }
  		else if(name.trim() == "") {
	      alert("성명을 입력해주세요.")
	      document.getElementById("name").focus();
	      return;
  	  }
  		else if(!regName.test(name)) {
	      alert("성명을 올바르게 입력해주세요! (최대 20자)")
	      document.getElementById("name").focus();
	      return;
  	  }
  		else {
  			myform.submit();
  		}
  	}
  </script>
  
</head>
<body>
<p><br/></p>
<div class="container text-center">
	<h2>회 원 가 입</h2>
	<form name="myform" method="post" action="${pageContext.request.contextPath}/hworkDB/JoinOkH">
		<table class="table text-center">
			<tr>
				<th>아이디</th>
				<td><input type="text" name="mid" id="mid" required class="form-control" /></td>
				<%-- <td><input type="button" value="중복확인" onclick="${pageContext.request.contextPath}/study/1120_Hwork/joinMidCheck.jsp';" class="btn btn-outline-secondary form-control" /></td> --%>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" id="pwd" required class="form-control" /></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type="text" name="name" id="name" required class="form-control" /></td>
			</tr>
			<tr>
				<td colspan="2" style="text-align:center">
					<input type="button" value="회원가입" onclick="fCheck()" class="btn btn-outline-info mr-3" />
					<input type="reset" value="다시입력" class="btn btn-outline-danger mr-3" />
					<input type="button" value="돌아가기" onclick="location.href='${pageContext.request.contextPath}/study/1120_Hwork/loginH.jsp';" class="btn btn-outline-success" />
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
</body>
</html>