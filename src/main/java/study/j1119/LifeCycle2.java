package study.j1119;

import java.io.IOException;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j1119/LifeCycle2")
public class LifeCycle2 extends HttpServlet {
	@Override
	public void init() throws ServletException {
		System.out.println("--- ㅇㅣ곳은 init() 메소드 ---");
	}
	
//	@Override
//	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("--- ㅇㅣ곳은 service() 메소드 ---");
//		
//		// filter에서 한글처리 모두 했으니까 따로 작성XXX
//		
//		String title = request.getParameter("title");
//		String content = request.getParameter("content");
//		
//		System.out.println("1.title : " + title);
//		System.out.println("1.content : " + content);
//		
//		// forward 를 이용한 전송 (request에서 dispatcher 생성 -> forward)
//		request.setAttribute("1.title", title);
//		request.setAttribute("1.content", content);
//		// URL 적는 곳에 절대경로 생략 가능! (GET방식은 적어줘야 함)
//		RequestDispatcher dispatcher = request.getRequestDispatcher("/study/1119LifeCycle/test1Res.jsp");
//		dispatcher.forward(request, response);
//	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("--- ㅇㅣ곳은 doPost() 메소드 ---");
		
		// filter에서 한글처리 모두 했으니까 따로 작성XXX
		
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		System.out.println("2.title : " + title);
		System.out.println("2.content : " + content);
		
		// Get 방식으로 전송 (response에서 redirect) 
		// get 방식 전송은 절대경로를 꼭 붙여야함! (위의 forward는 알아서 찾아감...)
		response.sendRedirect(request.getContextPath()+"/study/1119LifeCycle/test1Res2.jsp?title="+title+"&content="+content);
		
	}
	
	@Override
	public void destroy() {
		System.out.println("--- ㅇㅣ곳은 destroy() 메소드..... ---");
	}
	
	// 아래 어노테이션은 생성자 직접 생성한 것! 따로 ctrl + space 로 안 뜸!
	@PostConstruct
	public void initPostConstruct() {
		System.out.println("--- ㅇㅣ곳은 @PostConstruct() ---");
	}
	
	@PreDestroy
	public void destroyPreDestroy() {
		System.out.println("--- ㅇㅣ곳은 @PreDestroy() ---");
	}
	
	
}
