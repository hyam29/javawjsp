package guest;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GuListCommand implements GuestInterface {
	/* 페이징 처리 (page는 예약어라서 사용X)
		 	1. 페이지(pag)를 결정 (처음 접속시의 페이지는 must '1') : pag = 1 
		 	2. 한 페이지의 분량 결정 : pageSize = 5 (분량은 사용자가 결정) 이곳에서는 한 페이지 분량이 '5'
		 	3. 총 레코드 건수를 구함 : totRecCnt => SQL 함수 중 COUNT(*) 사용!
		 	4. 전체 페이지 건수를 구함 : totPage => totRecCnt % pageSize = 0 -> '몫' or != 0 -> '몫 + 1'
		 	5. 현재 페이지의 시작 index 번호를 구함 : startIdxNo => (pag - 1) * pageSize
		 	6. 현재 화면에 보여주는 시작번호를 구함 : curScrStartNo => totRecCnt - startIdxNo
	 */

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestDAO dao = new GuestDAO();
		
		// 1. 페이지(pag)를 결정 = 1
		int pag = request.getParameter("pag") == null ? 1 : Integer.parseInt(request.getParameter("pag"));
		
		// 2. 한 페이지의 분량 결정 = 5
		int pageSize = 5;
		
		// 3. 총 레코드 건수를 구함 -> DAO 사용
		int totRecCnt = dao.totRecCnt();

		// 4. 전체 페이지 건수를 구함
		int totPage = (totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1;
		
		// 5. 현재 페이지의 시작 index 번호를 구함
		int startIdxNo = (pag - 1) * pageSize;
		
		// 6. 현재 화면에 보여주는 시작번호를 구함
		int curScrStartNo = totRecCnt - startIdxNo;
		
		/* 블록 페이징 처리 (3단계) => 블록의 시작번호를 0번부터 처리 */
		// 1. 블록의 크기를 결정 => '3' 
		int blockSize = 3;
		
		// 2. 현재 페이지가 위치하고 있는 블록 번호를 구함 (ex) 1페이지 = 0블록, 3페이지 = 0블록, 5페이지 = 1블록)
		// 현재페이지 % 3 != 0 -> 현재페이지 / =0 -> -1 -> 자신의 블록
		// int curBlock = (pag % blockSize) == 0 ? (pag / blockSize) - 1 : (pag / blockSize);
		int curBlock = (pag - 1) / blockSize; // 이게 더 쉬움
		
		// 3. 마지막 블록 구함
//		int lastBlock = (totPage % blockSize) == 0 ? (totPage / blockSize) - 1 : (totPage / blockSize);
		int lastBlock = (totPage - 1) / blockSize; // 49행과 동일
		
		ArrayList<GuestVO> vos = dao.getGuestList(startIdxNo, pageSize);
		
		request.setAttribute("vos", vos);// 이렇게 담으면 첫 페이지만 나옴
		
		request.setAttribute("pag", pag);
		request.setAttribute("totPage", totPage);
		request.setAttribute("curScrStartNo", curScrStartNo);
		request.setAttribute("blockSize", blockSize);
		request.setAttribute("curBlock", curBlock);
		request.setAttribute("lastBlock", lastBlock);
	}

}
