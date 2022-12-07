<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pdsSearch.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
 // 다운로드 횟수 증가 처리
  	function downNumCheck(idx) {
  		$.ajax({
  			type : "post",
  			url : "${ctp}/pdsDownNum.pds",
  			data : {idx : idx},
  			success : function() {
  				location.reload();
  			},
  			error : function() {
  				alert("다운로드 전송 오류.");
  			}
  		});
  	}
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="text-center">* 자료실 조건검색 *</h2>
	<div class="text-center">
		(<font color="blue">${searchTitle}</font>(으)로 <font color="blue">${searchString}</font>(을)를 검색한 결과, <font color="red">${searchCount}건</font>이 검색되었습니다.)
	</div>
	<br/>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>자료제목</th>
			<th>올린이</th>
			<th>작성일자</th>
			<th>분류</th>
			<th>파일명(크기)</th>
			<th>다운로드 횟수</th>
			<th>비고</th>
		</tr>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td>${searchCount}</td>
				<td>
          <a href="${ctp}/pdsContent.pds?idx=${vo.idx}&pag=${pag}">${vo.title}</a>
    	    <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
        </td>
				<td>${vo.nickName}</td>
				<td>
          <%-- ${vo.fDate} --%>
					<%-- <td>${fn:substring(vo.fDate,0,16)}</td> --%>
          <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.fDate,0,10)}</c:if>
          <c:if test="${vo.hour_diff < 24}">
          <!-- 24시간이 지나지 않았지만 현재시간~자정까찌는 '날짜:시간', 나머지는 '시간'만 출력 -->		
    	      ${vo.day_diff > 0 ? fn:substring(vo.fDate,0,16) : fn:substring(vo.fDate,11,19)}
    	    </c:if>
        </td>
				<td>${vo.part}</td>
				<td>
					<c:set var="fNames" value="${fn:split(vo.fName, '/')}" />
					<c:set var="fSNames" value="${fn:split(vo.fSName, '/')}" />
					<c:forEach var="fName" items="${fNames}" varStatus="st">
						<a href="${ctp}/data/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
					</c:forEach>
					<%-- (<fmt:formatNumber value="${vo.fSize/1024}" pattern="#,###" />KByte) --%>
					<!-- 1000kb 초과시 mb고치기 -->
					<c:if test="${(vo.fSize/1024) < 1000}">
						(<fmt:formatNumber value="${vo.fSize/1024}" pattern="#,###" />KB)
					</c:if>
					<c:if test="${(vo.fSize/1024) >= 1000}">
						(<fmt:formatNumber value="${vo.fSize/1024/1024}" pattern="#.0" />MB)
					</c:if>
				</td>
				<td>${vo.downNum}</td>
				<td>
					<a href="#" onclick="modalView('${vo.title}','${vo.nickName}','${vo.mid}','${vo.part}','${vo.fName}','${vo.fSName}','${vo.fSize}','${vo.downNum}','${vo.fDate}')" class="badge badge-pill badge-secondary" data-toggle="modal" data-target="#myModal">모달창</a><br/>
					<!-- 앵커태그에도 onclick 가능! (현재 위치 알기위해서 앵커태그로 작성하는 것. 원래는 button이 더 많음) -->
					 <a href="${ctp}/pdsTotalDown.pds?idx=${vo.idx}" class="badge badge-pill badge-primary">전체다운</a><br/>
					 <!-- 1. JSP 함수이용 삭제방법 (값을 넘길 때, 타입이 숫자와 문자를 함께 넘기면 거의 error 따라서, 타입을 문자로 통일해서 보내줘야함) -->
					 <a href="javascript:pdsDelCheck('${vo.idx}','${vo.fSName}')" class="badge badge-pill badge-warning">1.삭제</a><br/>
          <a href="#" onclick="pdsDelCheckModal('${vo.idx}','${vo.fSName}')" data-toggle="modal" data-target="#myPwdModal" class="badge badge-pill badge-danger">2.삭제</a>
			 	</td>
    	</tr>
    	<c:set var="searchCount" value="${searchCount-1}"/>
		</c:forEach>
		<tr><td colspan="9" class="m-0 p-0"></td></tr>
	</table>
</div>
<br/>
<div class="text-center"><a href="${ctp}/pdsList.pds?pag=${pag}&pageSize=${pageSize}" class="btn btn-outline-secondary">돌아가기</a></div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>