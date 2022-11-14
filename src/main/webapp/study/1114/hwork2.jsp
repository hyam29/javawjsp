<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>title</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script>
  	'use strict';
  	
  	function fCheck() {
  		let product1 = document.getElementById("product1").value;
  		
  		if(product1 == "") {
  			alert("첫번째 상품은 꼭 등록하셔야 주문이 완료됩니다.");
  			document.getElementById("product1").focus;
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
	<h2 style="text-align: center;">상 품 등 록</h2>
	<form name="myform" method="post" action="<%=request.getContextPath()%>/j1114_hworkOk">
	<table>
		<tr>
			<td>구매자명</td>
			<td><input type="text" name="name" id="name" value="길동쓰" class="form-control" required/></td>
		</tr>
		<tr>
			<td>상품분류</td>
			<td>
				<select name="productCode" id="productCode" class="form-control">
					<option>의류</option>
					<option>잡화</option>
					<option>가구</option>
					<option>전자제품</option>
					<option>식품</option>
					<option>반려동물제품</option>
					<option>기타</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2"><input type="button" value="상품추가" onclick="inputProd()" class="btn btn-outline-info form-control"/></td>
		</tr>
		<tr>
			<td></td>
		</tr>
		<tr>
			<td></td>
		</tr>
	</table>
	
	
	
	
	
	
	
	
	
	
	
	
	
		
		<p>
		 
				
		</p>
		<p><input type="button" value="상품추가" onclick="inputProd()" class="btn btn-outline-info form-control"/></p>
		<p>상품 <input type="text" name="product" id="product" class="form-control" required></p>
		<p>수량 <input type="number" name="su" id="su" class="form-control" min="1" value="1" /></p>
		<p>가격 <input type="text" name="price" id="price" class="form-control"></p>
		<p>
			<input type="button" value="상품등록" onclick="fCheck()" class="btn btn-outline-primary form-control m-2" />
			<input type="reset" value="취소" class="btn btn-outline-danger form-control m-2" />
		</p>
	</form>
</div>
<p><br/></p>
</body>
</html>