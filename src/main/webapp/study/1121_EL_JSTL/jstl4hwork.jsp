<%@page import="study.database.JusorokVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="study.database.JusorokDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>jstl4.jsp</title>
  <jsp:include page="../../include/bs4.jsp"></jsp:include>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>Function 라이브러리</h2>
	<p>사용법: $ {fn:함수명(변수/값 . . .)}</p>
	<hr/>
<%						// 0				 1				 2
							// 0123456789012345678901234
	String atom = "Welcome to My Homepage!";
	pageContext.setAttribute("atom", atom);
	pageContext.setAttribute("atom2", atom);
%>
	<p>
		atom 변수의 값 : <%=atom%> / ${atom}<br/>
		1. atom 변수 값의 길이 : <%=atom.length() %> / ${fn:length(atom)}<br/> <!-- 작성법이 함수부터!!!!!!! 괄호안이 변수/값!!!!!!! -->
		2. 대문자변환(toUpperCase()) : <%=atom.toUpperCase() %> / ${fn:toUpperCase(atom) }<br/>
		3. 소문자변환(toLowerCase()) : <%=atom.toLowerCase() %> / ${fn:toLowerCase(atom) }<br/>
		4-1. 문자열추출1(subString()) : <%=atom.substring(0,3) %> / ${fn:substring(atom, 0, 3)}<br/>
		4-2. 문자열추출2(subString()) : <%=atom.substring(2) %> / ${fn:substring(atom, 2,-1)}<br/>
		4-3. 문자열추출2(subString()) : <%=atom.substring(2) %> / ${fn:substring(atom, 2, fn:length(atom))}<br/>
		5. 특정문자열의 위치값 찾기(indexOf()) : <%=atom.indexOf("o") %> / ${fn:indexOf(atom, 'o')}<br/>
		5-2. atom변수에 기억되어 있는 'o'문자의 위치를 모두 출력하고 전체 개수(=>누적 for문 이용)를 출력하시오.<br/>
		
		<c:set var="cnt" value="0" />
		<c:forEach var="i" begin="0" end="${fn:length(atom)-1}">
				
			<c:if test="${fn:substring(atom,i,i+1) == 'o'}">
			<br/>
				문자 'o'의 위치 : ${i}
				<c:set var="cnt" value="${cnt+1}" />
			</c:if>
		</c:forEach>
		
		<p>문자 'o'의 전체 개수 :${cnt }<br/>
		<br/>
		
		5-3. atom변수에 기억되어 있는 문자를 입력받아 그 문자가 두번째로 기억되어 있는 위치값을 출력하시오.<br/>
					단, 두번째 기억 값이 없으면 1번째 기억위치를 추력하고 '두번째 값 없음'을 함께 출력하시오. -> 과제<br/>
					atom = Welcome to My Homepage!
					
		<form name="myform">
			<div>
				<input type="text" name="input" required /> 
				<input type="submit" value="문자찾기" class="btn btn-outline-warning" />
			</div>
			<c:set var="cnt" value="0" />
			<c:set var="input" value="${param.input}" />
			
			<c:forEach var="i" begin="0" end="${fn:length(atom)-1}">
				<c:if test="${fn:substring(atom,i,i+1) == input}">
				<c:set var="cnt" value="${cnt + 1}"/>
					<c:if test="${cnt == 1}">
						<c:set var="input1" value="${i}"/>
					</c:if>
					<c:if test="${cnt == 2}">
						<c:set var="input2" value="${i}" />
					</c:if>
				</c:if>
			</c:forEach>
			<c:choose>
				<c:when test="${input2 != null}">입력하신 문자의 두번째 위치 : ${input2} </c:when>
				<c:when test="${input1 != null}">입력하신 문자의 첫번째 위치 : ${input1}(두번째 값 없음) </c:when>
				<c:otherwise>입력하신 문자는 atom 변수에 없습니다. </c:otherwise>
				<%-- <c:when test="${input1 == 0 && input2 == 0}">입력하신 문자는 atom 변수에 없습니다. </c:when> --%>
			</c:choose>
		</form>
		
				<%-- <c:if test="${input2 ne 0}">
			입력하신 문자의 위치 : ${input2}<br/>
		</c:if>			
		<c:if test="${input1 ne 0}">
			입력하신 문자의 위치 : ${input1} (첫번째 위치. 두번째 값 없음)
		</c:if>	 --%>		

		<br/><br/><br/>																					
		6. 문자열추출(substringBefore() / substringAfter())<br/>
				'o' 앞의 문자열 출력 : ${fn:substringBefore(atom, 'm')}<br/>
				'o' 뒤의 문자열 출력 : ${fn:substringAfter(atom, 'm')}<br/><br/>
		6-2. atom변수에 기억되어 있는 문자를 입력받아 그 문자가 두번째로 기억되어 있는 위치값을 출력하시오.<br/>
					단, 두번째 기억값이 없으면 1번째 기억위치를 출력하고 '두번째 값 없음'을 함께 출력하시오.
		<form name="myform2">
			<div>
				<input type="text" name="inputText" required /> 
				<input type="submit" value="문자찾기" class="btn btn-outline-primary" />
			</div>
			<c:set var="inputT" value="${param.inputText}" />
			<c:set var="bf" value="${fn:substringBefore(atom,inputT)}" />
			<c:set var="af" value="${fn:substringAfter(atom,inputT)}" />
			<c:set var="inputText" value="${fn:indexOf(af,inputT)}" />
			<%-- ${inputText}<br/>
			${bf}<br/> --%>
			<%-- <c:if test="${inputT ne null}"> --%>
			<c:if test="${!empty inputT}"> <!-- 웬만하면 empty 사용하기 -->
				<c:if test="${inputText eq -1}"> 입력한 문자의 첫번째 위치 : ${fn:length(bf)} (두번째 값 없음)</c:if>
				<c:if test="${inputText ne -1}"> 입력한 문자의 두번째 위치 : ${inputText+fn:length(bf)+1}</c:if>
			</c:if>
		</form>	
		
		<br/><br/><br/>				
		7. 문자열 분리(split(변수, 분리할 문자)) = > 결과를 담아야하므로 무조건 변수 필요! c:set 필수! <br/>
				'o'문자를 기준으로 분리해보세요. <br/>
				<c:set var="atoms" value="${fn:split(atom,'o')}" />
				<c:forEach var="atom" items="${atoms}" varStatus="st">
					${st.count}. ${atom}<br/>
				</c:forEach>
				atoms(배열)의 전체 길이?(방의 개수) ${fn:length(atoms)}<br/>
				예) jusorok테이블의 전체 건수는?
<%
	JusorokDAO dao = new JusorokDAO();
	ArrayList<JusorokVO> vos = dao.getMemberList();
	request.setAttribute("vos", vos);
%>
				<b>${fn:length(vos)} 건</b><br/>
		8. 문자열 치환(replace())<br/>
			문제: atom2변수안의 'My'를 'Your'로 변경하시오.
			<%=atom.replace("My", "Your") %> / ${fn:replace(atom2, 'My', 'Your')}<br/>
		9. 특정문자 포함유무? contains()<br/>
			atom2 변수에 'o'를 포함하고 있느냐? ${fn:contains(atom2,'o')}<br/>
			atom2 변수에 'My'를 포함하고 있느냐? ${fn:contains(atom2,'My')}<br/>
			atom2 변수에 'Your'를 포함하고 있느냐? ${fn:contains(atom2,'Your')}<br/> <!-- 특정 한 문자보다 문자열(단어)를 찾는 데 더 많이 사용 -->
	</p>
</div>
<p><br/></p>
</body>
</html>