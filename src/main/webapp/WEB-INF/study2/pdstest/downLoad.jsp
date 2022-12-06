<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>downLoad.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	function fileDelete(file) {
  		let ans = confirm("해당 파일을 삭제하시겠습니까?");
  		
  		if(!ans) return false;
  		
  		$.ajax({
  			type 		: "post",
  			url 		: "${ctp}/fileDelete.st",
  			data 		: {file : file},
  			success : function(res) {
  				if(res == "1") {
  					alert("파일이 삭제되었습니다.");
  					location.reload();
  				}
  				else {
  					alert("파일 삭제 실패");
  				}
  			},
  			error 	: function() {
  				alert("삭제 처리 전송 실패.");
  			}
  		});
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2>서버에 저장된 파일목록</h2>
	<p>${ctp}/data/pdstest/*.*</p>
	<hr/>
	<table class="table table-hover test-center">
		<tr>
			<th>번호</th>
			<th>파일명</th>
			<th>파일형식</th>
			<th>비고</th>
		</tr>
		<c:forEach var="file" items="${files}" varStatus="st">
			<tr>
				<td>${st.count}</td>
				<td><a href="${ctp}/data/pdstest/${file}" download="${file}">${file}</a></td>
				<!-- download 명령어 : 프론트를 위한 속성으로, 바로 다운로드 가능해지게끔 만들어주는 명령어
				 but, 파일명이 중복된 경우 서버에는 자동으로 파일명이 변경되어 있음. (atom, atom1)
				 atom을 받았는데 atom1이 다운받아지므로 이러한 경우는 java로 직접 작성해야함 -->
				<td>
					<c:set var="fNameArr" value="${fn:split(file, '.')}"></c:set>
					<c:set var="extName" value="${fn:toLowerCase(fNameArr[fn:length(fNameArr)-1])}"></c:set>
					<!-- fNameArr : 확장자명을 발췌하기 위해 . 을 기준으로 split -->
					<!-- [fn:length(fNameArr)-1] : 인덱스번호 -->
					<c:if test="${extName == 'zip'}">압축파일</c:if>
					<c:if test="${extName == 'ppt' || extName == 'pptx'}">파워포인트파일</c:if>
					<c:if test="${extName == 'jpg' || extName == 'png' || extName == 'gif' || extName == 'jpeg'}">그림파일
						<img src="${ctp}/data/pdstest/${file}" width="150px" />
					</c:if>
					: (${extName})
				</td>
				<td>
					<a href="">다운로드</a> /
					<a href="javascript:fileDelete('${file}')">삭제(ajax)</a>
				</td>
			</tr>
		</c:forEach>
		<tr><td colspan="4 m-0 p-0"></td></tr>
	</table> 
	<br/>
	<div>
		<a href="${ctp}/upLoad4.st" class="btn btn-outline-success form-control">돌아가기</a>
	</div>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>