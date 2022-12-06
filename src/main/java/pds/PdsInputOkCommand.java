package pds;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import conn.SecurityUtil;

public class PdsInputOkCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/pds");
		int maxSize = 1024 * 1024 * 20;	// 서버에 저장할 최대용량을 20MByte로 한다.(1회 저장)
		String encoding = "UTF-8";

		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		// 여기까지 작성시, 파일업로드 완료된 상태. (파일중복처리도 끝)
		
		// 업로드 시킨 멀티파일에 대한 처리 (업로드 파일명과 서버에 저장된 파일명을 '/'로 결합해서 준비)
		Enumeration fileNames = multipartRequest.getFileNames();
		
		String originalFileName = "";
		String filesystemName = "";
		
		while(fileNames.hasMoreElements()) {
			String file = (String) fileNames.nextElement();
			
			if(multipartRequest.getFilesystemName(file) != null) {
				originalFileName += multipartRequest.getOriginalFileName(file) + "/"; // 업로드 파일명
				filesystemName += multipartRequest.getFilesystemName(file) + "/"; // 서버 파일명
			}
		}
		// 마지막 구분자 '/' 빼주는 처리
		originalFileName = originalFileName.substring(0, originalFileName.length()-1);
		filesystemName = filesystemName.substring(0, filesystemName.length()-1);
		
		// 세션에서 닉네임, 아이디 가져오기
		HttpSession session = request.getSession();
		String mid = (String) session.getAttribute("sMid");
		String nickName = (String) session.getAttribute("sNickName");
		
		// 폼에서 전송된 값들을 모두 받아오기
		String listPart = multipartRequest.getParameter("listPart") == null ? "전체" : multipartRequest.getParameter("listPart");
		String title = multipartRequest.getParameter("title") == null ? "" : multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content") == null ? "" : multipartRequest.getParameter("content");
		String part = multipartRequest.getParameter("part") == null ? "" : multipartRequest.getParameter("part");
		String openSw = multipartRequest.getParameter("openSw") == null ? "" : multipartRequest.getParameter("openSw");
		String pwd = multipartRequest.getParameter("pwd") == null ? "" : multipartRequest.getParameter("pwd");
		String hostIp = multipartRequest.getParameter("hostIp") == null ? "" : multipartRequest.getParameter("hostIp");
		int fileSize = multipartRequest.getParameter("fileSize") == null ? 0 : Integer.parseInt(multipartRequest.getParameter("fileSize"));
		
		// 비밀번호 암호화 (SHA-256)
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd);
		
		// 앞에서 전송된 자료와 가공된 자료들을 모두 VO에 담아 DB에 저장할 수 있도록 함.
		PdsVO vo = new PdsVO();
		
		vo.setMid(mid);
		vo.setNickName(nickName);
		vo.setfName(originalFileName);
		vo.setfSName(filesystemName);
		vo.setfSize(fileSize);
		vo.setTitle(title);
		vo.setPart(part);
		vo.setPwd(pwd);
		vo.setOpenSw(openSw);
		vo.setContent(content);
		vo.setHostIp(hostIp);
		

		PdsDAO dao = new PdsDAO();
		int res = dao.setPdsInputOk(vo);
		if(res == 1) {
			request.setAttribute("msg", "pdsInputOk");
			request.setAttribute("url", request.getContextPath()+"/pdsList.pds?part="+listPart);
		}
		else {
			request.setAttribute("msg", "pdsInputNo");
			request.setAttribute("url", request.getContextPath()+"/pdsInput.pds?part="+listPart);
			
		}
	}
	
	
	
}
