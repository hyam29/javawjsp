package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemUpdateCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = dao.getLoginCheck(mid);

		// JSP Form에 출력을 위한 분리작업 처리
		// email 분리 (@)
		String[] email = vo.getEmail().split("@");
		request.setAttribute("email1", email[0]);
		request.setAttribute("email2", email[1]);
		
		// 전화번호 분리 (-)
		String[] tel = vo.getTel().split("-");
		if(tel[1].equals(" ")) tel[1] = "";
		if(tel[2].equals(" ")) tel[2] = "";
		request.setAttribute("tel1", tel[0]);
		request.setAttribute("tel2", tel[1]);
		request.setAttribute("tel3", tel[2]);
		
		// 주소 분리 (/)
		String[] address = vo.getAddress().split("/");
		if(address[0].equals(" ")) address[0] = "";
		if(address[1].equals(" ")) address[1] = "";
		if(address[2].equals(" ")) address[2] = "";
		if(address[3].equals(" ")) address[3] = "";
		request.setAttribute("postcode", address[0]);
		request.setAttribute("roadAddress", address[1]);
		request.setAttribute("detailAddress", address[2]);
		request.setAttribute("extraAddress", address[3]);
		
		// 취미 분리 (/) => JSP에서 분리할 것임
		request.setAttribute("hobby", vo.getHobby());
		
		// 생일(년-월-일) : 앞에서부터 10자리 만 넘김 (시간 자르기)
		request.setAttribute("birthday", vo.getBirthday().substring(0, 10));
		
		// 나머지 내용들까지 vo에 담아서 전송
		request.setAttribute("vo", vo);
	}

}
