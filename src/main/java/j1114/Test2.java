package j1114;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j1114_Test2")
public class Test2 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("1.이곳은 /j1114_Test2 입니다.");
//		System.out.println("2.이곳은 /j1114_Test2 입니다.");
		
		request.setCharacterEncoding("utf-8");
//		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		/*
			Null 값 처리 방법 1.
			// String mid = "";
	
			if(request.getParameter("mid") != null) {
				String mid = request.getParameter("mid");
			}
			else { // 24행에 선언해두면 else문 생략 가능
				mid = "";
			}
		*/
		
		System.out.println("접속방식 : " + request.getMethod()); // 결과 : 당연히 post 방식 -> 1114/test2Res.jsp 에서 23행
		
		// 백엔드 Null 값 처리 방법 2. 삼항연산자 사용 (실무 사용 방법!!!)
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		
//		String pwd = request.getParameter("pwd");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String hostIp = request.getParameter("hostIp"); // 얘는 null 값 없기때문에 유효성검사 X
		
		
		mid = mid.trim();
		name = name.trim();
		
		PrintWriter out = response.getWriter(); // java에서 jsp 명령을 사용하려려면 printwriter 꼭 선언해야 함! 
		
		if(mid.equals("admin") && pwd.equals("1234")) {
			out.println("<script>");
			out.println("alert('관리자인증 성공!')");
			
			// 모델에 담았다 라는 의미 => ? 뒤 변수선언해서 작성하는 것
			// 진정한 모델은 VO 객체에 담는 것 (아직 안배워서 get방식으로 작성한 것)
			out.println("location.href='"+request.getContextPath()+"/study/1114/test2Res.jsp?mid="+mid+"&name="+name+"&hostIp="+hostIp+"';"); 
			// 경로 제일 뒤 ? 뒤에는 변수명 작성하는 곳 / 연결 연산자 : & / JS 끝에는 항상 ; 붙여주기 (생략가능하지만, 생략하지말기)
			out.println("</script>");
		}
		else {
			out.println("<script>");
			out.println("alert('관리자인증 실패')");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}
