package study.j1114;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// 컨트롤러에게 GET, POST 방식 둘다 읽게 하는 법 중괄호{} 안에 , 구분으로 모두 작성
// if) 해커에게 공격당했을 때, form 태그 뒤 action 주소만 바꾸면 됨
@WebServlet({"/j1114_Test4", "/j1114_T4"})
public class Test4 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String name = request.getParameter("name");
		
		PrintWriter out = response.getWriter();
		
		// println = print => 어차피 view에서는 한칸 띄우든 안띄우든 안보임...!
		out.print("서블릿에서 View로 출력하기");
		out.println("hidden으로 전송된 name : " + name);
//		out.print("<p><a href='"+request.getContextPath()+"/study/1114/test4.jsp'>돌아가기</a></p>");
		out.println("<p><input type='button' value='돌아가기' onclick='location.href=\""+request.getContextPath()+"/study/1114/test4.jsp\"' /></p>");
	}
}
