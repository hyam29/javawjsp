package study.database;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/database/JoinOk")
public class JoinOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		
		PrintWriter out = response.getWriter();
		
		JusorokVO vo = new JusorokVO();

		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setName(name);
		
		JusorokDAO dao = new JusorokDAO();
		// 아이디 중복체크 -> 수업 빨리 끝나면 같이하고 아니면 과제
		
		// 중복체크 후 정상 자료일 경우, DB에 저장!!!
		int res = dao.setJoinOk(vo);
		
		if(res == 1) { 
			// 정상처리 됨 (이렇게 작성해도 됨)
			out.print("<script>"
								+ "alert('회원가입 완료! "+mid+"님 환영합니다!');"
								+ "location.href='"+request.getContextPath()+"/study/1120_Database/login.jsp';"
								+ "</script>");
		}
		else {
			// 비정상
			out.print("<script>");
			out.print("alert('회원가입 실패. 입력하신 정보를 다시 확인해주세요.');");
			out.print("location.href='"+request.getContextPath()+"/study/1120_Database/join.jsp';");
			out.print("</script>");
		}
	}
}
