package schedule;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ScheduleCommand implements ScheduleInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 오늘 날짜처리(저장)
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);

		// 화면에 보여줄 해당 '년/월' 세팅 위해 Calendar 객체 한번 더 생성
		Calendar calView = Calendar.getInstance();
		int yy = request.getParameter("yy") == null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
		int mm = request.getParameter("mm") == null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
		
		// 앞에서 넘어온 변수(yy, mm)값이 '1월'이거나, '12월'이라면 아래와 같이 편집. (1월: '0', 12월: '11'로 넘어옴)
		if(mm < 0) { // 1월보다 작다면 작년 12월이 되어야 함.
			yy--;
			mm = 11;
		}
		if(mm > 11) { // 12월보다 크다면 내년 1월이 되어야 함.
			yy++;
			mm = 0;
		}
		
		// 전후 월/연도 버튼 클릭시, 해당 '년/월'의 1일을 기준으로 셋팅시켜준다.
		calView.set(yy, mm, 1);
		
		// 앞에서 셋팅한 해당 '년/월'의 1일에 해당하는 요일값을 숫자로 가져온다. (일(1), 월(2) ~ 토(7))
		@SuppressWarnings("static-access")
		int startWeek = calView.get(Calendar.DAY_OF_WEEK);
		// System.out.println("해당월의 첫번째 1의 요일을 숫자로 반환 :" + startWeek);
		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);
		// System.out.println("해당월의 가장 큰 날짜(마지막 일) 반환 : " + lastDay);
		
		// 출력된 달력의 '앞쪽/뒷쪽'의 빈공간에 해당월 '이전/다음'의 날짜 출력 처리 (준비)
		int prevYear = yy;
		int prevMonth = (mm) - 1;
		int nextYear = yy;
		int nextMonth	= (mm) + 1;
		
		if(prevMonth == -1) {
			prevYear--;
			prevMonth = 11;
		}
		if(nextMonth == 12) {
			nextYear++;
			nextMonth = 0;
		}
		// 현재 월(11월이라면)의 이전월(10월)의 마지막 날짜를 구함
		Calendar calPre = Calendar.getInstance();
		calPre.set(prevYear, prevMonth, 1);
		int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		// 다음월의 1일에 해당하는 요일의 숫자값을 가져옴
		Calendar calNext = Calendar.getInstance();
		calNext.set(nextYear, nextMonth, 1);
		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);
		
		
		// 화면에 보여줄 달력의 해당 일자를 저장소에 저장 처리
		request.setAttribute("yy", yy);
		request.setAttribute("mm", mm);
		request.setAttribute("startWeek", startWeek);
		request.setAttribute("lastDay", lastDay);
		
		
		// 오늘 날짜를 저장소에 저장 처리
		request.setAttribute("toYear", toYear);
		request.setAttribute("toMonth", toMonth);
		request.setAttribute("toDay", toDay);
		
		// 현재달의 '전월/다음월/의 날짜 표시를 위한 변수를 저장소에 저장
		request.setAttribute("prevYear", prevYear);
		request.setAttribute("prevMonth", prevMonth);
		request.setAttribute("nextYear", nextYear);
		request.setAttribute("nextMonth", nextMonth);
		request.setAttribute("preLastDay", preLastDay);
		request.setAttribute("nextStartWeek", nextStartWeek);
		
		/* 스케줄(DB)에 등록되어 있는 해당 월의 일정들을 가져온다. */
		// 자신의 스케줄만 가져와야 하기에, 로그인된 회원의 아이디와 일치한 자료만 가져와야 함.
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		
		// 해당 '월'을 가져오기 위한 편집처리 (2022-12 까지만 가져와야 함)
		// if) 2023-1 -> 2023-01 로 변환 작업
		String ym = "";
		if((mm + 1) < 10) {
			ym = yy + "-0" + (mm + 1);
		}
		else {
			ym = yy + "-" + (mm + 1);
		}
		
		ScheduleDAO dao = new ScheduleDAO();
		// ScMenu와 동일한 DAO 사용하기 위해서 스위칭기법 사용하려고 int인 0을 넘김
		ArrayList<ScheduleVO> vos = dao.getScMenu(mid, ym, 0);
		
		request.setAttribute("vos", vos);
	}

}
