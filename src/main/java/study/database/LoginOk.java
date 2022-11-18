package study.database;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/database/LoginOk")
public class LoginOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		
		JusorokDAO dao = new JusorokDAO();
		
//		String name = dao.loginCheck(mid, pwd); // 아이디와 비밀번호를 넘겨서 DAO 에서 로그인 체크할 것
		// DAO에서 값 넘겼을 때, 값 넘겨받을 변수명 미리 작성 => name (return 으로 넘겨줄 변수명) (_님 로그인하셨어요)
		
		// name 외 여러 값 담아오고 싶을 때는 VO에 담아오는 게 좋음
		
		JusorokVO vo = dao.loginCheck(mid, pwd);
		
		HttpSession session = request.getSession();
		// application 인터페이스는 ServletContext에 존재!!! 따라서, ServletContext 생성하면 사용 가능
		
		PrintWriter out = response.getWriter();
		
		if(vo.getName() != null) {
			// 회원 인증 후 처리 부분 
			/*
			 	업무분석 
			 	1. 자주 사용하는 자료를 세션에 담는다! 
			 	2. 방문포인트를 10점씩 부가. (단, 1일 방문포인트는 50점까지만 허용함) -> 조건부는 과제
			 	3. 최종 방문날짜를 현재 날짜,시간으로 변경! 
			 	 -> (2, 3번 작업 동시에 가능...! 만약 헷갈린다면 따로 하기)
			*/
			// 1. 업무분석 세션처리
			// 아이디는 저장을 해둬야 함. application은 서버 닫을 때 까지 메모리를 차지! 따라서, 사용X -> 메모리 날리는 것이 좋음 따라서, 아이디 저장은 session 저장소가 좋음
			session.setAttribute("sMid", mid);
			// mid는 이미 생성(28행) 했어서 mid로 그냥 작성. vo.get으로 불러와도 됨 (vo에도 DAO에서 담아뒀으니까)
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sLastDate", vo.getLastDate().substring(0, 19));
			
			// 2. 업무분석 방문포인트 증가시키기 (10점씩, 1일 50점 까지!) 
			// + 3. 최종 방문날짜 업데이트하기
			int visitPoint = vo.getPoint() + 10;
			dao.setVisitUpdate(visitPoint, mid); 
			// session 으로 들어온 값 계산해야하니까 if문 들어가야하는데 변수 선언 안하면 불편함! 따라서, visitPoint 변수 선언
			
			out.print("<script>");
			out.print("alert('"+vo.getName()+"님 로그인 되었습니다. 환영해요!');");
			out.print("location.href='"+request.getContextPath()+"/database/MemberMain';");
			out.print("</script>");
			
			// member.jsp로 가게끔 44행 대신 서블릿 생성
			// 아래 명령어를 사용시, alert 창이 안뜸! (서블릿으로 바로 보내는 명령어라서!)
//			response.sendRedirect(request.getContextPath()+"/database/MemberMain");
		}
		else {
			// 회원 인증 실패시 처리 부분
			out.print("<script>");
			out.print("alert('로그인에 실패하셨습니다.');");
			out.print("location.href='"+request.getContextPath()+"/study/1120_Database/login.jsp';");
			/*
				history.back() -> 바로 전단계로 가는 것.
				JSP -> JSP 돌아갈 때는 history 사용 가능!
				but, 서블릿을 거쳐오면 경로 무한루프 돌아감!!!!!!
				!!! 위의 경우는 서블릿을 거쳐온 것이기 때문에 location.href 사용해야 함
				
				response.sendRedirect("이동할페이지"); = 위의 방법과 동일
				메시지 띄우려면 pageContext.forward("이동할페이지"); ???
			*/
			out.print("</script>");
		}
	}
}
