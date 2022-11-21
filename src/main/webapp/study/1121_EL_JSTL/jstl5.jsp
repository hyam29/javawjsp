<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl5.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>Format 라이브러리</h2>
	<p>형식 문자열을 지정할 때 사용(쉼표, 화폐단위, 백분율 등)</p>
	<p>사용법 : < fmt : 명령어 value="$ {값}" pattern="표현패턴" / type="화폐단위" ></p>
	<div>
		<h5>formatNumber 형식을 지정한 출력</h5>
		1-1. 천 단위마다 콤마표시 : <fmt:formatNumber value="1234567" /><br/>
<%
	int won = 7654321;
	pageContext.setAttribute("won", won);
%>
		1-2. 사용 예) 7654321 => <fmt:formatNumber value="${won}" /><br/>
		1-3. 사용 예) 1234.567(자동반올림) => <fmt:formatNumber value="1234.567" pattern="#,##0.0" /><br/>
		2-1. 화폐단위(설정국가) : <fmt:formatNumber value="${won}" type="currency" /><br/>
		2-2. 화폐단위($) : <fmt:formatNumber value="${won}" type="currency" currencyCode="USD" /><br/>
		
		<!-- currency 는 현재 컴퓨터에 설정된 국가의 화폐단위로 출력 -->
		
		<c:set var="su1" value="0.9543" />
		3-1. 백분율 : <fmt:formatNumber value="${su1}" type="percent" />
		<h5>formatDate 형식을 지정한 출력</h5>
		<p>자바형식의 날짜를 jstl변수에 저장 : <c:set var="now" value="<%=new java.util.Date() %>" /> </p> 
		<!-- 자바 util에 있는 Date 객체 생성하여 jstl에 사용하려고 var 변수에 담음 -->
		<p>
			오늘 날짜: ${now}<br/>
			<fmt:formatDate value="${now}" /><br/>
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" /><br/>
			<fmt:formatDate value="${now}" pattern="hh : mm : ss" /><br/>
			<fmt:formatDate value="${now}" pattern="yyyy-MM-dd hh:mm:ss" /><br/>
			<fmt:formatDate value="${now}" pattern="yyyy년MM월dd일 hh시mm분ss초" /><br/>
		</p>
		<hr/>
		<h3>국가별 설정(로케일)</h3>
		<p>
			톰캣 서버의 기본 로케일 : <%=response.getLocale() %><br/>
			톰캣 서버의 로케일 형변환(미국식변환) : <fmt:setLocale value="en_US"/>
			<fmt:formatNumber value="${won}" type="currency"/><br/>
		</p>
		<h4>기타</h4>
		<p>지정된 곳으로 실행하자마자 이동 : location.href() -> <%-- <c:redirect url="jstl1.jsp" /> --%> </p>
		<p>절대경로 이용 : 그림1 <img src="${ctp}/images/1.jpg" width="200px" /></p>
		<p>URL문 : 그림2 <c:url var="img" value="../../images/2.jpg" /></p> <br/> <!-- 절대경로 안됨... -->
									<img src="${img}" width="200px" />
	</div>
</div>
<p><br/></p>
</body>
</html>