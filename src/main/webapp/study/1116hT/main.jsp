<%@page import="j1116h.ProductVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  String sw = "";
  ProductVO vo = (ProductVO) request.getAttribute("vo");
  System.out.println("vo :"+ vo);
  if(vo != null) vo.getSw();
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
      margin: 0px auto;
      padding: 0px;
    }
    #header {
      background-color: aqua;
      text-align: center;
      height: 80px;
    }
    #footer {
      background-color: #ccc;
      text-align: center;
      height: 75px;
    }
    #content {
	    background-color: #fff;
      /* text-align: center; */
    }
  </style>
</head>
<body>
<div class="container">
	<!-- 헤더영역('메뉴/로고' 를 표시한다. -->
  <div id="header">
    <br/>
  	<%@ include file="menu.jsp" %>
  </div>
  <!-- 본문영역 -->
  <div id="content">
  <br/>
  반갑습니다. : <%=sw %>:
<%if(sw.equals("input")) { %>
    안녕..
		<%@ include file="input.jsp" %>
<%} else if(sw.equals("list")) { %>
		<%@ include file="list.jsp" %>
<%} else if(sw.equals("photo")) { %>
		<jsp:include page="photo.jsp"></jsp:include>
<%} else { %>
    <div class="text-center">
		  <h2>이곳은 메인 화면 입니다</h2>
		  <hr/>
		  <p><img src="${pageContext.request.contextPath}/images/1.jpg" width="400px"/></p>
	  </div>
<%} %>
  	<br/>
  </div>
  <div id="footer">
    <%@ include file="footer.jsp" %>
    <br/><%=vo %>
  </div>
</div>
</body>
</html>