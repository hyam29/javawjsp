package pds;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.pds")
public class PdsController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PdsInterface command = null;
		
		String viewPage = "/WEB-INF/pds";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		// 세션이 끊겼다면 작업의 진행을 중지시키고 홈으로 전송시켜 준다. (주소창에서 직접 아이디를 넘겼을 때, 홈페이지 들어가지는 것 방지)
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel") == null ? 99 : (int) session.getAttribute("sLevel"); 
		
		if(level > 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/"); // 홈페이지의 root로 보냄
			dispatcher.forward(request, response);
		}
		
		else if(com.equals("/pdsList")) {
			command = new PdsListCommand();
			command.execute(request, response);
			viewPage += "/pdsList.jsp";
		}
		else if(com.equals("/pdsInput")) {
			command = new PdsInputCommand();
			command.execute(request, response);
			viewPage += "/pdsInput.jsp";
		}
		else if(com.equals("/pdsInputOk")) {
			command = new PdsInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/pdsDelete")) {
			command = new PdsDeleteCommand();
			command.execute(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
