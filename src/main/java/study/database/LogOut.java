package study.database;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/database/LogOut")
public class LogOut extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// DB 연결을 끊어줘야 함.
		JusorokDAO dao = new JusorokDAO();
		dao.logout();
		
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("sName");
		// if) 알림창에 메시지 띄우고 싶으면, invalidate(세션 닫기) 하기 전 아이디와 성명을 변수로 받아둬야 함!
		session.invalidate();
		
		
		PrintWriter out = response.getWriter();
		out.print("<script>");
		out.print("alert('"+name+"님 로그아웃 되었습니다. 좋은 하루 되세요!');");
		out.print("location.href='"+request.getContextPath()+"/study/1120_Database/login.jsp';");
		out.print("</script>");
	}
}
