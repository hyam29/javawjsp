package admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class AdMemberDelCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		/*
		 * int pag = request.getParameter("pag")==null ? 1 :
		 * Integer.parseInt(request.getParameter("pag"));
		 */
		
		AdminDAO dao = new AdminDAO();
		
		dao.setMemberDel(idx);
		
		
		/* request.setAttribute("pag", pag); */
		
		request.setAttribute("msg","adMemberDelOk"); 
		request.setAttribute("url", request.getContextPath()+"/adMemList.ad"); // 여기 끝에 ?pag= 넣어서 pag도 넘겨야함 (memListCommand처럼...) 
	}

}
