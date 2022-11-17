package study.j1114;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j1114_Test3Ok")
public class Test3Ok extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String[] products = request.getParameterValues("product");
		// name이 모두 동일하므로, 변수 선언 후 배열로 값 받아야 함!!! and, getParameterValue"s"!!! 
		String strProduct = "";
// 1. 향상된 for문 배열 출력
//		for(String product : products) {
//			strProduct += product.trim() + "/"; // 혹시 공백을 보내는 사람 있을 수 있으니 trim()
//		}
		
		// 2. 일반 for문 배열 출력
		for(int i=0;i<products.length;i++) {
			if(products[i].trim() != "") {
				strProduct += products[i].trim() + "/";
			}
		}
		
		PrintWriter out = response.getWriter();
		
		// 공백 아니면, 출력! 공백이면, alert로 알람창 띄우기
		if(!strProduct.equals("")) {
			strProduct = strProduct.substring(0,strProduct.length()-1);
		}
		else {
			out.println("<script>");
			out.println("alert('1개 이상의 상품은 등록하셔야 합니다.');");
			out.println("history.back();");
			out.println("</script>");
			
		}
		
		
		out.println("<p>등록하신 상품은? </p>");
		out.println("<p>"+strProduct+"</p>");
		out.println("<script>");
		out.println("alert('상품 등록 완료');");
		out.println("</script>");
		out.println("<p><a href='"+request.getContextPath()+"/study/1114/test3.jsp'>돌아가기</a>");
	}
}
