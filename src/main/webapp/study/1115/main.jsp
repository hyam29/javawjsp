<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 
	지시자 (디렉티브) 총 3개만 알면 됨!
	page : 페이지 보여주는 것 
	include : 외부 파일을 나에게 포함시킨다.
	library : JSP 라이브러리 불러오는 지시자
 -->
 <%
 	String sw = request.getParameter("sw") == null ? "" : request.getParameter("sw"); // null값 처리
 %>
 
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>main.jsp</title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <style>
  	body {
  		width: 1000px;
  		margin: 0px auto; /* 가운데 정렬 */
  		padding: 0px;
  	}
  	#header {
  		background-color: #eef;
  		text-align: center;
  		height: 90px;
  	}
  	#footer {
  		background-color: #ffc;
  		text-align: center;
  		height: 75px;
  	}
  	#content {
  		background-color: #fff;
  		text-align: center;
  	}
  	
  </style>
</head>
<body>
<div class="container text-center">
	<!-- 헤더영역 ('메뉴/로고' 를 표시한다.) -->
	<div id="header">
	<br/>
		<%@ include file="menu.jsp" %>
	</div>
	
	<!-- 본문영역 -->
	<div id="content">
	<br/>
	<br/>
	<!-- include 지시자 사용해서 외부 파일 불러와준다! (menu에 작성해둔 sw 변수 불러옴) -->
	<%if(sw.equals("guest")) { %>
		<%@ include file="guest.jsp" %>
	<%} else if(sw.equals("board")) { %>
		<%@ include file="board.jsp" %>
	<%} else if(sw.equals("pds")) { %>
		<%@ include file="pds.jsp" %>
	<%} else if(sw.equals("photo")) { %>
		<%-- <%@ include file="photo.jsp" %> --%>
		<!-- 
			JSP액션태그 include VS include 지시자
			
			jsp:include page="" => 완성된 것 가져올 때 사용
			include file="" => 쪼개진 조각 가져올 때 사용
		
		 -->
		
		<!-- JSP 액션태그(include) 사용해서 photo 불러오기 = include 지시자와 똑같은 기능 -->
		<jsp:include page="photo.jsp"></jsp:include> <!-- /jsp:include 생략해도 되지만, 생략하지 말기 -->
		<!-- 
			jsp 액션태그 왜 꺼내요? => JSTL (Java Standard Tag Library)
			프론트 관리자는 대부분 java 언어를 대부분 모름... 그래서, \<\% 보면 스트레스 받음 -> \<\% 없앨 수 있음
		 -->
	<%} else { %>
			<h2>이곳은 메인 화면 입니다.</h2>
			<hr/>
			<p><img src="../../images/4.jpg" width="600px" /></p>
	<%} %>	
		<br/>
	</div>
	
	<!-- 푸터영역 (Copyright or 주소, 소속, 작성자 등을 기술한다.) -->
	<div id="footer">
		<%@ include file="footer.jsp" %>
	</div>
</div>
</body>
</html>