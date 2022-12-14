<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>boContent.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	function goodCheck() {
  		$.ajax({
  			type: "post",
  			url: "${ctp}/boGood.bo",
  			data: {idx : ${vo.idx}},
  			success: function() {
  				location.reload();
  			},
  			error: function() {
  				alert("좋아용 전송 오류");
  			}
  		});
  	}
  	 /* data : idx는 int라서 그냥 작성! String이라면, idx: "$ { vo . 변수명}" 따옴표 꼭 필요!!!!!!! */
  	
  	 // 좋아요 증가와 감소는 같은 로직에 goodCnt 만 +- 1 해주면 되기 때문에, 같은 command 사용
		function goodCheckPlus() {
			$.ajax({
				type  : "post",
				url   : "${ctp}/boGoodPlusMinus.bo",
				data  : {
					idx : ${vo.idx},
					goodCnt : 1
				},
				success:function() {
					location.reload();
				}
			});
		}
		
		function goodCheckMinus() {
			$.ajax({
				type  : "post",
				url   : "${ctp}/boGoodPlusMinus.bo",
				data  : {
					idx : ${vo.idx},
					goodCnt : -1
				},
				success:function() {
					location.reload();
				}
			});
		}
		
		// 게시글 삭제 처리
		function boDelCheck() {
			let ans = confirm("게시글을 삭제하시겠습니까?");
			if(ans) location.href="${ctp}/boDeleteOk.bo?idx=${vo.idx}&pageSize=${pageSize}&pag=${pag}&mid=${vo.mid}";
		}
		// onclick 함수에서 매개변수 idx를 넘겨줬다면, 컨트롤러에 값 넘길 때 + idx 만 적으면 됨 
		
		// 댓글 달기 처리
		function replyCheck() {
			let content = $("#content").val();
			if(content.trim() == "") {
				alert("댓글 내용을 입력하세요.");
				$("#content").focus();
				return false;
			}
			let query = {
					boardIdx : ${vo.idx},
					mid : '${sMid}',
					nickName : '${sNickName}',
					content : content,
					hostIp : '${pageContext.request.remoteAddr}'
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/boReplyInput.bo",
				data : query,
				success : function(res) {
					if(res == "1") {
						alert("댓글이 등록되었습니다.");
						location.reload();
					}
					else {
						alert("댓글 등록 실패.");
					}
				},
				error : function() {
					alert("댓글 달기 전송 오류.");
				}
				
			});
		}
		
		// 댓글 삭제하기
		// data 에 적은 값(뒤에 적은 idx)이 replyDelCheck(idx:원댓글의고유번호) 의 idx
    function replyDelCheck(idx) {
    	let ans = confirm("댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type  : "post",
    		url   : "${ctp}/boReplyDeleteOk.bo",
    		data  : {idx : idx},
    		success:function(res) {
    			if(res == "1") {
    				alert("댓글이 삭제되었습니다.");
    				location.reload();
    			}
    			else {
    				alert("댓글이 삭제처리 실패");
    			}
    		},
    		error  : function() {
    			alert("댓글 삭제 전송 오류");
    		}
    	});
		}
			
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2 class="text-center">글 내 용 보 기</h2>
	<hr/>
	<br/>
	<table class="table table-borderless">
		<tr>
			<td class="text-right">hostIp : ${vo.hostIp}</td>
		</tr>
	</table>
	<table class="table table-bordered">
		<tr>
			<th>글쓴이</th>
			<td>${vo.nickName}</td>
			<th>작성일</th>
			<%-- <td>${fn:substring(vo.wDate,0,19)}</td> --%>
			<td>${fn:substring(vo.wDate,0,fn:length(vo.wDate)-2)}</td>
		</tr>
		<tr>
			<th>글제목</th>
			<td colspan="3">${vo.title}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<td>${vo.email}</td>
			<th>조회수</th>
			<td>${vo.readNum}</td>
		</tr>
		<tr>
			<th>홈페이지(블로그)</th>
			<td>${vo.homePage}</td>
			<th>좋아요</th>
      <td><a href="javascript:goodCheck()">
            <c:if test="${sSw == '1'}"><font color="red">❤</font></c:if>
            <c:if test="${sSw != '1'}">❤</c:if>
          </a>
          ${vo.good} ,
          <a href="javascript:goodCheckPlus()">👍</a>
          <a href="javascript:goodCheckMinus()">👎</a>
      </td>
    </tr>
		<tr>
			<th>글내용</th>
			<td colspan="3" style="height:220px">${fn:replace(vo.content, newLine, "<br/>")}</td>
		</tr>
		<tr>
			<td colspan="4" class="text-center">
				<c:if test="${flag == 'search'}"><input type="button" value="검색 목록으로 돌아가기" onclick="location.href='${ctp}/boSearch.bo?search=${search}&searchString=${searchString}&pageSize=${pageSize}&pag=${pag}';" class="btn btn-outline-primary" /></c:if>
				<c:if test="${flag != 'search'}">
					<input type="button" value="글 목록보기" onclick="location.href='${ctp}/boList.bo?pageSize=${pageSize}&pag=${pag}';" class="btn btn-outline-primary" />
					<c:if test="${sMid == vo.mid || sLevel == 0}">
						<input type="button" value="수정" onclick="location.href='${ctp}/boUpdate.bo?idx=${vo.idx}&pageSize=${pageSize}&pag=${pag}';" class="btn btn-outline-warning" />
						<!-- 콤보박스 조회 건수와 수정 후 페이지 유지를 하기 위해서는 pageSize와 pag 같이 넘겨주는 게 좋음 -->
						<input type="button" value="삭제" onclick="boDelCheck()" class="btn btn-outline-danger" />
						<!-- 현재 보고 있는 글이 한개니까, idx 안넘겨도 됨, 삭제는 바로 삭제하는 것 보다 메세지 띄우는 게 좋으므로 함수 생성 -->
					</c:if>
				</c:if>
			</td>
		</tr>
	</table>
	
	<c:if test="${flag != 'search'}">
	<!-- 이전글/다음글 처리 -->
	  <table class="table table-borderless">
	    <tr>
	      <td style="float:left">
	        <c:if test="${preVo.preIdx != 0}">
	          👈 <a href="${ctp}/boContent.bo?idx=${preVo.preIdx}&pageSize=${pageSize}&pag=${pag}">이전글 : ${preVo.preTitle}</a><br/>
	        </c:if>
	      </td>
	      <td style="float:right">
	        <c:if test="${nextVo.nextIdx != 0}">
	          👉 <a href="${ctp}/boContent.bo?idx=${nextVo.nextIdx}&pageSize=${pageSize}&pag=${pag}">다음글 : ${nextVo.nextTitle}</a>
	        </c:if>
	      </td>
	    </tr>
	  </table>
	  <!-- 이전글/다음글 처리 끝 -->
  </c:if>
