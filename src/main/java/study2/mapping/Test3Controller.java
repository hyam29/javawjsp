package study2.mapping;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

//@WebServlet("/mapping/Test3")
@WebServlet("*.do") // 확장자 패턴 (모든 파일 인식)
// 여러개의 확장자 묶을 때, ({"*.do","*.calc"})
public class Test3Controller extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		StringBuffer url = request.getRequestURL();
		System.out.println("url : "+url);
		
		String uri = request.getRequestURI();
		System.out.println("uri : "+uri);
		
//		String com = uri.substring(uri.lastIndexOf("/")); // '/'뒤의 모든 문자열 출력할거야
//		// Command 객체 변수명 (우리끼리 약속)
//		System.out.println("con : "+com);
		
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		 // 변수명은 "file" 도 많이 사용함 (jsp file 불러오겠다는 거라서)
		System.out.println("com : "+com);
		
//		PrintWriter out = response.getWriter();
		
		String viewPage = "/WEB-INF/study2/mapping";
		// 여러개의 컨트롤러 사용할 때, /WEB-INF 제외 아래 폴더명(study2/mapping)은 빼고 변수 선언해서 폴더명 바꿔가며 작성하면 됨
		
		if(com.equals("/Test3_1")) {
			viewPage += "/test3_1.jsp";
		}
		else if(com.equals("/Test3_2")) {
			viewPage += "/test3_2.jsp";
		}
		else if(com.equals("/Test3_3")) {
			viewPage += "/test3_3.jsp";
		}
		else if(com.equals("/Test4") || com.equals("/test4"))  {
			viewPage += "/test4.jsp";
		}
		else if(com.equals("/Test4Ok")) {
			int su1 = request.getParameter("su1") == null ? 0 : Integer.parseInt(request.getParameter("su1"));
			int su2 = request.getParameter("su2") == null ? 0 : Integer.parseInt(request.getParameter("su2"));
			String opt = request.getParameter("opt") == null ? "" : request.getParameter("opt");
			// getCalc 클래스(Command)에서는 서블릿이 아니라서 request 사용 XXX -> 여기서 값 넘겨줘야 함
			
			Test4Calc t4 = new Test4Calc();
			// 연산처리 할 클래스 생성
			int res = t4.getCalc(su1, su2, opt);
			// getCalc메소드를 호출
			
			request.setAttribute("su1", su1);
			request.setAttribute("su2", su2);
			request.setAttribute("opt", opt);
			request.setAttribute("res", res);
			// VO 안만들어서 값 이렇게 넘겨야 함...!
			
			viewPage += "/test4Ok.jsp";
		}
		else {
//			out.print("<script>");
//			out.print("alert('잘못된 경로입니다.');");
//			out.print("location.href='/WEB-INF/study2/mapping/test3.jsp;"); // GET 방식xxx -> 이렇게 작성하면 404 error 무조건 컨트롤러 타고 가야함!
//			out.print("location.href='"+request.getContextPath()+"/mapping/Test3';"); // get방식으로서 response.getredirector 와 동일한 경로법> requestdispatcher와 같이 사용XXX 따라서, viewPage로!
//			out.print("</script>");
//			RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/study2/mapping/test3.jsp");
//			dispatcher.forward(request, response);
			viewPage += "/test3.jsp";
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
