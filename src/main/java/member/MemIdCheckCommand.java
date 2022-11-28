package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MemIdCheckCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getLoginCheck(mid);
		
		// ID 중복체크
		if(vo == null) {
			// 사용 가능 ID
			request.setAttribute("res", 1);
		}
		else {
			// 사용 불가능 ID
			request.setAttribute("res", 0);
		}
		request.setAttribute("mid", mid);
	}
}
