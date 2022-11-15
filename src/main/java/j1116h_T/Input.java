package j1116h_T;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j1116h/input")
public class Input extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String sw = request.getParameter("sw");
		String product = request.getParameter("product");
		int price = Integer.parseInt(request.getParameter("price"));
		int su = Integer.parseInt(request.getParameter("su"));
		int kumaek = price * su;
		
		ProductVO vo = new ProductVO(product, price, su, kumaek, sw);
		
		System.out.println("vo(input) " + vo);
		
		request.setAttribute("vo", vo);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/study/1116h/main.jsp");
		dispatcher.forward(request, response);
	}
}
