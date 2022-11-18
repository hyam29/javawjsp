package study.database;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/database/MemberList")
public class MemberList extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// DAO 거치지 않고, 바로 DB에서 자료만 보내주면 안되나요? -> NONO. service는 값 받는 게 없어도 충실하게 중계자 역할 수행위해 생성해야 함.
		JusorokDAO dao = new JusorokDAO();
		
		ArrayList<JusorokVO> vos = dao.getMemberList(); // membersearch는 id만 가져옴! list는 전체를 불러야하기 때문에 다시 dao 만들어야 함. 값들이 여러개니까 배열에 담아야하니까 arraylist 생성해서 JusorokVO 타입!
		request.setAttribute("vos", vos);
		
		//RequestDispatcher dispatcher = request.getRequestDispatcher("/study/1120_Database/memberList.jsp"); // request에 속성 담았으니까 dispatcher로 보내야함!
		RequestDispatcher dispatcher = request.getRequestDispatcher("/study/1120_Database/memberList.jsp"); // request에 속성 담았으니까 dispatcher로 보내야함!
		//requestDispatcher를 사용하면, request.getContextPath() 작성하면 XXX -> 왜?
		dispatcher.forward(request, response);
	}
}
