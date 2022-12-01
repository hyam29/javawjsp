package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoContentCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		int pageSize = request.getParameter("pageSize") == null ? 0 : Integer.parseInt(request.getParameter("pageSize"));
		int pag = request.getParameter("pag") == null ? 0 : Integer.parseInt(request.getParameter("pag"));
		
		
		BoardDAO dao = new BoardDAO();
		
		// 조회수 증가 처리
		dao.setReadNumPlus(idx);
		
		BoardVO vo = dao.getBoContentSearch(idx);
		
		request.setAttribute("vo", vo);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pag", pag);
		
	}

}
