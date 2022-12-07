<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- 파일크기 계산 위해 fmt lib 사용 -->
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pdsList.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
  	'use strict';
  	function partCheck() {
  		let part = partForm.part.value;
  		location.href = "${ctp}/pdsList.pds?part="+part;
  		// part는 위에서 변수로 받았으므로 + part로 작성! 변수로 안받았다면, $ { part }로 작성해야 함.
  	}
  	
  	function modalView(title, nickName, mid, part, fName, fSName, fSize, downNum, fDate) {
  		let imgs = fSName.split("/");
  		
  		// on("show.bs.modal", function(e) {} ): 모달에 내용을 넣는 명령어(BS에서 정해놓음)
  		$("#myModal").on("show.bs.modal", function(e) {
  			$(".modal-header #title").html(title);
  			$(".modal-header #part").html(part);
  			$(".modal-body #nickName").html(nickName);
  			$(".modal-body #mid").html(mid);
  			$(".modal-body #fName").html(fName);
  			$(".modal-body #fDate").html(fDate);
  			$(".modal-body #fSize").html(fSize);
  			$(".modal-body #downNum").html(downNum);
  			$(".modal-body #fSName").html(fSName);
  			/* $(".modal-body #imgSrc").attr("src", '${ctp}/data/pds/'+imgs[0]); // 속성 변경 명령어 (반복문 돌리기 전 0번방만 일단 꺼냄) */
  			
  			// 저장된 파일에 그림이 1장이라도 있다면 1장만 화면에 출력시켜준다.
    		$(".modal-body #imgSrc").attr("src",'');	// 기존에 존재하는 그림파일이 있으면 제거시킨다.(src값을 없앴기에 보이지 않게처리했다.)
    		for(let i=0; i<imgs.length; i++) {
    			let imgExt = imgs[i].substring(imgs[i].lastIndexOf(".")+1).toUpperCase();
    			if(imgExt=="JPG" || imgExt=="GIF" || imgExt=="PNG") {
    				$(".modal-body #imgSrc").attr("src",'${ctp}/data/pds/'+imgs[i]);
    				break;
    			}
    		}
  		});
  	}
  	
  	
  	// 다운로드 횟수 증가 처리
  	function downNumCheck(idx) {
  		$.ajax({
  			type : "post",
  			url : "${ctp}/pdsDownNum.pds",
  			data : {idx : idx},
  			success : function() {
  				location.reload();
  			},
  			error : function() {
  				alert("다운로드 전송 오류.");
  			}
  		});
  	}
  	
  	// 1.삭제 : prompt 창을 이용해 비밀번호 입력받아 선택한 항목의 자료 삭제 (ajax)
  	function pdsDelCheck(idx, fSName) {
  		let ans = confirm("선택한 자료를 삭제하시겠습니까?");
  		if(!ans) return false;
  		
  		let pwd = prompt("비밀번호를 입력하세요.");
  		let query = {
  				idx : idx,
  				fSName : fSName,
  				pwd : pwd
  		}
  		
  		$.ajax({
  			type : "post",
  			url : "${ctp}/pdsDelete.pds",
  			data : query,
  			success : function(res) {
  				if(res == "1") {
  					alert("파일이 삭제되었습니다.");
  					location.reload();
  				}
  				else {
  					alert("비밀번호가 일치하지 않습니다.");
  				}
  			},
  			error : function() {
  				alert("1.삭제 전송 오류.");
  			}
  		});
  	}
  	
 		// 2.삭제 : modal창을 통해 비밀번호 확인 후 파일 삭제 처리
 		function pdsDelCheckModal(idx,fSName,part,pag) {
    	$("#myPwdModal").on("show.bs.modal", function(e){
    		$(".modal-body #idx").val(idx);
    		$(".modal-body #fSName").val(fSName);
    		$(".modal-body #part").val(part);
    		$(".modal-body #pag").val(pag);
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<h2>* 자 료 실 리 스 트(${part}) *</h2>
	<hr/>
	<br/>
	<table class="table table-borderless">
		<tr>
			<td style="width:20%">
				<form name="partForm">
					<select name="part" onchange="partCheck()" class="form-control" >
						<option value="전체" ${part == '전체' ? 'selected' : "" }>전체</option>
						<option value="학습" ${part == '학습' ? 'selected' : "" }>학습</option>
						<option value="여행" ${part == '여행' ? 'selected' : "" }>여행</option>
						<option value="음식" ${part == '음식' ? 'selected' : "" }>음식</option>
						<option value="기타" ${part == '기타' ? 'selected' : "" }>기타</option>
					</select>
				</form>
			</td>
			<td class="text-right">
				<a href="${ctp}/pdsInput.pds?part=${part}" class="btn btn-outline-success">자료등록</a>
			</td>
		</tr>
	</table>
	<table class="table table-hover text-center">
		<tr class="table-dark text-dark">
			<th>번호</th>
			<th>자료제목</th>
			<th>올린이</th>
			<th>작성일자</th>
			<th>분류</th>
			<th>파일명(크기)</th>
			<th>다운로드 횟수</th>
			<th>비고</th>
		</tr>
		<c:forEach var="vo" items="${vos}">
			<tr>
				<td>${curScrStartNo}</td>
				<td>
          <a href="${ctp}/pdsContent.pds?idx=${vo.idx}&pag=${pag}">${vo.title}</a>
    	    <c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif"/></c:if>
        </td>
				<td>${vo.nickName}</td>
				<td>
          <%-- ${vo.fDate} --%>
					<%-- <td>${fn:substring(vo.fDate,0,16)}</td> --%>
          <c:if test="${vo.hour_diff > 24}">${fn:substring(vo.fDate,0,10)}</c:if>
          <c:if test="${vo.hour_diff < 24}">
          <!-- 24시간이 지나지 않았지만 현재시간~자정까찌는 '날짜:시간', 나머지는 '시간'만 출력 -->		
    	      ${vo.day_diff > 0 ? fn:substring(vo.fDate,0,16) : fn:substring(vo.fDate,11,19)}
    	    </c:if>
        </td>
				<td>${vo.part}</td>
				<td>
					<c:set var="fNames" value="${fn:split(vo.fName, '/')}" />
					<c:set var="fSNames" value="${fn:split(vo.fSName, '/')}" />
					<c:forEach var="fName" items="${fNames}" varStatus="st">
						<a href="${ctp}/data/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
					</c:forEach>
					(<fmt:formatNumber value="${vo.fSize/1024}" pattern="#,###" />KByte)
					<!-- 1000kb 초과시 mb고치기 -->
					<%-- <c:set var="fFSize" value="<fmt:formatNumber value="${vo.fSize/1024}" pattern="#,###" />" />
					<c:if test=""></c:if>
					(<fmt:formatNumber value="${vo.fSize/1024/1024}" pattern="#,###.0" />MB) --%>
				</td>
				<td>${vo.downNum}</td>
				<td>
					<a href="#" onclick="modalView('${vo.title}','${vo.nickName}','${vo.mid}','${vo.part}','${vo.fName}','${vo.fSName}','${vo.fSize}','${vo.downNum}','${vo.fDate}')" class="btn btn-sm btn-outline-secondary" data-toggle="modal" data-target="#myModal">모달창</a><br/>
					<!-- 앵커태그에도 onclick 가능! (현재 위치 알기위해서 앵커태그로 작성하는 것. 원래는 button이 더 많음) -->
					 전체다운로드<br/>
					 <!-- 1. JSP 함수이용 삭제방법 (값을 넘길 때, 타입이 숫자와 문자를 함께 넘기면 거의 error 따라서, 타입을 문자로 통일해서 보내줘야함) -->
					 <a href="javascript:pdsDelCheck('${vo.idx}','${vo.fSName}')" class="btn btn-sm btn-outline-warning mb-1">1.삭제</a><br/>
					 <a href="#" onclick="pdsDelCheckModal('${vo.idx}','${vo.fSName}','${part}','${pag}')" data-toggle="modal" data-target="#myPwdModal" class="btn btn-sm btn-outline-danger">2.삭제</a>
			 	</td>
			</tr>
		<c:set var="curScrStartNo" value="${curScrStartNo-1}" />
		</c:forEach>
		<tr><td colspan="9" class="m-0 p-0"></td></tr>
	</table>
</div>

<!-- 블록 페이지 시작 -->
<div class="text-center">
  <ul class="pagination justify-content-center">
    <c:if test="${pag > 1}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pageSize=${pageSize}&pag=1">첫페이지</a></li>
    </c:if>
    <c:if test="${curBlock > 0}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a></li>
    </c:if>
    <c:forEach var="i" begin="${(curBlock)*blockSize + 1}" end="${(curBlock)*blockSize + blockSize}" varStatus="st">
      <c:if test="${i <= totPage && i == pag}">
    		<li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/pdsList.pds?pageSize=${pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
      <c:if test="${i <= totPage && i != pag}">
    		<li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pageSize=${pageSize}&pag=${i}">${i}</a></li>
    	</c:if>
    </c:forEach>
    <c:if test="${curBlock < lastBlock}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize + 1}">다음블록</a></li>
    </c:if>
    <c:if test="${pag < totPage}">
      <li class="page-item"><a class="page-link text-secondary" href="${ctp}/pdsList.pds?pageSize=${pageSize}&pag=${totPage}">마지막페이지</a></li>
    </c:if>
  </ul>
</div>
<!-- 블록 페이지 끝 -->


<!-- 모달창 클릭시 자료실의 내용을 모달창에 출력한다. -->
<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <!-- <h4 class="modal-title"><span id="title"></span></h4> -->
        <h4 class="modal-title"><span id="title">모달창</span>(분류:<span id="part"></span>)</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <!-- & times; : 모달창에서의 x 버튼 -->
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        작성자 <span id="nickName"></span><br/>
        아이디 <span id="mid"></span>
        <hr/>
        파일명 <span id="fName"></span>
        파일올린일자 <span id="fDate"></span><br/>
        파일용량 <span id="fSize"></span>
        다운로드 횟수 <span id="downNum"></span>
        <hr/>
        저장파일명 <span id="fSName"></span>
				<img id="imgSrc" width="350px" />        
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>

<!-- The Modal(form태그로 비밀번호 처리하기 위한 모달) -->
<div class="modal fade" id="myPwdModal">
  <div class="modal-dialog">
    <div class="modal-content">
    
      <!-- Modal Header -->
      <div class="modal-header">
        <h4 class="modal-title">비밀번호 입력 확인</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <!-- & times; : 모달창에서의 x 버튼 -->
      </div>
      
      <!-- Modal body -->
      <div class="modal-body">
        <form name="pwdModal" method="post" action="${ctp}/pdsPwdCheck.pds" class="was-validated">
        	비밀번호
        	<input type="password" name="pwd" id="pwd" placeholder="자료실 등록시 사용한 비밀번호 입력" class="form-control mb-2" required />
        	<input type="submit" value="비밀번호 확인" class="btn btn-outline-success form-control" />
        	
        	<input type="hidden" name="idx" id="idx" />
        	<input type="hidden" name="fSName" id="fSName" />
        	<input type="hidden" name="part" id="part" />
        	<input type="hidden" name="pag" id="pag" />
        </form>     
      </div>
      
      <!-- Modal footer -->
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
      </div>
      
    </div>
  </div>
</div>

<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>