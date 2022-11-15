<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- input.jsp -->

<script>
	'use strict';
	let addTbl;

	function insRow() {
  	addTbl = document.getElementById("addTable");
  	let addRow = addTbl.insertRow();
  	addRow.onmouseover = function () { 
    	addTbl.clickedRowIndex = this.rowIndex; 
  	}
  
  	let addCell = addRow.insertCell(); 

	  let formTag = "";
	  formTag += ' 상품 <input type="text" name="product" id="product" required />';
	  formTag += ' 수량 <input type="text" name="su" id="su" />';
	  formTag += ' 가격 <input type="text" name="price" id="price" />';
	  formTag += ' <input type="button" value="삭제" onclick="removeRow()" class="btn-sm btn-outline-danger" />';

 		addCell.innerHTML = formTag;
	}

// 추가된 행(table)을 삭제
	function removeRow() {
  	addTable.deleteRow(addTbl.clickedRowIndex);
	}
  

	function fCheck() {
    let regSu = /[0-9]/g;
    let regPrice = /[0-9]/g;
    
    let product = document.getElementById("product").value;
    let su = document.getElementById("su").value;
    let price = document.getElementById("price").value;
      
    if(product == "") {
	    alert("첫번째 상품은 꼭 등록하셔야 주문이 완료됩니다.");
	    document.getElementById("product").focus;
	    return;
    }
    if(!regSu.test(su)) {
      alert("수량은 숫자만 입력 가능합니다.");
      document.getElementById("su").focus;
      return;
    }
    if(!regPrice.test(price)) {
      alert("가격은 숫자만 입력 가능합니다.");
      document.getElementById("price").focus;
      return;
    }
    else {
      myform.submit();
    }
  }
</script>

<div class="container">
	<h2>상품 등록 *'-'*</h2>
	<hr/>
		<form name="myform" method="post" action="<%=request.getContextPath()%>/j1116h/InputOk">
    	<table class="table">
        <tr>
	        <td>
	        	구매자명 <input type="text" name="name" id="name" value="길동쓰" class="form-control" required/>
	        </td>
        </tr>
        <tr>
          <td>
            상품분류
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
          <td><input type="button" value="상품추가" onclick="insRow()" class="btn btn-outline-info form-control"/></td>
        </tr>
        <tr>
          <td>
            <table id="addTable">
              <tr>
                <td>
                  상품 <input type="text" name="product" id="product" required />
                  수량 <input type="text" name="su" id="su" />
                  가격 <input type="text" name="price" id="price" />
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br/>
      <table class="table">
        <tr>
	        <td><input type="button" value="상품등록" onclick="fCheck()" class="btn btn-outline-primary form-control m-2" /></td>
	        <td><input type="reset" value="취소" class="btn btn-outline-danger form-control m-2" /></td>
	        <td><input type="button" value="새로고침" onclick="location.reload()" class="btn btn-outline-warning form-control m-2" /></td>
        </tr>
      </table>
    </form>
	<hr/>
	<p>행복한 시간 되세요 *'-'*</p>
</div>
