package study2;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class JavaDownCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/pdstest/");
		String fName = request.getParameter("file");
		File file = new File(realPath + fName);
		
		/* 
		 	프로토콜 형식에 맞도록 헤더에 정보를 제공해 줌
			mimeType : 파일형식(ex)text파일? binary파일? 등을 맞춰 줌)
				-> 2진 바이너리형식으로 전송해야 함.
		*/ 
		String mimeType = request.getServletContext().getMimeType(file.toString()); // 문자형식으로 파일 변환
		if(mimeType == null) { // 만약 껍데기야?
			response.setContentType("application/octet-stre"); // 2진 바이너리 형식으로 변환
		}
		
		// 사용하는 브라우저에 대한 정보: if) 인터넷익스플로러(IE)인 경우, 'euc-kr', 나머지는 'UTF-8'로 전송 (현재는 생략가능)
		String downLoadName = "";
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downLoadName = new String(fName.getBytes("UTF-8"), "8859_1"); // 윈도우의 한글변환방식(8859_1)
		}
		else {
			downLoadName = new String(fName.getBytes("EUC-KR"), "8859_1");
		}
		// 헤더 정보를 첨부하여 클라이언트에 전송할 준비를 마친다. (예약어라 동일하게 작성해야 함)
		response.setHeader("Content-Disposition", "attachment;filename=" + downLoadName); // 서버에 저장된 이름으로 받아짐 (만약, 첨부한 이름으로 받고싶다면 filename=0_ 추가)
		
		// Java에 의해 실제 파일을 다운(업)로드 처리시켜 줌. (FileInputStream, FileOutputStream)
		FileInputStream fis = new FileInputStream(file); // (file) : 서버에 있는 파일
		// FileOutputStream fos = new FileOutputStream(file); // file : 서버로 보내는 파일
		ServletOutputStream sos = response.getOutputStream(); // input으로 넘어온 파일을 서버를 통해 클라이언트(웹)에게 보내겠다.
		
		// 전송할 객체를 생성 후 실제로 파일을 객체 담아 처리
		byte[] b = new byte[2048]; // 1024 * 2 (2K 씩 처리)
		int data = 0;
		
		while((data = fis.read(b, 0, b.length)) != -1) { // 서버에 있는 파일(fis)을 0부터 2048(b.length)만큼씩 data 그릇에 담아둔 게 없다면
			sos.write(b, 0, data); // 클라이언트에게 b만큼 0번째부터 data까지 담겠다. 
		}
		sos.flush(); // flush() : but, 모든 파일이 2048로 딱 안떨어지니까, 나머지도 그릇에 모두 담을거야.
		// 여기까지 수행 시 파일 다운로드 처리 완!!!
		sos.close();
		fis.close();
		// 객체 닫아줘야 좋음! (안닫아도 되지만...)
	}

}
