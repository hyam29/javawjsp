package study.j1111;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test12 extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender");
		String[] hobbys = request.getParameterValues("hobby"); // request. 누르면 자동으로 parameterValues 로 배열!!! 받아옴 !!! good~
		System.out.println();
		System.out.println("성명 : "+ name);
		System.out.println("나이 : "+ age);
		System.out.println("성별 : "+ gender);
		System.out.println("취미 : "+ hobbys);
		
		if(hobbys != null) {
			for (String hobby : hobbys) {
				System.out.println(hobby + " / ");
			}
		}
		else {
			System.out.println("취미가 선택되지 않았습니다.");
		}
		
		// servlet 에서 "웹"에 내용을 출력하기 위해서는 "PrintWriter"객체를 통해서 처리
		PrintWriter out = response.getWriter();
		// .getWriter() : 응답하는 메소드 를 response로 넘기겠다
		// 변수(out 책마다 다 다름)를 사용할 건데, 타입은 PrintWriter로 선언한 후 ctrl + shift + O 로 import!
		out.println("안녕... 이곳은 서블릿이야<br/>");
		out.println("성명 : "+ name + "<br/>");
		out.println("나이 : "+ age + "<br/>");
		out.println("성별 : "+ gender + "<br/>");
		out.println("취미 : "+ hobbys);
		if(hobbys != null) {
			for (String hobby : hobbys) {
				out.println(hobby + " / ");
			}
		}
		else {
//			out.println("취미가 선택되지 않았습니다.");
			out.println("<script>");
			out.println("alert('취미는 하나 이상 선택하셔야 합니다.')");
			out.println("history.back()"); // 웹에서 뒤로가기 명령! 숫자 작성한다면, -1 or -2 => 입력된 값 초기화XXX
//			out.println("location.href='/javawjsp/study/1111/test12.jsp';"); => 입력된 값 초기화 OOO
			out.println("</script>");
		}
		/* out.println("<p><a href='/javawjsp/study/1111/test12.jsp'>돌아가기</a></p>"); */
		out.println("<p><a href='"+request.getContextPath()+"/study/1111/test12.jsp'>돌아가기</a></p>"); 
		
	}
}
