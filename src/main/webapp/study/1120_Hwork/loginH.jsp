<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인화면</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script>
  	'ust strict';
  	
  	// 프론트 유효성 검사
  	function regexCheck() {
  		let mid = document.getElementById("mid").value;
  		let pwd = document.getElementById("pwd").value;
  		
  		let regMid = /^[A-Za-z0-9]{1,20}$/g;
  		
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
  		else {
  			myform.submit();
  		}
  	}
  	
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <form name="myform" method="post" action="${pageContext.request.contextPath}/hworkDB/LoginOkH">
    <table class="table bg-dark table-bordered text-center text-white">
      <tr>
        <td colspan="2"><font size="5">로 그 인</font></td>
      </tr>
      <tr>
        <th class="text-white">아이디</th>
        <td><input type="text" name="mid" id="mid" autofocus required class="form-control"/></td>
      </tr>
      <tr>
        <th class="text-white">비밀번호</th>
        <td><input type="password" name="pwd" id="pwd" maxlength="20" required class="form-control"/></td>
      </tr>
      <tr>
        <td colspan="2">
          <input type="button" value="로그인" onclick="regexCheck()" class="btn btn-outline-success"/> &nbsp; &nbsp;
          <input type="reset" value="다시입력" class="btn btn-outline-warning"/> &nbsp; &nbsp;
          <input type="button" value="회원가입" onclick="location.href='joinH.jsp';" class="btn btn-outline-primary"/>
        </td>
      </tr>
    </table>
  </form>
</div>
<p><br/></p>
</body>
</html>