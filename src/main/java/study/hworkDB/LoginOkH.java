package study.hworkDB;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/hworkDB/LoginOkH")
public class LoginOkH extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		
		JusorokHworkDAO dao = new JusorokHworkDAO();
		JusorokHworkVO vo = dao.loginCheck(mid, pwd);
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		if(vo.getName() != null) {
			// 회원 인증 후 처리 부분 
			/*
			 	업무분석 
			 	1. 자주 사용하는 자료를 세션에 담는다! 
			 	2. 방문포인트를 10점씩 부가. (단, 1일 방문포인트는 50점까지만 허용함) -> 조건부는 과제
			 	3. 최종 방문날짜를 현재 날짜,시간으로 변경! 
			*/
			// 1. 업무분석 세션처리
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sLastDate", vo.getLastDate().substring(0, 19));
			
			// 2. 업무분석 방문포인트 증가시키기 (10점씩, 1일 50점 까지!) 
			// + 3. 최종 방문날짜 업데이트하기
			int visitPoint = vo.getPoint() + 10;
//			dao.setVisitUpdate(visitPoint, mid); 
			
			// session 으로 들어온 값 계산해야하니까 if문 들어가야하는데 변수 선언 안하면 불편함! 따라서, visitPoint 변수 선언
//			
//			if (session.getAttribute("aVisitCnt") == null) {
//				
//			}
			
			out.print("<script>");
			out.print("alert('"+vo.getName()+"님 로그인 되었습니다. 환영해요!');");
			out.print("location.href='"+request.getContextPath()+"/hworkDB/MemberMainH';");
			out.print("</script>");
		}
		else {
			// 회원 인증 실패시 처리 부분
			out.print("<script>");
			out.print("alert('로그인에 실패하셨습니다.');");
			out.print("location.href='"+request.getContextPath()+"/study/1120_Hwork/loginH.jsp';");
			out.print("</script>");
		}
	}
}
