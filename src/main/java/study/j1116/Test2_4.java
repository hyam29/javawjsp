package study.j1116;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j1116/Test2/4")
public class Test2_4 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String name = request.getParameter("name")==null ? "" : request.getParameter("name");
		String hakbun = request.getParameter("hakbun")==null ? "" : request.getParameter("hakbun");
		int kor = request.getParameter("kor")==null ? 0 : Integer.parseInt(request.getParameter("kor"));
		int eng = request.getParameter("eng")==null ? 0 : Integer.parseInt(request.getParameter("eng"));
		int mat = request.getParameter("mat")==null ? 0 : Integer.parseInt(request.getParameter("mat"));
		int soc = request.getParameter("soc")==null ? 0 : Integer.parseInt(request.getParameter("soc"));
		int sci = request.getParameter("sci")==null ? 0 : Integer.parseInt(request.getParameter("sci"));
		
		
		int tot = kor+eng+mat+soc+sci;
		double avg = tot / 5.0;
		int intAvg = (int)(avg / (10.0));
		String grade;
		
		switch (intAvg) {
			case 10:
			case 9:
				grade = "A";
				break;
			case 8:
				grade = "B";
				break;
			case 7:
				grade = "C";
				break;
			case 6:
				grade = "D";
				break;
			default:
				grade = "F";
		}
		
		
		// VO에 값 저장하기 (변수가 너무 많아서 VO 생성해서 값 전달)
		Test2VO vo = new Test2VO(name,hakbun,kor,eng,mat,soc,sci,tot,avg,grade);
		System.out.println("vo : " + vo);
		
		
//	// 서버에서 get 방식으로의 전송방법
//	// 1. location.href 2. a 태그 => 웹에서 내가 값 찍겠다.
//	// 3. .sendRedirect() 명령 사용 (응답하는 쪽에 있음 => response)
//	//response.sendRedirect(request.getContextPath()+"/study/1116/test2Ok3.jsp?hakbun="+hakbun+"&name="+name+"&kor="+kor+"&eng="+eng+"&mat="+mat+"&soc="+soc+"&sci="+sci+"&tot="+tot+"&avg="+avg+"&grade="+grade);
//	response.sendRedirect(request.getContextPath()+"/study/1116/test2Ok3.jsp?vo="+vo); // get방식으로 URL에 값 넣어서 넘김 -> 타입이 모두 String (객체인 vo를 String 타입으로 넘김)
		
		
		
		// 저장소(request)를 활용한 forwarding (저장소는 다른 거 사용해도 됨)
		
		// 저장소에 값 저장하기
		// => request.setAttribute(변수명1(변수명2(객체)를 담아서 갈 변수), 변수명2(처리가 끝난 객체 변수));
		// 일반적으로, 타입 변수명 = 값; 이지만, 저장소는 타입을 무시함.
		request.setAttribute("vo", vo); // 변수명1과 2 헷갈리니까 그냥 똑같이 작성 => 저장소에 값 담음(set)
		
		// forwarding 
		// => request.getRequestDispatcher(forwarding할 주소 입력 (contextPath 생략))
		// header에 값 싣기 위해서 변수에 담음! 타입은 RequestDispatcher로 선언 => 여기까지 WAS
//		RequestDispatcher dispatcher = request.getRequestDispatcher("/study/1116/test2Ok4_2.jsp");
		
		// header에 담아서 클라이언트에게 response => 여기부터 웹서버
//		dispatcher.forward(request, response);

		// 실무에서 많이 사용하는 forwarding 작성법
		// if or switch 조건문 사용해서, 변수명만 바꿔서 forwarding => frontController(프론트컨트롤러) 패턴
		String viewPage = "/study/1116/test2Ok4_2.jsp";
		request.getRequestDispatcher(viewPage).forward(request, response); // forwarding을 한줄로 합쳐서 작성
		
	}
}
