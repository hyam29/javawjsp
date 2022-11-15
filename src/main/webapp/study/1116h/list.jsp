<%@page import="j1116h.InputVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- list.jsp -->
<% 
	InputVO vo = (InputVO)request.getAttribute("vo"); 
%>

<%@ include file="../../include/bs4.jsp" %>
<%-- <% 
	String name = vo.getName(); 
	String strCode = vo.getStrCode(); 
	String strProduct = vo.getStrProduct(); 
	String strSu = vo.getStrSu(); 
	String strPrice = vo.getStrPrice(); 
	int pTot = vo.getpTot(); 

%> --%>
<div class="container">
	<h2>상품 조회 '-'</h2>
	<div> ${vo.name}님이 등록하신 상품을 조회하실 수 있습니다.</div>
	<hr/>
	<table class="table">
		<tr>
			<td>
				상품분류
			</td>
			<td>
				<%-- <%=vo.getStrCode() %> --%>
				${vo.strCode}
			</td>
		</tr>	
		<tr>
			<td>
				상품명
			</td>
			<td>
				<%-- <%=vo.getStrProduct() %> --%>
				${vo.strProduct}
			</td>
		</tr>	
		<tr>
			<td>
				수량
			</td>
			<td>
				<%-- <%=vo.getStrSu() %> --%>
				${vo.strSu}
			</td>
		</tr>	
		<tr>
			<td>
				가격
			</td>
			<td>
				<%-- <%=vo.getStrPrice() %> --%>
				${vo.strPrice}
			</td>
		</tr>	
		<tr>
			<td>
				총 금액
			</td>
			<td>
				<%-- <%=vo.getpTot() %> --%>
				${vo.pTot}
			</td>
		</tr>	
	</table>
	<hr/>
	<p>행복한 시간 되세요 *'-'*</p>
</div>

