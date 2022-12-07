package pds;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsSearchCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String search = request.getParameter("search") == null ? "" : request.getParameter("search");
		String searchString = request.getParameter("searchString") == null ? "" : request.getParameter("searchString");
		int pageSize = request.getParameter("pageSize")==null ? 5 : Integer.parseInt(request.getParameter("pageSize"));
		int pag = request.getParameter("pag")==null ? 1 : Integer.parseInt(request.getParameter("pag"));
		
		// 글제목, 글쓴이, 글내용
		// 실제 직접 입력한 값 도 request에 담아서 넘겨줘야 함
		
		PdsDAO dao = new PdsDAO();
		
		ArrayList<PdsVO> vos = dao.getPdsContentSearch(search, searchString);
		
		String searchTitle = "";
		if(search.equals("title")) searchTitle = "자료제목";
		else searchTitle = "올린이";
		
		request.setAttribute("vos", vos);
		request.setAttribute("search", search);
		request.setAttribute("searchString", searchString);
		request.setAttribute("pag", pag);
		request.setAttribute("pageSize", pageSize);
		
		// 사용자에게 검색된 총 건수 알려주기 위해 vos의 크기를 변수에 담아줌
		request.setAttribute("searchCount", vos.size());
		// vos 담긴 값들을 다시 한글화 작업
		request.setAttribute("searchTitle", searchTitle);
	}

}
