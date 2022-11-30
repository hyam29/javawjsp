package study2;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("*.st")
public class StudyController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		studyInterface command = null;
		
		String viewPage = "WEB-INF/study2";
		
		String uri = request.getRequestURI();
		String com = uri.substring(uri.lastIndexOf("/"), uri.lastIndexOf("."));
		
		// 세션이 끊겼다면 작업의 진행을 중지시키고 홈으로 전송시켜 준다. (주소창에서 직접 아이디를 넘겼을 때, 홈페이지 들어가지는 것 방지)
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel") == null ? 99 : (int) session.getAttribute("sLevel"); 
		if(level > 4) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/"); // 홈페이지의 root로 보냄
			dispatcher.forward(request, response);
		}
		
		
		if(com.equals("/pass")) {
			viewPage += "/password/pass.jsp";
		}
		else if(com.equals("/passOk1")) {
			command = new PassOkCommand();
			command.execute(request, response);
			viewPage += "/password/pass.jsp";
		}
		else if(com.equals("/passOk2")) {
			command = new PassOk2Command();
			command.execute(request, response);
			viewPage += "/password/passOk2.jsp";
		}
		else if(com.equals("/ajax1")) {
			viewPage += "/ajax/ajax1.jsp";
		}
		else if(com.equals("/ajax1")) {
			viewPage += "/ajax/ajax1.jsp";
		}
		else if(com.equals("/userList")) {
			command = new UserListCommand();
			command.execute(request, response);
			viewPage += "/ajax/userList.jsp";
		}
		else if(com.equals("/userSearch")) {
			command = new UserSearchCommand();
			command.execute(request, response);
			/* viewPage += "/ajax/userList.jsp"; 이렇게 페이지이동하는 건 동기식. ajax 이므로 비동기식이니까 return으로 작업 끝내줌 */
			return;
		}
		else if(com.equals("/userDel")) {
			command = new UserDelCommand();
			command.execute(request, response);
			return;
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}
