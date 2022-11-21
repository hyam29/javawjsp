package study.hworkDB;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/hworkDB/SearchMidH")
public class SearchMidH extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		
		JusorokHworkDAO dao = new JusorokHworkDAO();
		
		JusorokHworkVO vo = dao.getMemberSearch(mid);
		
		PrintWriter out = response.getWriter();
		
		
		if(vo.getMid() != null) {
			request.setAttribute("vo", vo);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/study/1120_Hwork/memberSearchH.jsp");
			dispatcher.forward(request, response);
		}
		else {
			// 찾고자 하는 회원 없을 시
			out.print("<script>");
			out.print("alert('입력하신 아이디가 없습니다.');");
			out.print("location.href='"+request.getContextPath()+"/study/1120_Hwork/memberH.jsp';");
			out.print("</script>");
		}     
	}
}
