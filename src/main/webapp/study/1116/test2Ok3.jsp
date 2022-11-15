<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	/* String hakbun = request.getParameter("hakbun");
	String name = request.getParameter("name");
	int kor = Integer.parseInt(request.getParameter("kor"));
	int eng = Integer.parseInt(request.getParameter("eng"));
	int mat = Integer.parseInt(request.getParameter("mat"));
	int soc =Integer.parseInt(request.getParameter("soc"));
	int sci = Integer.parseInt(request.getParameter("sci"));
	int tot = Integer.parseInt(request.getParameter("tot"));
	double avg = Double.parseDouble(request.getParameter("avg"));
	String grade = request.getParameter("grade"); */
	
	String strVo = request.getParameter("vo");
	System.out.println("strVo : " + strVo);
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test2Ok3.jsp</title>
  <%@ include file="../../include/bs4.jsp" %>
</head>
<body>
<p><br/></p>
<div class="container">
	<h2>이곳은 test2Ok3.jsp 입니다.</h2>
	<p>
		strVo : <%=strVo %>
	</p>
	<%-- <p>학 번 : <%=hakbun %></p>
	<p>성 명 : <%=name %></p>
	<p>국 어 : <%=kor %></p>
	<p>영 어 : <%=eng %></p>
	<p>수 학 : <%=mat %></p>
	<p>사 회 : <%=soc %></p>
	<p>과 학 : <%=sci %></p>
	<p>총 점 : <%=tot %></p>
	<p>평 균 : <%=avg %></p>
	<p>학 점 : <%=grade %></p> --%>
	<hr/>
	<p><a href="test2.jsp" class="btn bnt-secondary">돌아가기</a></p>
	
</div>
<p><br/></p>
</body>
</html>