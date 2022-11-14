<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>test11.jsp</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
  <script>
    'use strict';
  
    function fCheck() {
        let name = myform.name.value;
        
        if(name == "") {
            alert("이름을 입력하세요?");
            myform.name.focus();
            return false;
        }
        else {
            myform.submit();
        }
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <h2>값 전송하기(get방식)</h2>
  <!-- <form name="myform" method="get" action="../../atom/t7"> -->
  <!-- <form name="myform" method="post" action="../../test11Ok"> -->
  <!-- <form name="myform" method="post" action="../../t12"> -->
  <!-- <form name="myform" method="post" action="/javawjsp/t12"> -->
  <!-- <form name="myform" method="post" action="test12ok.jsp"> -->
  <!-- 36행처럼(경로 따로 안적고, 파일명만 적음) action 작성했다면, 
  	1. 컨트롤러가 JSP 파일 찾아봄 -> 없음
  	2. test12ok.jsp 가 있는 파일 경로 전까지 가서 찾아봄 => localhost:9090/javawjsp/study/1111/
  	3. 따라서, localhost:9090/javawjsp/study/1111/ 생략해 있다고 생각하면 됨...!
<%--   <form name="myform" method="post" action="<%=request.getContextPath() %>/t12"> --%>
  <!-- request.getContextPath = contextpath = /javawjsp 를 불러와(request)! -->
  <form name="myform" method="post" action="<%=request.getContextPath() %>/test12ok">
  <!-- ROOT에서 가는 거니까 처음 / 적어준 것. 생략해도 됨! BUT, url별명 앞 / 는 생략하면 XXX -->
    성명 : <input type="text" name="name" value="Hong Kil Dong" class="form-control"/>
    나이 : <input type="number" name="age" value="25" class="form-control"/>
    <div>
    성별 : <input type="radio" name="gender" value="남자" checked />남자
          <input type="radio" name="gender" value="여자" />여자
    </div>
    <div>
      취미 : 
		      <input type="checkbox" name="hobby" value="등산" checked>등산
		      <input type="checkbox" name="hobby" value="낚시">낚시
		      <input type="checkbox" name="hobby" value="독서">독서
		      <input type="checkbox" name="hobby" value="음악감상">음악감상
		      <input type="checkbox" name="hobby" value="수영">수영
    </div>
    <input type="button" value="전송" onclick="fCheck()" class="btn btn-success"/>
  </form>
  <hr/>
  <p>
  	<img src="../../images/2.jpg" width="300px" />
  </p>
</div>
<p><br/></p>
</body>
</html>
