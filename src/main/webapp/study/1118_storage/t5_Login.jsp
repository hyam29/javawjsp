<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>t5_Login.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<form name="myform" method="post" action="t5_LoginOk.jsp">
		<h2 style="text-align:center;">로 그 인</h2>
		<table class="table table-bordered text-center">
			<tr>
				<th>아이디</th>
				<%-- <td><input type="text" name="mid" id="mid" value="<%=mid %>" autofocus placeholder="아이디 입력" class="form-control"/></td> --%>
				<td><input type="text" name="mid" id="mid" value="hkd1234" autofocus placeholder="아이디 입력" class="form-control"/></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="pwd" id="pwd" value="1234" placeholder="비밀번호 입력" class="form-control"/></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="로그인" class="btn btn-outline-primary"/>&nbsp;&nbsp;
					<input type="reset" value="취소" class="btn btn-outline-danger"/>
				</td>
			</tr>
		</table>
	</form>
</div>
<p><br/></p>
</body>
</html>