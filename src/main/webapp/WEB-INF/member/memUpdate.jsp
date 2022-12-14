<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>memUpdate.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <!-- 12~13행 : 주소록 API 사용하기 위해 추가 -->
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
  <script>
	  'use strict';
	  // 회원가입폼 체크 후 서버 전송(submit) -> 프론트 유효성 검사
		let nickCheckSw = 0;
	  
	  function fCheck() {
			// 전송체크버튼으로 값이 1이면 체크완료되어 전송처리한다.
			// submitFlag 스위칭 사용으로 회원가입 최종 완료 여부 체크
	  	let submitFlag = 0;
		  
		  let regNickName = /^[가-힣]+$/;
      let regName = /^[가-힣a-zA-Z]+$/;
      let regEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
      let regURL = /^(https?:\/\/)?([a-z\d\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?$/;
      let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g;
			  
	   	// 유효성검사를 위해 폼안의 내용들을 모두 변수에 담는다.
	  	let nickName = myform.nickName.value;
	  	let name = myform.name.value;
	   	// form 에서 따로 입력하는 부분들을 한꺼번에 합쳐서 DB 저장하는 처리
	  	let email1 = myform.email1.value;
	  	let email2 = myform.email2.value;
	    let email = email1 + '@' + email2;
	    let homePage = myform.homePage.value;
	    let tel1 = myform.tel1.value;
	    let tel2 = myform.tel2.value;
	    let tel3 = myform.tel3.value;
	  	let tel = tel1 + "-" + tel2 + "-" + tel3; // 값 보내는 코드는 전송 직전에(제일 마지막에) 한꺼번에 작성
	  	
		 	// 파일에 관한 사항 체크! (파일명이 존재 -> 해당 파일을 넘김! // empty -> 'noimage.jpg'를 넘김!)
			let maxSize = 1024 * 1024 * 1; // 1MByte (1KB = 2의 10승 = 1024) 까지만 허용
			let fName = myform.fName.value;
			let ext = fName.substring(fName.lastIndexOf(".")+1); // 파일명 자르고 확장자만 가져오기
			let uExt = ext.toUpperCase(); // 확장자명 대문자로 변경
			
			// 유효성 검사체크처리한다.(필수 입력필드는 꼭 처리해야 한다.)
			if(!regNickName.test(nickName)) {
        alert("닉네임(별명)은 한글만 사용가능합니다.");
        myform.nickName.focus();
        return false;
      }
      else if(!regName.test(name)) {
        alert("성명은 2~20자의 한글, 영문만 입력가능합니다.");
        myform.name.focus();
        return false;
      }
      else if(!regEmail.test(email)) {
        alert("이메일 형식에 맞지않습니다.");
        myform.email1.focus();
        return false;
      }
      else if((homePage != "http://" && homePage != "")) {
        if(!regURL.test(homePage)) {
	        alert("작성하신 홈페이지 주소가 URL 형식에 맞지않습니다.");
	        myform.homePage.focus();
	        return false;
        }
        else {
	    	  submitFlag = 1;
	      }
      }
			
			// 선택사항인 전화번호가 입력되어서 전송되었다면 전화번호형식을 체크해 준다.
      if(tel2 != "" || tel3 != "") {
	    	if(!regTel.test(tel)) {
	        alert("전화번호 형식에 맞지않습니다.(000-0000-0000)");
	        myform.tel2.focus();
	        return false;
	      }
	      else {
	    	  submitFlag = 1;
	      }
      }
      else {	
    	  // 전화번호를 입력하지 않을시 DB에는 '010- - '의 형태로 저장하고자 한다.
    	  tel2 = " ";
    	  tel3 = " ";
    	  tel = tel1 + '-' + tel2 + '-' + tel3;
    	  submitFlag = 1;
      }
			
	   	// 전송전에 '주소'를 하나로 묶어서 전송처리 준비한다.
			let postcode = myform.postcode.value + " ";
			let roadAddress = myform.roadAddress.value + " ";
			let detailAddress = myform.detailAddress.value + " ";
			let extraAddress = myform.extraAddress.value + " ";
			myform.address.value = postcode + "/" + roadAddress + "/" + detailAddress + "/" + extraAddress + "/";
		
			// 전송전에 파일에 관한 사항체크...(회원사진의 내역이 비었으면 noimage를 hidden필드인 photo필드에 담아서 전송한다.)
			if(fName.trim() == "") {
				myform.photo.value = "noimage"; // 확장자명은 백엔드에서 noimage일 경우 자동으로 noimage.jpg 불러오려고 빼고 작성
				submitFlag = 1;
			}
			else {
				/*
					1. 파일 용량(size) 체크 (용량이 크면 서버가 죽음)
					2. 사진파일이니까, 그림파일만(포맷형식) 허용가능해야 함! (포맷형식 : jpg,png,gif)
				*/
				let fileSize = document.getElementById("file").files[0].size; 
				// 무조건 id명으로(value) 값 불러와야 함!!! (name은 X(JS약속임...)) // .size : 사이즈 비교위한 JS 명령어
				
				if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JEPG") {
					alert("파일 확장자는 'JPG/GIF/PNG/JEPG'만 사용 가능합니다.");
					return false;
				}
				else if(fName.indexOf(" ") != -1) { // 파일명에 공백이 포함되어 있어?
					alert("파일명은 공백을 포함할 수 없습니다.");
					return false;
				}
				else if(fileSize > maxSize) {
					alert("업로드 파일 크기는 1MByte를 초과할 수 없습니다.");
					return false;
				}
				submitFlag = 1;
			}
			
			// 전송 전 모든 체크 끝났다면, submitFlag가 1이 되도록 처리 후 서버로 전송!
			if(submitFlag == 1){
				/* if(nickName != '${sNickName}') */
				if(nickName == '${sNickName}') {
					myform.nickDuplication.value = "nickCheck";
					nickCheckSw = 1;
				}
				if(nickCheckSw == 0) {
					myform.nickDuplication.value = "nickUnCheck";
					alert("닉네임(별명) 중복체크를 해주세요!")
				  document.getElementById("nickName").focus();
					return;				
				}
				/* if(nickCheckSw == 0) {
					alert("닉네임 중복체크버튼을 눌러주세요.");
					document.getElementById("nickNameBtn").focus();
				} */
				else {
					// 묶여진 필드(email/tel)를 폼태그안에 hidden태그의 값으로 저장시켜준다.
	  			myform.email.value = email;
	  			myform.tel.value = tel;
  			
	  			myform.submit();
				}
			}
					
			else {
				alert("정보수정에 실패하였습니다.");	
			}
	  }
	  
	// 닉네임 중복체크
	  function nickCheck() {
		  let nickName = myform.nickName.value;
		  let url = "${ctp}/nickNameCheck.mem?nickName="+nickName;
		  
		  if(nickName.trim() == "") {
			  alert("닉네임(별명)을 입력하세요.");
			  myform.nickName.focus();
		  }
		  else {
			  window.open(url, "nWin", "width=580px, height=250px");
			  nickCheckSw = 1;
		  }
	  }
		// 닉네임 재입력 중복체크 버튼활성화
	  function reNickCheck() {
		  let nickCheckBtn = document.myform.nickNameBtn;
		  myform.nickDuplication.value = "nickUnCheck";
		  nickNameBtn.disabled = false;
		  nickNameBtn.style.opacity = 1;
		  nickNameBtn.style.cursor = "pointer";
	  }
	  
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
	<form name="myform" method="post" action="${ctp}/memUpdateOk.mem" class="was-validated" enctype="multipart/form-data">
    <h2>회원 정보 수정</h2>
    <br/>
    <div class="form-group">
      아이디 ${sMid}
    </div>
    <div class="form-group">
      <label for="nickName">닉네임 &nbsp; &nbsp;
    	<input type="button" value="닉네임 중복체크" name="nickNameBtn" id="nickNameBtn" class="btn btn-secondary btn-sm" onclick="nickCheck()"/></label>
      <input type="text" value="${vo.nickName}" class="form-control" id="nickName" onkeydown="reNickCheck()" placeholder="별명을 입력하세요." name="nickName" required />
    </div>
    <div class="form-group">
      <label for="name">성명</label>
      <input type="text" value="${vo.name}" class="form-control" id="name" placeholder="성명을 입력하세요." name="name" required />
    </div>
    <div class="form-group">
      <label for="email1">Email address</label>
				<div class="input-group mb-3">
				  <input type="text" value="${email1}" class="form-control" placeholder="Email을 입력하세요." id="email1" name="email1" required />
				  <div class="input-group-append">
				    <select name="email2" class="custom-select">
					    <option value="gmail.com"   <c:if test="${email2=='gmail.com'}">selected</c:if>>gmail.com</option>
					    <option value="daum.net"    <c:if test="${email2=='daum.net'}">selected</c:if>>daum.net</option>
					    <option value="naver.com"   <c:if test="${email2=='naver.com'}">selected</c:if>>naver.com</option>
					    <option value="nate.com"    <c:if test="${email2=='nate.com'}">selected</c:if>>nate.com</option>
					    <option value="hotmail.com" <c:if test="${email2=='hotmail.com'}">selected</c:if>>hotmail.com</option>
					    <option value="yahoo.com"   <c:if test="${email2=='yahoo.com'}">selected</c:if>>yahoo.com</option>
					  </select>
				  </div>
				</div>
	  </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">성별</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="남자" <c:if test="${vo.gender=='남자'}">checked</c:if>>남자
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="gender" value="여자" <c:if test="${vo.gender=='여자'}">checked</c:if>>여자
			  </label>
			</div>
    </div>
    <div class="form-group">
      <label for="birthday">생일</label>
      <!-- datetime now 할 필요없이 value 값 넣으면 오늘날짜로 자동으로 달력에 뜸(JAVA명령) -->
      <input type="date" name="birthday" value="${birthday}" class="form-control"/>
    </div>
    <div class="form-group">
      <div class="input-group mb-3">
	      <div class="input-group-prepend">
	        <span class="input-group-text">전화번호</span> &nbsp;&nbsp;
			      <select name="tel1" class="custom-select">
					    <option value="010" ${tel1=="010" ? "selected" : ""}>010</option>
					    <option value="02"  ${tel1=="02"  ? "selected" : ""} >서울</option>
					    <option value="031" ${tel1=="031" ? "selected" : ""} >경기</option>
					    <option value="032" ${tel1=="032" ? "selected" : ""} >인천</option>
					    <option value="041" ${tel1=="041" ? "selected" : ""} >충남</option>
					    <option value="042" ${tel1=="042" ? "selected" : ""} >대전</option>
					    <option value="043" ${tel1=="043" ? "selected" : ""} >충북</option>
			        <option value="051" ${tel1=="051" ? "selected" : ""} >부산</option>
			        <option value="052" ${tel1=="052" ? "selected" : ""} >울산</option>
			        <option value="061" ${tel1=="061" ? "selected" : ""} >전북</option>
			        <option value="062" ${tel1=="062" ? "selected" : ""} >광주</option>
					  </select>-
	      </div>
	      <input type="text" name="tel2" value="${tel2}" size=4 maxlength=4 class="form-control"/>-
	      <input type="text" name="tel3" value="${tel3}" size=4 maxlength=4 class="form-control"/>
	    </div> 
    </div>
    <div class="form-group">
      <label for="address">주소</label>
			<input type="hidden" name="address" id="address">
			<div class="input-group mb-1">
				<input type="text" name="postcode" value="${postcode}" id="sample6_postcode" placeholder="우편번호" class="form-control">
				<div class="input-group-append">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" class="btn btn-secondary">
				</div>
			</div>
			<input type="text" name="roadAddress" value="${roadAddress}" id="sample6_address" size="50" placeholder="주소" class="form-control mb-1">
			<div class="input-group mb-1">
				<input type="text" name="detailAddress" value="${detailAddress}" id="sample6_detailAddress" placeholder="상세주소" class="form-control"> &nbsp;&nbsp;
				<div class="input-group-append">
					<input type="text" name="extraAddress" value="${extraAddress}" id="sample6_extraAddress" placeholder="참고항목" class="form-control">
				</div>
			</div>
    </div>
    <div class="form-group">
	    <label for="homepage">Homepage address</label>
	    <input type="text" class="form-control" name="homePage" value="${vo.homePage}" placeholder="홈페이지를 입력하세요." id="homePage"/>
	  </div>
    <div class="form-group">
      <label for="name">직업</label>
      <select class="form-control" id="job" name="job">
        <option ${vo.job=="학생" ? "selected" : ""}>학생</option>
        <option ${vo.job=="회사원" ? "selected" : ""}>회사원</option>
        <option ${vo.job=="공무원" ? "selected" : ""}>공무원</option>
        <option ${vo.job=="군인" ? "selected" : ""}>군인</option>
        <option ${vo.job=="의사" ? "selected" : ""}>의사</option>
        <option ${vo.job=="법조인" ? "selected" : ""}>법조인</option>
        <option ${vo.job=="세무인" ? "selected" : ""}>세무인</option>
        <option ${vo.job=="자영업" ? "selected" : ""}>자영업</option>
        <option ${vo.job=="기타" ? "selected" : ""}>기타</option>
      </select>
    </div>
    <div class="form-group">
      <!-- <div class="form-check-inline">
        <span class="input-group-text">취미</span> &nbsp; &nbsp;
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="등산" name="hobby"/>등산
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="낚시" name="hobby"/>낚시
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="수영" name="hobby"/>수영
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="독서" name="hobby"/>독서
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="영화감상" name="hobby"/>영화감상
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="바둑" name="hobby"/>바둑
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="축구" name="hobby"/>축구
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="checkbox" class="form-check-input" value="기타" name="hobby" checked/>기타
			  </label>
			</div>
    </div> -->
    취미 : 
    <c:set var="varHobbys" value="${fn:split('등산/낚시/수영/독서/영화감상/바둑/축구/기타','/')}"/>
    <c:forEach var="tempHobby" items="${varHobbys}" varStatus="st"> &nbsp; &nbsp;
      <input type="checkbox" class="form-check-input" value="${tempHobby}" name="hobby" <c:if test="${fn:contains(hobby,varHobbys[st.index])}">checked</c:if>/>${tempHobby} &nbsp;
    </c:forEach>
    </div>
    <div class="form-group">
      <label for="content">자기소개</label>
      <textarea rows="5" class="form-control" id="content" name="content" placeholder="자기소개를 입력하세요.">${vo.content}</textarea>
    </div>
    <div class="form-group">
      <div class="form-check-inline">
        <span class="input-group-text">정보공개</span>  &nbsp; &nbsp; 
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="공개" ${vo.userInfor=='공개' ? "checked" : ""}/>공개
			  </label>
			</div>
			<div class="form-check-inline">
			  <label class="form-check-label">
			    <input type="radio" class="form-check-input" name="userInfor" value="비공개" ${vo.userInfor=='비공개' ? "checked" : ""}/>비공개
			  </label>
			</div>
    </div>
    <div class="form-group">
      회원 사진(파일용량:1MByte이내)
      <img src="${ctp}/data/member/${vo.photo}" width="100px"/>
      <input type="file" name="fName" id="file" class="form-control-file border"/>
    </div>
    <button type="button" class="btn btn-outline-primary" onclick="fCheck()">회원정보 수정</button> &nbsp;
    <button type="reset" class="btn btn-outline-warning">다시작성</button> &nbsp;
    <button type="button" class="btn btn-outline-secondary" onclick="location.href='${ctp}/memMain.mem';">돌아가기</button>
    
    <!-- 사진 업로드 X -> noimage.jpg 넘기기 위해 hidden input 생성 -->
    <!-- 주소는 주소부분에 hidden type으로 만들어 뒀음 -->
    <input type="hidden" name="photo" value="${vo.photo}" />
    <input type="hidden" name="tel" />
    <input type="hidden" name="email" />
    <input type="hidden" name="nickDuplication" value="nickUnCheck" />
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>