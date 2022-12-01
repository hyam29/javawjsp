<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- textarea에서 줄바꿈을 그대로 view에 표시하기 위해 작성하는 부분 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %> <!-- \n 이 java에서는 줄바꿈. 이걸 newLine 변수로 받겠다. -->
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>guList.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  
  <style>
  	th {
  		text-align: center;
  		background-color: #aaa;
  	}
  </style>
  
  <script>
		'use strict';
  	function delCheck(idx) {
  		let ans = confirm("삭제 하시겠습니까?");
  		/* if (ans) location.href="${ctp}/guDelete.gu?idx=${vo.idx}"; /* 서버변수(vo.idx) 사용 XXX. 23행에 작성한 idx(Javascript 변수)를 작성해야 함 */
  		if(ans) location.href="${ctp}/guDelete.gu?idx="+idx;
  	}
  	
  	function pageCheck() {
	    /* let pageSize = $('select[name="pageSize"]').val(); */
	    /* let pageSize = $("#pageSize option:selected").val(); */
	    let pageSize = $("#pageSize").val();
	    location.href="${ctp}/guList.gu?pageSize="+pageSize+"&pag=${pag}";
    }
  </script>
  
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">

	<h2 class="text-center">* 방 명 록 리 스 트 *</h2>
	<br/>

	<table class="table table-borderless mb-0">
		<tr>
			<td>
				<c:if test="${sAMid != 'admin'}"><a href="${ctp}/adminLogin.gu" class="btn btn-sm btn-outline-secondary">관리자</a></c:if>
				<c:if test="${sAMid == 'admin'}"><a href="${ctp}/adminLogout.gu" class="btn btn-sm btn-outline-warning">관리자 로그아웃</a></c:if>
			</td>
			<td style="text-align:right;"><a href="${ctp}/guest/guInput.gu" class="btn btn-sm btn-outline-info">글쓰기</a></td>
		</tr>
	</table>
	<table class="table table-borderless m-0 p-0">
		<tr>
			<td class="text-left">
	      <select name="pageSize" id="pageSize" onchange="pageCheck()">
	        <!-- <option value="" selected disabled>건 별 조회</option> -->
	        <option value="5" ${pageSize==5   ? "selected" : ''}> 5건</option>
					<option value="10" ${pageSize==10 ? "selected" : ''}>10건</option>
					<option value="15" ${pageSize==15 ? "selected" : ''}>15건</option>
					<option value="20" ${pageSize==20 ? "selected" : ''}>20건</option>
	      </select>
	 		 </td>
			<td class="text-right">
				<!-- 첫 페이지 / 이전 페이지 / (현재 페이지 번호 / 총 페이지 수) / 다음 페이지 / 마지막페이지 -->
				<c:if test="${pag > 1}">
					[<a href="${ctp}/guList.gu?pag=1">첫 페이지</a>]
					[<a href="${ctp}/guList.gu?pag=${pag - 1}">이전페이지</a>] <!-- 컨트롤러에 페이지랑 같이 넘겨야 함 -->
				</c:if>
				${pag} / ${totPage}
				<c:if test="${pag < totPage}">
					[<a href="${ctp}/guList.gu?pag=${pag + 1}">다음페이지</a>]
					[<a href="${ctp}/guList.gu?pag=${totPage}">마지막 페이지</a>]
				</c:if>
				
			</td>
		</tr>
	</table>
	
	<%-- <c:set var="no" value="${fn:length(vos)}" /> --%>
	<c:set var="curScrStartNo" value="${curScrStartNo}" />
	 <!-- 방명록 방문번호를 글 삭제해서 번호가 이어지게끔 만들어주기! idx 아닌 no 변수 선언해서 변수를 보여주게끔한 것. forEach 전에 no-1 해주면 번호가 순차적으로 출력됨 -->
	<c:forEach var="vo" items="${vos}" varStatus="st">
		<table class="table table-borderless mb-0">
			<tr>
				<%-- <td>방문번호 : ${vo.idx} --%>
				<%-- <td>방문번호 : ${no} --%>
				<td>방문번호 : ${curScrStartNo}
				
					<%-- <c:if test="${sAMid == 'admin'}"><a href="${ctp}/guDelete.gu?idx=${vo.idx}" class="btn btn-sm btn-outline-danger">삭제</a></c:if></td> --%>
					<!-- 삭제 재확인을 위해서 javascript 작성으로 위에 script 사용 선언 + delCheck 함수 괄호 안에 꼭 $ { vo.idx}!!! -->					
					<c:if test="${sAMid == 'admin'}"><a href="javascript:delCheck(${vo.idx})" class="btn btn-sm btn-outline-danger">삭제</a></c:if></td>
				<td style="text-align:right;">방문IP : ${vo.hostIp}</td>
			</tr>
		</table>
		<table class="table table-bordered">
			<tr>
				<th style="width:20%;">성명</th>
				<td style="width:25%;">${vo.name}</td>
				<th style="width:20%;">방문일자</th>
				<td style="width:35%;">${fn:substring(vo.visitDate,0,19)}</td>
			</tr>
			<tr>
				<th>전자우편(E-Mail)</th>
				<td colspan="3">
					<c:if test="${fn:length(vo.email) <= 4}"> - </c:if>
					<c:if test="${fn:length(vo.email) > 4}"><a href="${vo.email}" target="_blank">${vo.email}</a></c:if>
				</td>
			</tr>
			<tr>
				<th>홈페이지(블로그)</th>
				<td colspan="3">
					<c:if test="${fn:length(vo.homePage) <= 8}"> - </c:if>
					<c:if test="${fn:length(vo.homePage) > 8}"><a href="${vo.homePage}" target="_blank">${vo.homePage}</a></c:if>
				</td>
			</tr>
			<tr>
				<th>방문소감</th>
				<td colspan="3">${fn:replace(vo.content, newLine, '<br/>')}</td>
				<!-- 제일 위에 taglib 지시자 선언 후, replace function 사용 -->
			</tr>
		</table>
		<br/>
		<%-- <c:set var="no" value="${no - 1}"></c:set> --%> <!-- 전체 길이(10건)에서 -1씩 해줘야 처음 보여지는 것(10번째)의 다음 레코드(9번째)를 보여주는 것 -->
		<c:set var="curScrStartNo" value="${curScrStartNo - 1}"></c:set> <!-- 전체 길이(10건)에서 -1씩 해줘야 처음 보여지는 것(10번째)의 다음 레코드(9번째)를 보여주는 것 -->
	</c:forEach>
	
	<!-- 첫 페이지 / 이전블록 / [1] [2] [3] 페이지 / 다음블록 / 마지막 페이지 -->
	<div class="text-center">
		<ul class="pagination justify-content-center">
			<c:if test="${pag > 1}">
				 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/guList.gu?pageSize=${pageSize}&pag=1">첫 페이지</a></li>
			</c:if>
				<c:if test="${curBlock > 0}">
					 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/guList.gu?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a></li>
				</c:if>
				
				<c:forEach var="i" begin="${(curBlock)*blockSize + 1}" end="${(curBlock)*blockSize + blockSize}" varStatus="st">
				<!-- begin: 0블록*3+1 = 1페이지 / 1블록*3+1 = 4페이지  -->
					<c:if test="${i <= totPage && i == pag}"> <!-- 자료가 없으면 마지막 블록에서는 페이지 표시 안되게끔 if문 추가 -->
						 <li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/guList.gu?pageSize=${pageSize}&pag=${i}">${i}</a></li>
					</c:if>
					<c:if test="${i <= totPage && i != pag}">
						 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/guList.gu?pageSize=${pageSize}&pag=${i}">${i}</a></li>
					</c:if>
				</c:forEach>
				
				<c:if test="${curBlock < lastBlock}">
					 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/guList.gu?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize + 1}">다음블록</a></li>
				</c:if>
			<c:if test="${pag < totPage}">
				 <li class="page-item"><a class="page-link text-secondary" href="${ctp}/guList.gu?pageSize=${pageSize}&pag=${totPage}">마지막 페이지</a></li>
			</c:if>
		</ul>
	</div>
	
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>