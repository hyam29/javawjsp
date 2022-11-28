package mamber;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MemLoginOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		String idCheck = request.getParameter("idCheck") == null ? "" : request.getParameter("idCheck");
		
		MemberDAO dao = new MemberDAO(); 
//		MemberVO vo = dao.getLoginCheck(mid, pwd); // id만 가져가면 또 써먹을 수 있지만, pwd와 같이 가져가면 한번밖에 사용하지 못함
		MemberVO vo = dao.getLoginCheck(mid);
		
		if(vo == null || !pwd.equals(vo.getPwd())) {
			request.setAttribute("msg", "loginNo");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
			return;
		}
		
		/*
			로그인 성공시 처리할 작업 
			1. 주요필드를 세션에 저장
			2. 오늘 방문 횟수 처리
			3. 방문수, 방문포인트 증가
			4. 쿠키에 아이디 저장 유무
		*/
		
		/* 1. 주요필드를 세션에 저장 */
		HttpSession session = request.getSession();
		session.setAttribute("sMid",mid);
		session.setAttribute("sNickName", vo.getNickName());
		session.setAttribute("sLevel", vo.getLevel());

		/* 2~3. 오늘 방문 횟수 처리 */
		Date now = new Date(); // java.util 에 들어있는 객체 Date 생성해야 함!
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String strNow = sdf.format(now);
		
		// if) 오늘 처음 방문한 사람(마지막 방문일 != 현재 날짜) -> 오늘방문카운트(todayCnt) 를 0으로 셋팅
		if(!vo.getLastDate().substring(0,10).equals(strNow)) {
			dao.setTodayCntUpdate(mid);
			vo.setTodayCnt(0);
		}
		
		// 당일 재방문한 사람 -> '총방문수', '오늘방문수', '포인트' 누적
		int nowTodayPoint = 0;
		if(vo.getTodayCnt() >= 5) {
			nowTodayPoint = vo.getPoint();
		}
		else {
			nowTodayPoint = vo.getPoint() + 10;
		}
		// 당일 방문(tocnt)이 5번 이상이라면, 기존방문포인트를(방문포인트 변수(nowTodayPoint)에 넣어서 그것만 sql에서 누적시켜서 넘겨주면 됨) 그대로 보내기 -> sql 구문 바껴야 함 -> 과제
		dao.setMemTotalUpdate(mid, nowTodayPoint);
		
		/* 4. 쿠키에 아이디 저장 유무 */  
		Cookie cookieMid = new Cookie("cMid", mid);
		
		if(idCheck.equals("on")) {
			cookieMid.setMaxAge(60*60*24*7); // 쿠키 만료시간 7일
		}
		else {
			cookieMid.setMaxAge(0); // 아이디저장 XXX
		}
		response.addCookie(cookieMid);
		
		request.setAttribute("msg", "loginOk");
		request.setAttribute("url", request.getContextPath()+"/memMain.mem");
		request.setAttribute("val", vo.getNickName());
	}
}
