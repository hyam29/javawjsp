package study.database;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/database/MemberMain")
public class MemberMain extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		JusorokDAO dao = new JusorokDAO();
		
		JusorokVO vo = dao.getMemberSearch(mid); // 회원조회를 아이디로 함. 아이디가 중복되면 안됨! -> 중복체크 필수가 됨
		System.out.println("point : " + vo.getPoint());
		request.setAttribute("point", vo.getPoint());
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/study/1120_Database/member.jsp");
		dispatcher.forward(request, response);
	}
}
