package mamber;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NickNameCheckCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");
		
		MemberDAO dao = new MemberDAO(); 
		MemberVO vo = dao.getLoginCheck(nickName);
		 
		// 닉네임 중복체크
		if(vo == null) {
			request.setAttribute("nickRes", 1);
		}
		else {
			request.setAttribute("nickRes", 0);
		}
		request.setAttribute("nickName", nickName);
	}
}
