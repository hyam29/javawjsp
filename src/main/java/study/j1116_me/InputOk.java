package study.j1116_me;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j1116h_me/InputOk")
public class InputOk extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String name = request.getParameter("name") == null ? "" : request.getParameter("name");
		String[] products = request.getParameterValues("product");
		String[] productCodes = request.getParameterValues("productCode");
		String[] sus = request.getParameterValues("su");
		String[] prices = request.getParameterValues("price");
    String strProduct = "";
    String strCode = "";
    String strSu = "";
    String strPrice = "";
		
    for(String product : products) {
    	strProduct += product + "/";
    }
    for(String productCode : productCodes) {
        strCode += productCode + "/";
    }
    for(String su : sus) {
        strSu += su.trim() + "/";
    }
    for(String price : prices) {
        strPrice += price.trim() + "/";
    }
    
    PrintWriter out = response.getWriter();
    
    // 화폐단위에 콤마 넣기 위해 객체 생성
    DecimalFormat decimalFormat = new DecimalFormat("###,###");
    
    // 공백 아니면, 출력! 공백이면, alert로 알람창 띄우기
    if(!strProduct.equals("")) {
        strProduct = strProduct.substring(0,strProduct.length()-1);
    }
    else {
        out.println("<script>");
        out.println("alert(‎'1개 이상의 상품은 등록하셔야 합니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
    if(!strCode.equals("")) {
        strCode = strCode.substring(0,strCode.length()-1);
    }
    if(!strSu.equals("")) {
        strSu = strSu.substring(0,strSu.length()-1);
    }
    else {
        out.println("<script>");
        out.println("alert(‎'수량에 공백을 넣으셨습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
    if(!strPrice.equals("")) {
        strPrice = strPrice.substring(0,strPrice.length()-1);
    }
    else {
        out.println("<script>");
        out.println("alert(‎'가격에 공백을 넣으셨습니다.');");
        out.println("history.back();");
        out.println("</script>");
    }
    
    // 총 금액 계산
    int pTot = 0;
    for(int i=0; i<products.length; i++) {
        int su = Integer.parseInt(sus[i]);
        int price = Integer.parseInt(prices[i]);
        int tot = su * price;
        pTot += tot;
    }
    
    // VO에 값 담기
    InputVO vo = new InputVO(name,strCode,strProduct,strSu,strPrice,pTot);
//    System.out.println("vo" + vo);
    
    request.setAttribute("vo", vo);
    
    String viewPage = "/study/1116h/main.jsp";
    request.getRequestDispatcher(viewPage).forward(request, response);
	}
}
