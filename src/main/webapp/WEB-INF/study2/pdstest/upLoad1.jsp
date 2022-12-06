<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>upload1.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	function fCheck() {
  		let fName = $("#file").val();
  		let ext = fName.substring(fName.lastIndexOf(".")+1); // 확장자 발췌
  		let uExt = ext.toUpperCase();
  		let maxSize = 1024 * 1024 * 10; // 업로드 가능한 파일의 최대용량은 10MByte로 함
  		
  		if(fName.trim() == "") {
  			alert("업로드할 파일을 선택하세요.");
  			return false;
  		}
  		
  		
  		let fileSize = document.getElementById("file").files[0].size; // JS 명령어 (files: 여러개의 파일)
  		if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JEPG" && uExt != "ZIP" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX") {
  			alert("업로드 가능한 파일확장자는 'JPG, GIF, PNG, JEPG, ZIP, HWP, PPT, PPTX' 입니다.'");
  			// return false;
  		}
  		else if(fileSize > maxSize) {
  			alert("업로드 가능한 파일의 최대용량은 5MByte 입니다.");
  		}
  		else {
				/* alert("파일 전송중..."); */
				myform.submit();
  		}
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2>파일 업로드 테스트 1 (싱글파일처리)</h2>
	<p>cos라이브러리를 이용한 파일 업로드</p>
	<hr/>
	<form name="myform" method="post" action="${ctp}/upLoad1Ok.st" enctype="multipart/form-data">
		<div>
			파일명 
			<input type="file" name="fName" id="file" class="form-control-file borderless mb-2" />
			<input type="button" value="전송" onclick="fCheck()" class="btn btn-outline-secondary" />
		</div>
	</form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>