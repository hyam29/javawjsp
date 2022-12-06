<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>upload2.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	function fCheck() {
  		let fName1 = $("#file1").val();
  		let fName2 = $("#file2").val();
  		let fName3 = $("#file3").val();
  		let ext = fName1.substring(fName1.lastIndexOf(".")+1); // 확장자 발췌
  		let uExt1 = ext.toUpperCase();
  		ext = fName2.substring(fName2.lastIndexOf(".")+1); // 확장자 발췌
  		let uExt2 = ext.toUpperCase();
  		ext = fName3.substring(fName3.lastIndexOf(".")+1); // 확장자 발췌
  		let uExt3 = ext.toUpperCase();
  		let maxSize = 1024 * 1024 * 10; // 업로드 가능한 파일의 최대용량은 10MByte로 함
  		
  		if(fName1.trim() == "" || fName2.trim() == "" || fName3.trim() == "") {
  			alert("업로드할 파일을 선택하세요.");
  			return false;
  		}
  		
  		
  		let fileSize1 = document.getElementById("file1").files[0].size; // JS 명령어 (files: 여러개의 파일)
  		if(uExt1 != "JPG" && uExt1 != "GIF" && uExt1 != "PNG" && uExt1 != "JEPG" && uExt1 != "ZIP" && uExt1 != "HWP" && uExt1 != "PPT" && uExt1 != "PPTX") {
  			alert("업로드 가능한 파일확장자는 'JPG, GIF, PNG, JEPG, ZIP, HWP, PPT, PPTX' 입니다.'");
  			// return false;
  		}
  		else if(fileSize1 > maxSize) {
  			alert("업로드 가능한 파일의 최대용량은 5MByte 입니다.");
  		}
  		else {
				myform.submit();
  		}
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2>파일 업로드 테스트 2 (멀티파일처리)</h2>
	<p>cos라이브러리를 이용한 파일 업로드</p>
	<hr/>
	<form name="myform" method="post" action="${ctp}/upLoad2Ok.st" enctype="multipart/form-data">
		<div>
			파일명 
			<input type="file" name="fName1" id="file1" class="form-control-file borderless mb-2" />
			<input type="file" name="fName2" id="file2" class="form-control-file borderless mb-2" />
			<input type="file" name="fName3" id="file3" class="form-control-file borderless mb-2" />
			<input type="button" value="전송" onclick="fCheck()" class="btn btn-outline-secondary" />
		</div>
		
		<input type="hidden" name="upLoadFlag" value="2" />
	</form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>