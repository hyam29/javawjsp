<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pdsInput.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	let cnt = 1;
  	
  	/* 동적폼 위한 박스버튼 추가 */
  	function fileBoxAppend() {
  		cnt++;
  		let fileBox = "";
  		fileBox += '<div id="fBox'+cnt+'">';
  	  fileBox += '<input type="file" name="fName'+cnt+'" id="fName'+cnt+'" class="form-control-file border mb-2" style="float:left;width:85%"/>';
  		fileBox += '<input type="button" value="삭제" onclick="deleteBox('+cnt+')" class="btn btn-sm btn-outline-danger form-control ml-2 mb-2" style="width:7%"/>';
  		fileBox += '</div>';
  		$("#fileBoxAppend").append(fileBox);
  	}
  
  	/* 추가된 파일박스 삭제 */ 
  	function deleteBox(cnt) {
  		$("#fBox"+cnt).remove();
  	}
  	
  	/* 자료등록 버튼 */
  	function fCheck() {
  		let fName1 = $("#fName1").val();
		  let maxSize = 1024 * 1024 * 20;
		  let title = $("#title").val();
		  let pwd = $("#pwd").val();
  		
  		if(fName1.trim() == "") {
  			alert("업로드할 파일을 1개 이상 선택해야 합니다.");
  			return false;
  		}
  		else if(title.trim() == "") {
  			alert("업로드할 자료명을 입력하세요.")
  			return false;
  		}
  		else if(pwd.trim() == "") {
  			alert("비밀번호를 입력하세요.")
  			return false;
  		}
  		
  		/* 파일 사이즈(용량) 처리 */
  		let fileSize = 0;
		  for(let i=1; i<=cnt; i++) {
			  let imsiName = 'fName' + i;
			  let fName = document.getElementById(imsiName).value;
			  if(fName != "") {
				  fileSize += document.getElementById(imsiName).files[0].size;
				  let ext = fName.substr(fName.lastIndexOf(".")+1);
				  let uExt = ext.toUpperCase();
  				if(uExt != "JPG" && uExt != "JEPG" && uExt != "PNG" && uExt != "GIF" && uExt != "ZIP" && uExt != "PPT" && uExt != "PPTX" && uExt != "7Z" && uExt != "TXT") {
  					alert("업로드 가능한 파일은 'JPG, JEPG, PNG, GIF, ZIP, PPT, PPTX, 7z, txt'입니다.");
  					return false;
  				}
  			}
  			else {
  				alert("빈 파일박스에 파일을 선택해주세요.");
  				return false;
  			}
  		}
  		if(fileSize > maxSize) {
  			alert("업로드 가능 파일의 최대용량을 초과했습니다.(최대용량 20MByte)");
  			return false;
  		}
  		else {
  			myform.fileSize.value = fileSize; // form에서 hidden으로 넘긴 fileSize 도 함께 넘겨줌
  			myform.submit();
  		}
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<form name="myform" method="post" class="was-validated" action="${ctp}/pdsInputOk.pds" enctype="multipart/form-data">
		<h2 class="text-center">자료 등록</h2>
		<br/>
		<hr/>
		<div>
			<input type="button" value="등록파일추가" onclick ="fileBoxAppend()" class="btn btn-outline-info btn-sm mb-2" />
			<input type="file" name="fName1" id="fName1" class="form-control-file borderless mb-2" />
		</div>
		<div id="fileBoxAppend"></div>
		<div class="mb-2"><font size = "18pt"><b>올린이 ${sNickName}</b></font></div>
		<div class="mb-2">
			제목 
			<input type="text" name="title" id="title" placeholder="자료명을 입력해주세요." class="form-control" required />
		</div>
		<div class="mb-2">
			내용
			<textarea rows="4" name="content" id="content" placeholder="추가적으로 설명하고 싶은 상세내용을 작성해보세요." class="form-control"></textarea>
		</div>
		<div class="mb-2">
			분류
			<select name="part" id="part" class="form-control" >
				<option value="학습" ${part == '학습' ? 'selected' : "" }>학습</option>
				<option value="여행" ${part == '여행' ? 'selected' : "" }>여행</option>
				<option value="음식" ${part == '음식' ? 'selected' : "" }>음식</option>
				<option value="기타" ${part == '기타' ? 'selected' : "" }>기타</option>
			</select>
		</div>
		<div class="mb-2">
			공개여부
			<input type="radio" name="openSw" value="공개" checked />공개 &nbsp;&nbsp;&nbsp;
			<input type="radio" name="openSw" value="비공개" />비공개 &nbsp;&nbsp;&nbsp;
		</div>
		<div class="mb-2">
			비밀번호
			<input type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력하세요." class="form-control" style="width:25%" required />
		</div>
		<div>
			<input type="button" value="자료등록" onclick="fCheck()" class="btn btn-outline-primary" />&nbsp;
			<input type="reset" value="재작성" class="btn btn-outline-warning" />&nbsp;
			<input type="button" value="돌아가기" onclick="location.href='${ctp}/pdsList.pds?part=${part}';" class="btn btn-outline-secondary" />&nbsp;
		</div>
		
		<input type="hidden" name="listPart" value="${part}" />
		<input type="hidden" name="fileSize" />
		<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
	</form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>