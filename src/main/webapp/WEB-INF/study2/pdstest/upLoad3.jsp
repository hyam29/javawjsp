<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>upload3.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	let cnt = 1;
  	
  	/* 동적폼 위한 박스버튼 추가 */
  	function fileBoxAppend() {
  		cnt++;
  		let fileBox = "";
  		fileBox += '<div id="fBox'+cnt+'">';
  	  	fileBox += '<input type="file" name="fName'+cnt+'" id="file'+cnt+'" class="form-control-file border mb-2" style="float:left;width:85%"/>';
  		fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-outline-danger form-control ml-2 mb-2" style="width:10%"/>';
  		fileBox += '</div>';
  		$("#fileBoxAppend").append(fileBox);
  	}
  
  
  	/* 추가된 파일박스 삭제 */ 
  	function deleteBox(cnt) {
  		$("#fBox"+cnt).remove();
  	}
  	
  	/* 나머지 유효성검사 반복문 만들어서 해두기 -> upLoad4에 해둠 */
  	function fCheck() {
  		let fName1 = $("#file1").val();
  		/* let fName2 = $("#file2").val();
  		let fName3 = $("#file3").val(); */
  		let ext = fName1.substring(fName1.lastIndexOf(".")+1); // 확장자 발췌
  		let uExt1 = ext.toUpperCase();
  		/* ext = fName2.substring(fName2.lastIndexOf(".")+1);
  		let uExt2 = ext.toUpperCase();
  		ext = fName3.substring(fName3.lastIndexOf(".")+1);
  		let uExt3 = ext.toUpperCase(); */
  		let maxSize = 1024 * 1024 * 10; // 업로드 가능한 파일의 최대용량은 10MByte로 함
  		
  		/* if(fName1.trim() == "" || fName2.trim() == "" || fName3.trim() == "") { */
  		if(fName1.trim() == "") {
  			alert("업로드할 파일을 선택하세요.");
  			return false;
  		}
  		
  		
  		let fileSize1 = document.getElementById("file1").files[0].size; // JS 명령어 (files: 여러개의 파일)
  		if(uExt1 != "JPG" && uExt1 != "GIF" && uExt1 != "PNG" && uExt1 != "JEPG" && uExt1 != "ZIP" && uExt1 != "HWP" && uExt1 != "PPT" && uExt1 != "PPTX") {
  			alert("업로드 가능한 파일확장자는 'JPG, GIF, PNG, JEPG, ZIP, HWP, PPT, PPTX' 입니다.'");
  			// return false;
  		}
  		else if(fileSize1 > maxSize) {
  			alert("업로드 가능한 파일의 최대용량은 10MByte 입니다.");
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
	<h2>파일 업로드 테스트 3 (멀티파일처리의 동적폼)</h2>
	<p>cos라이브러리를 이용한 파일 업로드</p>
	<hr/>
	<form name="myform" method="post" action="${ctp}/upLoad2Ok.st" enctype="multipart/form-data">
		<div>
			<input type="button" value="파일추가" onclick ="fileBoxAppend()"	 class="btn btn-outline-info btn-sm mb-2" />
			<input type="file" name="fName1" id="file1" class="form-control-file borderless mb-2" />
		</div>
			<div id="fileBoxAppend"></div>
			<input type="button" value="전송" onclick="fCheck()" class="btn btn-outline-secondary" />
			
			<input type="hidden" name="upLoadFlag" value="3" />
	</form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>