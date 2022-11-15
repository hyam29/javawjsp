package j1116;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j1116/Test2/3")
public class Test2_3 extends HttpServlet {
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
		
		
		// VO에 값 저장하기
		// 1. setter 통해 vo.set으로 저장
//		Test2VO vo = new Test2VO();
//		vo.setHakbun(hakbun);
//		vo.setName(name);
//		vo.setKor(kor);
		
		// 2. 생성자를 생성해서 값 전달 (VO에 source -> generate construct using field로 생성)
		Test2VO vo = new Test2VO(name,hakbun,kor,eng,mat,soc,sci,tot,avg,grade);
		System.out.println("vo : " + vo);
		
		
		// 서버에서 get 방식으로의 전송방법
		// 1. location.href 2. a 태그 => 웹에서 내가 값 찍겠다.
		// 3. .sendRedirect() 명령 사용 (응답하는 쪽에 있음 => response)
//		response.sendRedirect(request.getContextPath()+"/study/1116/test2Ok3.jsp?hakbun="+hakbun+"&name="+name+"&kor="+kor+"&eng="+eng+"&mat="+mat+"&soc="+soc+"&sci="+sci+"&tot="+tot+"&avg="+avg+"&grade="+grade);
		response.sendRedirect(request.getContextPath()+"/study/1116/test2Ok3.jsp?vo="+vo); // get방식으로 URL에 값 넣어서 넘김 -> 타입이 모두 String (객체인 vo를 String 타입으로 넘김)
		
		
	}
}
