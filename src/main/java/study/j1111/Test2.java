package study.j1111;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/T2") // 외우기! MVC(Model View Controller(Servlet))
// WebServlet : JSP의 controller (교통정리 해주는 것)
// 컨트롤러를 통하면 파일명 경로 노출이 안됨. (파일명을 찾아서 바로 불러오니까) => 보안성 상승! (JSP는 파일경로 모두 노출, servlet은 노출X)
public class Test2 extends HttpServlet {
//	private static final long serialVersionUID = 1L; // long ~ = 1L; : 코드를 직렬화 시키겠다. (코드를 물 흐르듯) -> 생략가능
//    public Test2() { // 기본생성자니까 -> 생략가능
//        super(); // 슈퍼는 -> 원래 생략가능
//    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// get 방식으로 넘겼으면 get으로 넘겨받는 것 (뭔지 정해져 있지 않으니까 매개변수 request, response 로 작성)
		response.getWriter().append("Served at: ").append(request.getContextPath());
		// 넘겨받은 응답값을 요청한 경로에 추가해서 담겠다.
	}
//	
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// post 방식도 get과 동일하게 매개변수 준 것
//		doGet(request, response); // 메소드 호출 (출력)
//	}
}
