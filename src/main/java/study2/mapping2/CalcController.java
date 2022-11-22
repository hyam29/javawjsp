package study2.mapping2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.calc")
public class CalcController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		MappingInterface command = null;
		// MappingInterface 타입으로 인터페이스 객체 변수 선언 (마우스로 인터페이스 생성) because. 공통 메소드 만들기 위해서 => 인터페이스 생성하면 자동으로 class 생성
		
		String viewPage = "/WEB-INF/study2/mapping2";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		if(com.equals("/Calc")) {
			viewPage += "/calc.jsp";
		}
		else if(com.equals("/CalcOk")) {
			command = new CalcOkCommand(); 
			// service(계산을 수행 위한) 클래스를 생성하기 위해서 => 실제 처리를 구현할 객체 생성하기 위해 인터페이스 생성! (실무에서도 인터페이스 사용이 업무분장에 용이)
			command.execute(request, response);
			viewPage += "/calcOk.jsp";
		}
		else if(com.equals("/JuList")) {
			command = new JuListCommand(); 
			// service(계산을 수행 위한) 클래스를 생성하기 위해서 => 실제 처리를 구현할 객체 생성하기 위해 인터페이스 생성! (실무에서도 인터페이스 사용이 업무분장에 용이)
			command.execute(request, response);
			viewPage += "/juList.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
