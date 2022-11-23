package guest;

import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GuInputOkCommand implements GuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String email = request.getParameter("email") == null ? "" : request.getParameter("email");
		String homePage = request.getParameter("homePage") == null ? "" : request.getParameter("homePage");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		String hostIp = request.getParameter("hostIp") == null ? "" : request.getParameter("hostIp");
		
		// 성명에 태그 사용 금지 처리
		name = name.replace("<", "&lt;");
		name = name.replace(">", "&gt;");
		
		GuestDAO dao = new GuestDAO();
		GuestVO vo = new GuestVO();
	
		String regEmail = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$";
		
		if(Pattern.matches(regEmail, email)) {
			vo.setEmail(email);
		}
		else {
			vo.setEmail("");
		}

		vo.setName(name);
//		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		
		int res = dao.setGuInput(vo); // setGuInput은 내가 만든 것 (DAO 메소드 이름)
		
		// 여기서는 직렬화구간이므로 script 작성 XXX 따라서, alert 작성하면 안됨. 일단 컨트롤러로 무조건 가야 함.
		if(res == 1) {
			request.setAttribute("msg", "guInputOk");
			request.setAttribute("url", request.getContextPath()+"/guList.gu");
		}
		else {
			// 여기서는 직렬화구간이므로 script 작성 <h2><b><font color="red">장난치면 죽.는.다.</b></h2>XXX 따라서, alert 작성하면 안됨. 일단 컨트롤러로 무조건 가야 함.
			request.setAttribute("msg", "guInputNo");
			request.setAttribute("url", request.getContextPath()+"/guInput.gu");
			
		}
	}
}
