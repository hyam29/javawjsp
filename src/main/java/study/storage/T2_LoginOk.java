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
		String[] rememMid = request.getParameterValues("rememMid");
		PrintWriter out = response.getWriter();
		
		
		if(((mid.equals("admin") && pwd.equals("1234")) || (mid.equals("hkd1234") && pwd.equals("1234"))) && rememMid.equals(null)) {
			Cookie cookie = new Cookie("cMid", mid);
			
			
			for (String reMid : rememMid) {
				System.out.println("reMid : "+reMid);
			}
			
			cookie.setPath("/"); // 웹어플리케이션의 모든 URL에서 전송가능하도록 설정 (원래는 안만들어도 되는데 이거 없으면 쿠키 저장이 안됨)
			cookie.setMaxAge(60*5);
			response.addCookie(cookie);
			
			HttpSession session = request.getSession(); // 매우 많이 사용하니까 꼭 암기하기 HttpSession은 인터페이스! import!!!
			session.setAttribute("sMid", mid); // 로그인 성공한 사용자의 아이디를 세션에 저장
			
			out.print("<script>");
			out.print("alert('"+mid+"님 로그인 되셨습니다. 환영합니다!');");
			out.print("location.href='"+request.getContextPath()+"/study/1118_storage_server/t2_LoginMember.jsp';");
			out.print("</script>");
		}
//		else if() {
//			
//		}
		else {
			out.print("<script>");
			out.print("alert('아이디와 비밀번호를 확인하세요!');");
			out.print("history.back();");
			out.print("</script>");
		}
	}
}
