package j1117;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/j1117/Test1Ok")
public class Test1Ok extends HttpServlet{
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// null값 처리 해야하지만 안 함...! 나중에 꼭 해두기
		String name = request.getParameter("name");
		int age = Integer.parseInt(request.getParameter("age"));
		String gender = request.getParameter("gender");
		String job = request.getParameter("job");
		String address = request.getParameter("address");
		
		/*
		PrintWriter out = response.getWriter();
		
		out.print("<p>성명 : " + name + "</p>");
		out.print("<p>나이 : " + age + "</p>");
		out.print("<p>성별 : " + gender + "</p>");
		out.print("<p>직업 : " + job + "</p>");
		out.print("<p>주소 : " + address + "</p>");
		out.print("<p><a href='"+request.getContextPath()+"/study/1117/jspaction/test1.jsp'>돌아가기</a></p>");
		*/
		
		// 정상처리 된 data 를 VO에 넣어줌
		Test1VO vo = new Test1VO();
		
		vo.setName(name);
		vo.setAge(age);
		vo.setGender(gender);
		vo.setJob(job);
		vo.setAddress(address); // 여기까지가 백엔드 부분
		
		request.setAttribute("vo", vo);
		
		request.getRequestDispatcher("/study/1117/jspaction/test1Ok.jsp").forward(request, response);
		
	}
}
