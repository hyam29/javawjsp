package study.j1116h;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({"/j1116h/Main","/M","/m"})
public class Main extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String sw = request.getParameter("sw")==null ? "main" : request.getParameter("sw");
		
		String product = request.getParameter("product")==null ? "" : request.getParameter("product");
		int price = (request.getParameter("price").equals("") || request.getParameter("price")==null) ? 0 : Integer.parseInt(request.getParameter("price"));
		// price는 공백비교와 null값 비교 동시에 가능한 것도 보여주려고 작성하심! (하나만 해도 됨)
		int su = request.getParameter("su").equals("") ? 0 : Integer.parseInt(request.getParameter("su"));
		int kumaek = price * su;
		
		ProductVO vo = new ProductVO(product, price, su, kumaek, sw);
		
		// viewPage 조건문으로 뿌리는 곳 다르게 설정하기 (여기부분 제일 중요) => 컨트롤러 하나로 집약시키기 위해 프론트컨트롤러 작성
		// DAO((DB) 처리하는 코드는 빠져있음 -> 이것까지 있어야 완벽한 프론트컨트롤러 지금은 흉내내기식!
		String viewPage = "/study/1116h2";
		if(sw.equals("input")) viewPage += "/input.jsp";
		else if(sw.equals("list")) viewPage += "/list.jsp";
		else if(sw.equals("photo")) viewPage += "/photo.jsp";
		else viewPage += "/main.jsp";
		
		request.setAttribute("vo", vo);
		// response.sendRidirect 사용XXX -> setAttribute 사용!
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
		// 위 두줄은 아래 한줄로도 작성OOOO
//		request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
