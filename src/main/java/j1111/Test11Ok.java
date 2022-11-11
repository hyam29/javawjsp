package j1111;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/test11Ok")
public class Test11Ok extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender");
		String[] hobbys = request.getParameterValues("hobby"); // request. 누르면 자동으로 parameterValues 로 배열!!! 받아옴 !!! good~
		
		System.out.println("성명 : "+ name);
		System.out.println("나이 : "+ age);
		System.out.println("성별 : "+ gender);
		System.out.println("취미 : "+ hobbys);
		
		for (String hobby : hobbys) {
			System.out.print(hobby + " / ");
		}
	}
	
}
