<%@page import="j1116h.ProductVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  //ProductVO vo = (ProductVO) request.getAttribute("vo");
%>
  <div class="text-center">
    <a href="${pageContext.request.contextPath}/study/1116h/main.jsp">홈으로</a> |
    <%-- <a href="${pageContext.request.contextPath}/study/1116h/main.jsp?sw=input">판매상품등록</a> | --%>
    <a href="${pageContext.request.contextPath}/j1116h/Main?sw=input">판매상품등록</a> |
    <%-- <a href="${pageContext.request.contextPath}/study/1116h/main.jsp?sw=list">판매상품조회</a> | --%>
    <%-- <a href="${pageContext.request.contextPath}/j1116h/List?sw=list&vo=<%=vo%>">판매상품조회</a> | --%>
    <a href="${pageContext.request.contextPath}/j1116h/List?sw=list&product=${vo.product}&price=${vo.price}&su=${vo.su}">판매상품조회</a> |
    <a href="${pageContext.request.contextPath}/study/1116h/main.jsp?sw=photo">포토갤러리</a>
  </div>
