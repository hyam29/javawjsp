package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BoReplyInputCommand implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int boardIdx = request.getParameter("boardIdx") == null ? 0 : Integer.parseInt(request.getParameter("boardIdx"));
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String nickName = request.getParameter("nickName") == null ? "" : request.getParameter("nickName");
		String hostIp = request.getParameter("hostIp") == null ? "" : request.getParameter("hostIp");
		String content = request.getParameter("content") == null ? "" : request.getParameter("content");
		
		BoardReplyVO replyVo = new BoardReplyVO();
		
		replyVo.setBoardIdx(boardIdx);
		replyVo.setMid(mid);
		replyVo.setNickName(nickName);
		replyVo.setHostIp(hostIp);
		replyVo.setContent(content);
		
		BoardDAO dao = new BoardDAO();
		
		String res = dao.setReplyInputOk(replyVo);
		// 제이쿼리니까(문자로 인식), res int타입XXX 타입 String으로 선언!
		response.getWriter().write(res);
	}

}
