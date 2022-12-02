package study2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import study2.ajax.UserDAO;
import study2.ajax.UserVO;

public class UserDelCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		
		UserDAO dao = new UserDAO();
		
		String res = dao.setUserDel(mid);
		// 숫자를 넘겨도 어차피 문자열로 넘어감 but, 가끔 400번 타입에러 남... 따라서, res 타입 int -> String으로 변경
		
		response.getWriter().write(res); 
	}

}
