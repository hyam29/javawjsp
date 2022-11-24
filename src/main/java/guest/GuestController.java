package guest;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.gu")
public class GuestController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestInterface command = null;
		String viewPage = "/WEB-INF/guest";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		if(com.equals("/guList")) {
			command = new GuListCommand();
			command.execute(request, response);
			viewPage += "/guList.jsp";
		}
		else if(com.equals("/guInput")) { // 누구나 글 작성 가능하니까, service 객체가 따로 필요가 없어서 command 생성 불필요 (만약, 회원조회 리스트에서 관리를 해야한다면 처리할 부분이 생기니까 command도 생성해야 함)
			viewPage += "/guInput.jsp";
		}
		else if(com.equals("/guInputOk")) {
			command = new GuInputOkCommand();
			command.execute(request, response);
			// viewPage += "/guList.jsp"; // jsp로 바로 보내면 수정된 DB 값을 가지고 가지 않음. guList 컨트롤러로 보내야 함.
			// viewPage = request.getContextPath()+"/guList.gu"; // 대화형 뷰를 만들기 위해 아래와 같이 작성해야 함
			viewPage = "/include/message.jsp"; 
			// message가 중요하다면 WEB-INF 폴더 안에 생성해야 함! 메세지 창 띄우니까 viewPage 부등호 += XXX = OOO
			// 메세지를 띄울거면 command 생성하는 게 좋음
		}
		else if(com.equals("/adminLogin")) { 
			viewPage += "/adminLogin.jsp";
		}
		else if(com.equals("/adminLoginOk")) {
			command = new AdminLoginOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp"; 
		}
		else if(com.equals("/adminLogout")) {
			command = new AdminLogoutCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp"; 
		}
		else if(com.equals("/guDelete")) {
			command = new GuDeleteCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp"; 
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
	
}
