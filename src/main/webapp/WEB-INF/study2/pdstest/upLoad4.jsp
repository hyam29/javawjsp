<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>upload4.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	
  	function fCheck() {
  		let fName = $("#fName").val();
  		let maxSize = 1024 * 1024 * 20; // 업로드 가능한 파일의 최대용량은 20MByte로 함
  		
  		if(fName.trim() == "") {
    		alert("업로드할 파일을 선택하세요.");
    		return false;
    	}
  		
  		let fileLength = document.getElementById("fName").files.length; // files만 작성시(files[]X), 전체길이 받을 수 있음. 선택한 파일의 갯수 가져옴
  		let fileSize = 0;
  		for(let i=0; i<fileLength; i++) {
  			fName = document.getElementById("fName").files[i].name; // file의 이름 가져옴
	  		let ext = fName.substring(fName.lastIndexOf(".")+1); // 확장자 발췌
	  		let uExt = ext.toUpperCase();
  			if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JEPG" && uExt != "ZIP" && uExt != "HWP" && uExt != "PPT" && uExt != "PPTX") {
	  			alert("업로드 가능한 파일확장자는 'JPG, GIF, PNG, JEPG, ZIP, HWP, PPT, PPTX' 입니다.'");
	  			return false;
  			}
	  		fileSize += document.getElementById("fName").files[i].size; // 파일용량 누적
  		}
  		
  		if(fileSize > maxSize) {
  			alert("업로드 가능한 파일의 최대용량은 20MByte 입니다.");
  			return false;
  		}
  		myform.submit();
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2>파일 업로드 테스트 4 (멀티파일처리3)</h2>
	<p>cos라이브러리를 이용한 파일 업로드</p>
	<p><font color="blue">여러개의 파일을 선택할 경우는 'Ctrl+클릭/Shift+클릭'하세요.</font></p>
	<hr/>
	<form name="myform" method="post" action="${ctp}/upLoad2Ok.st" enctype="multipart/form-data">
		<div>
			<input type="file" name="fName" id="fName" class="form-control-file borderless mb-2" multiple />
		</div>
			<input type="button" value="전송" onclick="fCheck()" class="btn btn-outline-secondary" />
			
			<input type="hidden" name="upLoadFlag" value="4" />
	</form>
	<hr/><br/>
	<input type="button" value="GO 다운로드폼" onclick="location.href='${ctp}/downLoad.st';" class="btn btn-outline-warning form-control" />
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>