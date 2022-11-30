<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>userList.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	function userSearch(mid) {
  		$.ajax({
  			type	: "post",
  			url		: "${ctp}/userSearch.st", 
  			data	: {mid: mid},
  			success : function(res) {
  				let str = res.split("/");
    			$("#mid").val(str[1]);
    			$("#name").val(str[2]);
    			$("#age").val(str[3]);
    			$("#address").val(str[4]);
  				
  			},
  			error	: function() {
  				alert("전송 실패.");
  			}
  		});
  	}
  	function userDel(mid) {
  		$.ajax({
  			type	: "post",
  			url		: "${ctp}/userDel.st", 
  			data	: {mid: mid},
  			success : function(res) {
  				if(res == "1") {
  				alert("회원 삭제가 완료되었습니다.");
  				location.reload();
  				}
  			},
  			error	: function() {
  				alert("삭제가 실패되었습니다.");
  			}
  		});
  	}
  	
  	
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2>AJax 연습</h2>
	<hr/>
	<form> <!-- ajax 사용은 현재 페이지 내에서 하므로 method, action이 필요없음 -->
		<table class="table table-bordered">
			<tr>
				<th colspan="2" class="text-center"><h3>User '가입/수정' Form</h3></th>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" name="mid" id="mid" class="form-control" /></td>
			</tr>
			<tr>
				<th>성명</th>
				<td><input type="text" name="name" id="name" class="form-control" /></td>
			</tr>
			<tr>
				<th>나이</th>
				<td><input type="text" name="age" id="age" class="form-control" /></td>
			</tr>
			<tr>
				<th>주소</th>
				<td><input type="text" name="address" id="address" class="form-control" /></td>
			</tr>
			<tr>
				<td colspan="2" class="text-center">
					<input type="button" value="유저등록" onclick="userInput()" class="btn btn-outline-primary" />
					<input type="reset" value="재입력" class="btn btn-outline-warning" />
					<input type="button" value="유저수정" onclick="userUpdate()" class="btn btn-outline-success" />
					<input type="button" value="전체조회" onclick="location.href='${ctp}/userList.st';" class="btn btn-outline-info" />
				</td>
			</tr>
		</table>
	</form>
	<hr/>
	<h3>전체 리스트</h3>
	<br/>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>아이디</th>
			<th>성명</th>
			<th>나이</th>
			<th>주소</th>
			<th>비고</th>
		</tr>
		<c:forEach var="vo" items="${vos}" >
			<tr>
				<td>${vo.idx}</td>
			<td>${vo.mid}</td>
			<td>${vo.name}</td>
			<td>${vo.age}</td>
			<td>${vo.address}</td>
				<td>
					<a href="javascript:userSearch('${vo.mid}')" class="btn btn-outline-success">개별조회</a>
					<a href="javascript:userDel('${vo.mid}')" class="btn btn-outline-danger">삭제</a>
				</td>
			</tr>
		</c:forEach>
		<tr><td colspan="6" class="m-0 p-0"></td></tr>
	</table>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>