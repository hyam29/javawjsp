package pds;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import conn.SecurityUtil;

public class PdsDeleteCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd"); 
		// 변수명 뒤의 언더바'_': 임시변수를 의미
		String fSName_ = request.getParameter("fSName") == null ? "" : request.getParameter("fSName");
		String[] fSNames = fSName_.split("/");
		// 가져오기 전에 프론트에서 split으로 구분해왔다면 15~16행 한줄로 작성 가능.
		
		// 비밀번호를 암호화 한 후 DB의 비밀번호와 같으면 작업을 계속 수행처리
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		PdsDAO dao = new PdsDAO();
		
		PdsVO vo = dao.getIdxSearch(idx);
		
		if(vo.getPwd().equals(pwd)) {
			// 파일이 저장되어 있는 서버의 실제 경로를 찾아 옴.
			String realPath	= request.getServletContext().getRealPath("/data/pds/"); // '/' 개수 꼭 확인하기!!! (특히, pds 뒤 '/')
			
			// 서버 파일시스템에 실제로 존재하는 파일들을 찾아 삭제 처리
			for(String fSName : fSNames) {
				/* File file = new File(realPath + fSName);
				file.delete(); */
				// 위의 두줄을 한줄로 작성!
				new File(realPath + fSName).delete();
			}
			// 파일 삭제 완료 후 DB에 저장된 자료파일을 삭제 -> DB 삭제
			String res = dao.setPdsDelete(idx);
			response.getWriter().write(res);
		}
	}

}
