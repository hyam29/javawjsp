package study.storage;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/study/storage/T2_LoginOk")
public class T2_LoginOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		String rememMid = request.getParameter("rememMid") == null ? "" : request.getParameter("rememMid");
		
		PrintWriter out = response.getWriter();
		
		Cookie cookie = new Cookie("cMid", mid);
		
		if((mid.equals("admin") && pwd.equals("1234")) || (mid.equals("hkd1234") && pwd.equals("1234"))) {
			HttpSession session = request.getSession(); // 매우 많이 사용하니까 꼭 암기하기 HttpSession은 인터페이스! import!!!
			session.setAttribute("sMid", mid); // 로그인 성공한 사용자의 아이디를 세션에 저장
			
			if(rememMid.equals("on")) {
				cookie.setPath("/"); // 웹어플리케이션의 모든 URL에서 전송가능하도록 설정 (저장경로가 안맞아서 전체 경로에서 탐색가능하도록 "/" 추가)
				// 만약 특정경로만 저장하고 싶다면 큰따옴표"" 안에 폴더명 넣으면 됨
				cookie.setMaxAge(60*5);
				response.addCookie(cookie);
//				session.setAttribute("sw", 1); // 스위치 값 session 저장 후 로그아웃에서 쿠키삭제 가능
			}
			else {
				cookie.setMaxAge(0);
				cookie.setPath("/"); 
				response.addCookie(cookie);
				session.setAttribute("sMid", mid);
//				System.out.println("rememMid : "+rememMid);
			}
			
			int visitCnt = 0;
			
			if(session.getAttribute("sVisitCnt")==null) {
				session.setAttribute("sVisitCnt", 1);
			}
			else {
				visitCnt += (int) session.getAttribute("sVisitCnt");
				session.setAttribute("sVisitCnt", visitCnt);
			}
			
		
			out.print("<script>");
			out.print("alert('"+mid+"님 로그인 되셨습니다. 환영합니다!');");
			out.print("location.href='"+request.getContextPath()+"/study/1118_storage_server/t2_LoginMember.jsp';");
			out.print("</script>");
		}
		else {
			out.print("<script>");
			out.print("alert('관리자 아이디와 비밀번호가 틀립니다!');");
			out.print("history.back();");
			out.print("</script>");
		}
	}
}
