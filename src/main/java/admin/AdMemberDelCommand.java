package admin;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.MemberVO;

public class AdMemberDelCommand implements AdminInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		AdminDAO dao = new AdminDAO();
		
		// 회원 삭제전에 파일을 먼저 지운다.
		MemberVO vo = dao.getIdxSearch(idx);
		String photo = vo.getPhoto();
		if(!photo.equals("noimage.jpg")) {
			String realPath = request.getServletContext().getRealPath("/data/member");
			File file = new File(realPath + "/" + photo);
			if(file.exists()) file.delete();
		}
		
		dao.setMemberDel(idx);
		
		request.setAttribute("msg", "adMemberDelOk");
		request.setAttribute("url", request.getContextPath()+"/adMemList.ad");
	}

}
