package study2.mapping;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@ WebServlet("/mapping/Test1")
public class Test1Controller extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dispatcher = request.getRequestDispatcher("/mapping/Test1Ok");
//		RequestDispatcher dispatcher = request.getRequestDispatcher("\\WEB-INF\\study2\\mapping\\test1.jsp"); 
		// DOS,WINDOW 경로 표시 : \ , 리눅스 경로 표시 : / (WINDOW에서 / 를 사용하고 싶을 때, \\ <- 작성하면 됨!) but, 현재 위의 작성방법 오류남...
		System.out.println("/mapping/Test1 서블릿입니다.");
		dispatcher.forward(request, response);
	}
}
