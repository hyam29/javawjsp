<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl1.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>JSTL(Java Standard Tag Library)</h2>
	<table class="table">
		<tr>
			<th>라이브러리명</th>
			<th>주소</th>
			<th>접두어</th>
			<th>기본문법</th>
		</tr>
		<tr>
			<td>Core</td>
			<td>http://java.sun.com/jsp/jstl/core</td>
			<td>c</td>
			<td>< c : 태그 . . . ></td>
		</tr>
		<tr>
			<td>Function</td>
			<td>http://java.sun.com/jsp/jstl/function</td>
			<td>fn</td>
			<td>$ < fn : 태그 . . . ></td>
			<!-- function은 $ 로 시작함!!!  -->
		</tr>
		<tr>
			<td>Formatting</td>
			<td>http://java.sun.com/jsp/jstl/fmt</td>
			<td>fmt</td>
			<td>< fmt : 태그 . . . ></td>
		</tr>
		<tr>
			<td>SQL</td>
			<td>http://java.sun.com/jsp/jstl/sql</td>
			<td>sql</td>
			<td>< sql : 태그 . . . ></td>
		</tr>
	</table>
	<br/>
	<hr/><hr/>
	<h4>Core 라이브러리 : 변수제어(선언(set)/할당/출력(out)/제거(remove)), 제어문(조건문, 반복문) 안에서의 변수로 활용</h4>
	<p>변수 선언 : < c : set var="변수명" value="값" / ></p>	
	<p>변수 출력 : < c : out value="변수명/값" / ></p>	
	<p>변수 제거 : < c : remove var="변수명" / ></p>	
	<p>사용 예)
		su1 변수 선언 후 초기값 100으로 할당? <c:set var="su1" value="100" /><br/>
		su1 변수의 값 출력? <c:out value="${su1 }" /> == ${su1 }<br/> <!-- 출력은 JSTL보다 EL이 더 편함 -> out은 그냥 그렇구나 pass -->
	</p>
	<hr/>
	<h3>JSTL 제어문 (core라이브러리 활용)</h3>
	<h3>IF문 (조건문 : 참일때만 수행할 내용 존재. 즉, else 문장이 XXX => else문은 배타적 비교법으로 작성)</h3>
	<p>문법 : < c : if test="$ {조건식}" > 참일때만 수행할 내용 < / c : if ></p>
	(비교문은 MUST EL표기법으로 작성!!!)<br/>
	(일반 비교 연산 수행시에는 '문자'로 비교 처리! 따라서, 숫자로 비교하려면 숫자로 변형해서 비교!!!)<br/>
	<c:set var="su2" value="200" /><br/>
	<c:set var="su3" value=" 200" /><br/>
	1-1. su1 == su2 : <c:if test="${su1 == su2 }">su1과 su2는 같다.</c:if><br/>
	1-2. su1 != su2 : <c:if test="${su1 != su2 }">su1과 su2는 다르다.</c:if><br/>
	2-1. su1 >= su2 : <c:if test="${su1 >= su2 }">su1이 su2보다 크거나 같다.</c:if><br/>
	2-2. su1 < su2 : <c:if test="${su1 < su2 }">su1이 su2보다 작다.</c:if><br/>
	3-1. su2 == su3 : <c:if test="${su2 == su3 }">su2과 su3는 같다.</c:if><br/>
	3-2. su2 != su3 : <c:if test="${su2 != su3 }">su2과 su3는 다르다.</c:if><br/>
	
	<%-- 4-1. su2 == su3 : <c:if test="${su2+0 == su3+0 }">su2과 su3는 같다.</c:if><br/>
	4-2. su2 != su3 : <c:if test="${su2+0 != su3+0 }">su2과 su3는 다르다.</c:if><br/> --%>
	<!-- 숫자를 비교하려면, trim() -> 아무숫자나 연산 시킴 (+0) -> 비교가능 -->
	<hr/>
	<c:set var="jum" value="${param.jumsu }" /> <!-- 변수 선언 방법 -->
	<p>Q. 점수를 입력 후 학점버튼을 클릭하면 해당 학점을 출력하세요.</p>
	<!-- && = and || = or -->
	<c:if test="${jum >= 60}"><c:set var="grade">D</c:set></c:if><br/>
	<c:if test="${jum >= 70}"><c:set var="grade">C</c:set></c:if><br/>
	<c:if test="${jum >= 80}"><c:set var="grade">B</c:set></c:if><br/>
	<c:if test="${jum >= 90}"><c:set var="grade">A</c:set></c:if><br/>
	<c:if test="${jum < 60}"><c:set var="grade">F</c:set></c:if><br/>
	
	<c:set var="gen" value="${param.gender }" /> <!-- param으로 값을 넘겨받는 건 변수 선언해서 담는 게 더 좋다! 여기서는 바로 써주는 게 코딩량 줄어서 더 좋음 -->
	<c:if test="${gen == 1 }"><c:set var="gender">남</c:set></c:if> <!-- 숫자를 작은따옴표로 둘러싸지 않아도 문자비교가 됨!!! -->
	<c:if test="${gen != 1 }"><c:set var="gender">여</c:set></c:if> <!-- 이렇게 작성하면 checked 안해도 되는 듯...? -->
	
	<%-- 
	선생님 방법
	<c:if test="param.gender == 1"><c:set var="gender" value="남" /></c:if>
	<c:if test="param.gender == 2"><c:set var="gender" value="여" /></c:if> 
	--%>
	<form name="myform">
		<div>
			성별 : 
			<input type="radio" name="gender" value="1" checked />남자
			<input type="radio" name="gender" value="2" />여자
		</div>
		<div>
			점수를 입력하세요 <input type="text" name="jumsu" class="form-control mb-2" />
			<input type="submit" value="학점출력" class="btn btn-outline-success mb-2" />
		</div>
		<div>
			입력한 점수 : ${jumsu }점<br/>
			학점 : ${grade }<b><span id="demo"></span></b><br/>
			성별 : <b> ${gender}자</b><br/>
		</div>
	</form>
	<br/>
	<hr/>
	<h2>다중조건 비교(choose ~ when) like. switch</h2>
	<pre>
		문법 : 
		< c : choose >
			< c : when test="조건식1" />수행할내용1< / c : when >
			< c : when test="조건식2" />수행할내용2< / c : when >
			 ~~~
			< c : otherwise />수행할내용< / c : otherwise >
		< /c : choose >
	</pre>
	<c:choose>
		<c:when test="${jum >= 90}"><c:set var="grade2" value="A" /></c:when>
		<c:when test="${jum >= 80}"><c:set var="grade2" value="B" /></c:when>
		<c:when test="${jum >= 70}"><c:set var="grade2" value="C" /></c:when>
		<c:when test="${jum >= 60}"><c:set var="grade2" value="D" /></c:when>
		<c:otherwise><c:set var="grade2" value="F" /></c:otherwise>
	</c:choose>
	<h4>점수를 입력 후 학점버튼을 클릭하면 해당 학점을 출력 : <font color="red">${grade2}</font>학점</h4>
</div>
<p><br/></p>
</body>
</html>