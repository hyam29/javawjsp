<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	Cookie[] cookies = request.getCookies();

	String mid = ""; // 밑에도 뿌려야하니까, 전역변수 설정

	if(cookies != null) {
		for(int i=0; i<cookies.length; i++) {
			if(cookies[i].getName().equals("cMid")) {
				mid = cookies[i].getValue(); // cMid의 값을 가져와서 변수에 담기!
				pageContext.setAttribute("mid", mid); // pageContext 저장소에 값 담음으로써 EL표기법 사용 가능
				break;
			}
		}
	} 
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t2_Login.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<form name="myform" method="post" action="${pageContext.request.contextPath}/study/storage/T2_LoginOk">
		<table class="table table-hover table-bordered text-center">
			<tr>
				<th class="table-dark" colspan="3" style="font-size:1.5em;">로 그 인</th>
			</tr>
			<tr>
				<th><label for="mid">아이디</label></th>
				<td>
					<input type="text" name="mid" id="mid" value="<%=mid%>" autofocus placeholder="아이디 입력" class="form-control"/>
				</td>
				<td rowspan="2" style="text-align:center;">
					<input type="checkbox" name="rememMid" id="rememMid" style="font-size:1.5em;" checked />아이디 기억하기
				</td>
			</tr>
			<tr>
				<th><label for="pwd">비밀번호</label></th>
				<td><input type="password" name="pwd" id="pwd" placeholder="비밀번호 입력" class="form-control"/></td>
			</tr>
			<tr>
				<td colspan="3" class="table-dark">
					<input type="submit" value="로그인" class="btn btn-outline-info"/>&nbsp;&nbsp;
					<input type="reset" value="취소" class="btn btn-outline-warning"/>
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
</body>
</html>