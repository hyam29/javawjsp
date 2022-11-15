<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- <div class="text-center">
	<a href="main.jsp">홈으로</a> | | : 구분기호
	<a href="guest.jsp">방명록</a> |
	<a href="board.jsp">게시판</a> | board 가 게시판 통상명
	<a href="pds.jsp">자료실</a> | 자료실까지는 무조건 만들어내야 함!!! (공지사항 등 메뉴 많음)
	<a href="photo.jsp">포토갤러리</a>
	만약, if) 방명록은 자료를 불러와야하니까 servlet 다녀와서 guest.jsp에 뿌려줘야 함! 지금은 디자인만
</div> -->

<div class="text-center">
	<a href="main.jsp">홈으로</a> | 
	<a href="main.jsp?sw=guest">방명록</a> | <!-- sw는 매개변수로 임의작성 -->
	<a href="main.jsp?sw=board">게시판</a> | 
	<a href="main.jsp?sw=pds">자료실</a> | 
	<a href="main.jsp?sw=photo">포토갤러리</a>
</div>
