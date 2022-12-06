package study2;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class FileDeleteCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String fName = request.getParameter("file");
		String realPath = request.getServletContext().getRealPath("/data/pdstest/");
		
		File file = new File(realPath + fName); // fName은 파일명일뿐, 정확한 위치를 표시하기 위해 realPath도 함께 작성
		
		String res = "0";
		if(file.exists()) { // exists() : 파일이 존재하니? -> if문 작성없이 delete 한다면 바로 error
			file.delete();
			res = "1";
		}
		
		response.getWriter().write(res);
	}
}
