package study.j1117;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/Green", initParams = {@WebInitParam(name="mid",value="admin"), @WebInitParam(name="pwd",value="1234"), @WebInitParam(name="className",value="총무과")}) 
// urlPatterns() : web.xml 파일에서 작성한 url-pattern 경로명 불러오는 명령어
// initParams 초기값 설정 명령어 name 은 변수명, value 는 사용자가 줄 값
public class GreenInit extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 위의 서블릿 초기값들을 불러오는 것
		String mid = getInitParameter("mid");
		String pwd = getInitParameter("pwd");
		String className = getInitParameter("className");
		
		System.out.println("아이디 : " + mid);
		System.out.println("비밀번호 : " + pwd);
		System.out.println("부서명 : " + className);
		
		request.setAttribute("mid", mid);
		request.setAttribute("pwd", pwd);
		request.setAttribute("className", className);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("/study/1117/init/green.jsp");
		dispatcher.forward(request, response);
	}
}
