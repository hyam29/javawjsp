<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ajax1.jsp</title>
  <jsp:include page="/include/bs4.jsp"></jsp:include>
  <script>
    'use strict';
    function idCheck() {
    	// let mid = document.getElementById("mid").value;
    	//  let mid = document.myform.mid.value;
    	let mid = $("#mid").val();
    	
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요.");
    		$("#mid").focus();
    		return false;
    	}
    	
    	location.href = "${ctp}/idSearchTest?mid="+mid;
    }
    
    
    function idCheck2() {
    	let mid = $("#mid").val();
    	
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요.");
    		$("#mid").focus();
    		return false;
    	}
    	// 일반 방식
    	/* location.href = "${ctp}/idSearchTest2?mid="+mid; */
    	
    	
    	
    	
    	
    	// aJax 방식 (제이쿼리 방식 // java => .ajax();)
    	/* 문자는 "" 둘러쌈 // 구분자는 , 로 구분
    		type(=method): ajax는 get 많이 사용
    		url (=action): 어디로 보낼지 주소 작성(서블릿)
    		data {키(변수):값, idx: idx} // 여러 변수 사용시에는 변수를 전역변수로 생성해서 작성
    		--------------------------------------- 여기까지 서버 전송구간
    		contextType: "application/json",
    		charset: "utf-8",
    		일반적으로 contextType은 json방식, charset은 utf-8이므로 위의 두줄은 생략가능
    		
    		success, error는 if와 else if 같은 느낌
    	*/
    	
    	/* let query = {mid: mid,
    							idx: idx,
    							address: address
    	} */
    	let query = {
    				mid: mid,
    	}
    	// 위의 왼쪽의 mid는 서버의 mid // 오른쪽 mid 변수는 myform의 mid 
    	
    	$.ajax({
    		url : "${ctp}/idSearchTest2",
    		type : "get",
    		data : query,
    		/* contextType: "application/json",
    		charset: "utf-8", */
    		success: function(res) {
    			alert("서버에서 아이디 검색을 성공적으로 마치고 돌아왔습니다.\n검색된 성명은 " + res);
    			$("#demo").html(res); // 자바스크립트 명령 사용 가능
    		},
    		error: function() {
    			alert("ajax 전송 실패.");
    		}
    	});
    }
    
    function idCheck3() {
    	let mid = $("#mid").val();
    	
    	if(mid.trim() == "") {
    		alert("아이디를 입력하세요.");
    		$("#mid").focus();
    		return false;
    	}
    	
    	$.ajax({
    		type : "post",
    		url : "${ctp}/idSearchTest3",
    		data : {mid: mid},
    		success: function(res) {
    			$("#demo").html(res);
    			let str = res.split("/");
    			$("#tMid").html(str[0]); // 왜 tMid 썼었지?
    			$("#name").html(str[1]);
    			$("#nickName").html(str[2]);
    			$("#gender").html(str[3]);
    			$("#point").html(str[4]);
    		},
    		error: function() {
    			alert("ajax 전송 실패.");
    		}
    	});
    }
  </script>
</head>
<body>
<jsp:include page="/include/header.jsp" />
<p><br/></p>
<div class="container">
  <h2>AJax연습</h2>
  <hr/>
  <form name="myform">
    아이디: <input type="text" name="mid" id="mid" /> &nbsp;
    <input type="button" value="아이디일반검색1" onclick="idCheck()" class="btn btn-info"/> &nbsp;
    <input type="button" value="아이디검색2" onclick="idCheck2()" class="btn btn-success"/> &nbsp;
    <input type="button" value="아이디검색3" onclick="idCheck3()" class="btn btn-warning"/> &nbsp;
    <br/>
    <div>출력결과: <span id="demo">${name}</span></div>
    <hr/>
    <p>
	    <div>아이디 : <span id="tMid"></span></div>
	    <div>성명 : <span id="name"></span></div>
	    <div>별명 : <span id="nickName"></span></div>
	    <div>성별 : <span id="gender"></span></div>
	    <div>포인트 : <span id="point"></span></div>
    </p>
  </form>
</div>
<p><br/></p>
<jsp:include page="/include/footer.jsp" />
</body>
</html>