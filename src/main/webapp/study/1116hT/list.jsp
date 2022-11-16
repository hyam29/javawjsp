<%@page import="j1116h.ProductVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- pds.jsp -->
<div class="container text-center">
  <h2>이곳은 자료실 입니다.</h2>
  <hr/>
  <div>
      품명 : <input type="text" name="product" id="product" value="${vo.product}" readonly class="form-control mb-3"/>
      </div>
      <div>
      단가 : <input type="text" name="price" id="price" value="${vo.product}" readonly class="form-control mb-3"/>
      </div>
      <div>
      수량 : <input type="text" name="su" id="su" value="${vo.product}" readonly class="form-control mb-3"/>
      </div>
      <div>
      금액 : <input type="text" name="su" id="su" value="${vo.kumaek}" readonly class="form-control mb-3"/>
      </div>
  <hr/>
  <p>좋은 시간 되세요</p>
</div>
