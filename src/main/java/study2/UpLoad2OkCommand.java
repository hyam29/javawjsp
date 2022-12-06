package study2;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UpLoad2OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String realPath = request.getServletContext().getRealPath("/data/pdstest");
		int maxSize = 1024 * 1024 * 10; // 최대 서버에 저장할 최대 용량 = 5MB 지정
		String encoding = "UTF-8";
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
//		Enumeration e = multipartRequest.getParameterNames(); // 사용할 수 없음 (X)
//		Enumeration e = multipartRequest.getFileNames(); // form의 name이 찍힘 (서버는 어차피 id 사용XXX) (O)
//		
//		while(e.hasMoreElements()) {
//			String name = e.nextElement()+"";
//			System.out.println("name : " + name);
//		}
		
		/* 업로드 된 파일명 추출하기 */
		@SuppressWarnings("rawtypes")
		Enumeration fileNames = multipartRequest.getFileNames();
		String file = "";
		String originalFileName = "";
		String filesystemName = "";
		
		while(fileNames.hasMoreElements()) {
			file = (String) fileNames.nextElement(); // 업로드 시의 폼태그 안의 필드네임(name)
			originalFileName= multipartRequest.getOriginalFileName(file);
			filesystemName = multipartRequest.getFilesystemName(file);
			System.out.println("업로드 시의 원본 파일명 : " + originalFileName);
			System.out.println("서버에 저장된 실제 파일명 : " + filesystemName);
		}
		
		if(filesystemName.equals("")) {
			request.setAttribute("msg",  "upLoad1No");
		}
		else {
			request.setAttribute("msg",  "upLoad1Ok");
		}
		
		int upLoadFlag = multipartRequest.getParameter("upLoadFlag") == null ? 2 : Integer.parseInt(multipartRequest.getParameter("upLoadFlag"));
		
		if(upLoadFlag == 2) {
			request.setAttribute("url", request.getContextPath()+"/pdstest/upLoad2.st");
		}
		else if(upLoadFlag == 3) {
			request.setAttribute("url", request.getContextPath()+"/pdstest/upLoad3.st");
		}
		else if(upLoadFlag == 4) {
			request.setAttribute("url", request.getContextPath()+"/pdstest/upLoad4.st");
		}
	}
}
