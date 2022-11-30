package study2.ajax;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberDAO;
import member.MemberVO;
import member.NickNameCheckCommand;

@WebServlet("/idSearchTest3")
public class IdSearchTest3 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		// 여기서 받는 mid는 ajax 에서 넘겨주는 mid
		
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getLoginCheck(mid);
		
		// printwriter : 원래는 브라우저에 띄우기 위해 사용하는 객체지만, 이와 유사하게끔 데모창에 띄우도록 코드 수정
//		PrintWriter out = response.getWriter();
		
		String name = "";
		String nickName = "";
		String gender = "";
		int point = 0;
		
		if(vo == null) {
			name = "찾는 자료가 없습니다.";
		}
		else {
			name= vo.getName();
			nickName = vo.getNickName();
			gender = vo.getGender();
			point = vo.getPoint();
		}
		
		String str = mid + "/" + name + "/" + nickName+ "/" + gender+ "/" + point;
		
		// response.getWriter(): 현재 창을 의미 (demo창)
		// .write("") : 큰따옴표 안에 출력할 내용 직접 작성 or 변수넣기
//		response.getWriter().write(name);
		response.getWriter().write(str);
		
	}

}