</div>
<br/>
<!-- 댓글 출력 창 시작 -->
<div class="container">
	<table class="table table-hover text-left">
		<tr class="table-warning text-dark">
			<th>작성자</th>
			<th>댓글 내용</th>
			<th class="text-center">작성일자</th>
			<th class="text-center">접속IP</th>
			<th></th>
		</tr>
		<c:forEach var="replyVo" items="${replyVos}">
			<tr>
				<td>${replyVo.nickName}</td>	
				<td>${fn:replace(replyVo.content, newLine, "<br/>")}</td>
				<td class="text-center">${fn:substring(replyVo.wDate, 0, fn:length(replyVo.wDate)-2)}</td>
<%-- 				<td class="text-center">${fn:substring(replyVo.wDate, 0, 19)}</td> --%>
				<td class="text-center">${replyVo.hostIp}</td>
				<td>
					<c:if test="${sLevel == 0 || sMid == replyVo.mid}">
						<a href="javascript:replyDelCheck(${replyVo.idx})" title="댓글삭제">✖</a> 
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
<!-- 댓글 출력 창 끝 -->

<!-- 댓글 입력창 시작 -->
	<%-- <form name="replyForm" method="post" action="${ctp}/boReplyInput.bo"> --%> <!-- ajax 처리할 부분이라서 사실 필요없음... ajax는 get방식...(URL에 값 담아가니까) -->
	<form name="replyForm">
		<table class="table text-center">
			<tr>
				<td style="width:85%" class="text-left">
					<b>댓글내용</b>
					<textarea rows="4" name="content" id="content" class="form-control"></textarea>
				</td>
				<td style="width:15%">
					<br/>
					<p> 작성자 : ${sNickName}</p>
					<p>
						<input type="button" value="댓글등록" onclick="replyCheck()" class="btn btn-outline-info btn-sm" />
					</p>
				</td>
			</tr>
		</table>
		
		<!-- ajax 라서 hidden으로 값 넘기는 것도 의미가 없음 -->
		<%-- <input type="hidden" name="boardIdx" value="${vo.idx}" />
		<input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
		<input type="hidden" name="mid" value="${sMid}" />
		<input type="hidden" name="nickName" value="${sNickName}" /> --%>
	</form>
<!-- 댓글 입력창 끝 -->
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>