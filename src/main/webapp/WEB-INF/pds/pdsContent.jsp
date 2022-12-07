<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>pdsContent.jsp</title>
  <jsp:include page="/include/bs4.jsp" />
  <script>
  	/* 스크롤 애니메이션 */
    'use strict';
		$(window).scroll(function(){
			if($(this).scrollTop() > 100 ){ // 현재 스크롤이 100px 넘어간다면, 
	      $("#topBtn").addClass("on"); // topBtn class 추가해주세요.
	    }
	    else{
	      $("#topBtn").removeClass("on"); // 100px보다 작아진다면, class 제거
	    }
			
			$("#topBtn").click(function() {
			  window.scrollTo({ top: 0, behavior: "smooth" });  //페이지에서 특정 위치로 스크롤 이동시키기 위해서는 window.scrollTo 메서드를 사용
			});
		});
		
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
  <style>
    th {
      background-color: #eee;
    }
		h6 {
		  position: fixed;
		  right: 1rem;
		  /* rem은 그 전에 사용했던 em의 단위를 그대로 사용하겠다. */
		  bottom: -50px;
		  opacity: 0; /* 혹시 보일까봐 불투명도 0 변경 */
		  transition: 0.7s ease; /* 움직임이 일어난다면 0.7초 정도로 변화를 주겠다. */
		}
		.on {
		  opacity: 0.8;
		  cursor: pointer;
		  bottom: 0;
		}
  </style>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">개별 자료 상세 내역</h2>
  <br/>
  <table class="table table-bordered text-center">
    <tr>
      <th>올린이</th>
      <td>${vo.nickName}</td>
      <th>올린날짜</th>
      <td>${fn:substring(vo.fDate,0,fn:length(vo.fDate)-2)}</td>
    </tr>
    <tr>
      <th>파일명</th>
      <td>
        <c:set var="fNames" value="${fn:split(vo.fName,'/')}"/>
        <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
        <c:forEach var="fName" items="${fNames}" varStatus="st">
          <a href="${ctp}/data/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
        </c:forEach>
      </td>
      <th>다운횟수</th>
      <td>${vo.downNum}</td>
    </tr>
    <tr>
      <th>분류</th>
      <td>${vo.part}</td>
      <th>파일크기</th>
      <td><fmt:formatNumber value="${vo.fSize / 1024}" pattern="#,##0"/>KByte</td>
    </tr>
    <tr>
      <th>제목</th>
      <td colspan="3" class="text-left">${vo.title}</td>
    </tr>
    <tr>
      <th>상세내역</th>
      <td colspan="3" style="height:280px;" class="text-left">${fn:replace(vo.content, newLine, '<br/>')}</td>
    </tr>
  </table>
  <div class="text-center">
    <input type="button" value="돌아가기" onclick="location.href='${ctp}/pdsList.pds?pag=${pag}&part=${part}';" class="btn btn-secondary"/>
  </div>
  <hr/>
  <div class="text-center">
	  <c:set var="fSNames" value="${fn:split(vo.fSName,'/')}"/>
	  <c:forEach var="fSName" items="${fSNames}" varStatus="st">
	    ${st.count}. ${fSName}<br/>
	    <c:set var="fSNameLen" value="${fn:length(fSName)}"/>
	  	<c:set var="ext" value="${fn:substring(fSName,fSNameLen-3,fSNameLen)}"/>
	  	<c:set var="extUpper" value="${fn:toUpperCase(ext)}"/>
	  	<c:if test="${extUpper=='JPG' || extUpper=='GIF' || extUpper=='PNG'}">
	  		<img src="${ctp}/data/pds/${fSName}" width="85%"/>
	  	</c:if>
	  	<hr/>
	  </c:forEach>
  </div>
</div>
<h6 id="topBtn" class=""><img src="${ctp}/images/arrowTop.gif"/></h6>
<!-- <h6 id="topBtn" class="">맨위로</h6> -->
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>