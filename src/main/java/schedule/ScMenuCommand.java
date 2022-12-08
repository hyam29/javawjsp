package schedule;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ScMenuCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		String ymd = request.getParameter("ymd") == null ? "" : request.getParameter("ymd");
		
		// 2023-1-3 -> 2023-01-03으로 변환
		String[] ymds = ymd.split("-");
		if(ymds[1].length() == 1) ymds[1] = "0" + ymds[1];
		if(ymds[2].length() == 1) ymds[2] = "0" + ymds[2];
		
		ymd = ymds[0] + "-" + ymds[1] + "-" + ymds[2];
		
		ScheduleDAO dao = new ScheduleDAO();
		
		ArrayList<ScheduleVO> vos = dao.getScMenu(mid, ymd, 1);
		request.setAttribute("vos", vos);
		// vos의 ymd와 아래의 ymd는 다른 것 (vos.ymd로 꺼내도 되긴 함)
		request.setAttribute("ymd", ymd);
		
		request.setAttribute("ymd", ymd);
		
		request.setAttribute("scheduleCnt", vos.size());
		
	}
}
