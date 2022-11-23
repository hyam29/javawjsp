package guest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GuDeleteCommand implements GuestInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestDAO dao = new GuestDAO();
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		// 여기까지는 해커 침입 방지 처리 X
		if(idx != 0) {
			int res = dao.setGuDelete(idx); // DAO 이름은 내가 생성, 확인 거쳐야하니 res 변수에 담기
			
			if(res == 1) {
				request.setAttribute("msg", "guDeleteOk");
			}
			else {
				request.setAttribute("msg", "guDeleteNo");
			}
			request.setAttribute("url", request.getContextPath()+"/guList.gu");
		}
	}
}

