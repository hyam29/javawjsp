package study2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class UpLoad1OkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// String fName = request.getParameter("fName") == null ? "" : request.getParameter("fName");
		// System.out.println("pdstest에서 넘어온 파일 명: " + fName);
		
		/* COS 라이브러리에서 제공해주는 객체
			 DefaultFileRenamePolicy(): 중복방지를 위한 클래스. 파일명 중복 시 자동으로 1,2,3 붙어서 업로드시켜줌
			 MultipartRequest()
			 -> (저장소명(request),"서버에 저장될 파일의 경로","서버에 저장될 파일의 최대용량","코드변환방식",기타옵션(중복방지를위한클래스))
			
		*/
		
		// ServletContext application = request.getServletContext();
		// String realPath = application.getRealPath(null);
		/* String realPath = request.getRealPath("/"); 이렇게 작성해도 되긴하지만 급할때만... 최종은 아래와 같이 한줄 작성 */
		
		// 1. 서버에 저장될 파일의 경로
		String realPath = request.getServletContext().getRealPath("/data/pdstest");
		// 2. 서버에 저장될 파일의 최대용량(byte단위)
		int maxSize = 1024 * 1024 * 10; // 최대 서버에 저장할 최대 용량 = 5MB 지정
		// 3. 코드변환방식
		String encoding = "UTF-8";
		// 4. 파일 업로드 처리
		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());

		// 업로드된 파일의 정보를 추출
		String fName = request.getParameter("fName");
		String originalFileName = multipartRequest.getOriginalFileName("fName"); // OOO 업로드 시킬때의 업로드 파일명
		String filesystemName = multipartRequest.getFilesystemName("fName"); // 실제 서버에 저장된 파일명
		
		System.out.println("원본파일명(fName) : " + fName); // XXX 원래 getparameter로 파일명 찍히지 XXX => multipartRequest.getOriginalFileName 사용
		System.out.println("원본파일명(originalFileName) : " + originalFileName); // OOO 업로드 시킬때의 업로드 파일명
		System.out.println("파일이 저장될 서버의 실제 경로명 : " + realPath);
		System.out.println("서버에 저장되는 실제 파일명(중요중요) : " + filesystemName);
		
		if(filesystemName == null) {
			request.setAttribute("msg",  "upLoad1No");
		}
		else {
			request.setAttribute("msg",  "upLoad1Ok");
		}
		request.setAttribute("url", request.getContextPath()+"/pdstest/upLoad1.st");
	}

}
