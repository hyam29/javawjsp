package study2;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownLoadCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/pdstest");
		
		/* java에서의 파일 제어법 */
		// File file = new File("atom.txt"); // 1개 File의 객체 생성 (껍데기인 atom.txt만 생성된 것)
		String[] files = new File(realPath).list(); // list() : 경로를 list로 만들어주는 명령어 -> 단지 문자열의 나열일 뿐이므로 String 타입의 배열로 변수 선언
		
		for(String file : files) {
			System.out.println("file : " + file);
		}
		request.setAttribute("files", files);
	}
}
