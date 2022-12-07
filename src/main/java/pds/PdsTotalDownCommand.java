package pds;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PdsTotalDownCommand implements PdsInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		PdsDAO dao = new PdsDAO();
		PdsVO vo = dao.getIdxSearch(idx);
		
		String[] fNames = vo.getfName().split("/");
		String[] fSNames = vo.getfSName().split("/");
		
		// '서버'에서 파일 압축에 필요한 객체들 선언
		FileInputStream fis = null;
		FileOutputStream fos = null;
		ZipOutputStream zos = null;
		// '클라이언트'에게 전송하기 위해 필요한 객체 선언
		ServletOutputStream sos = null; 
		
		String realPath = request.getServletContext().getRealPath("/data/pds/");
		String zipPath = request.getServletContext().getRealPath("/data/pds/temp/"); // 아웃풋으로 가는 realPath는 zip으로 묶을 거니까, zip 저장소
		String zipName = vo.getTitle() + ".zip"; // zip 확장자로 만들거야
		
		fos = new FileOutputStream(zipPath + zipName);
		zos = new ZipOutputStream(fos);
		
		// 바이트 단위로 보내기 위한 변수 선언
		byte[] b = new byte[2048]; // 바이트 단위[2048]는 내 마음대로.
		int data = 0;
		
		for(int i=0; i<fNames.length; i++) {
			// 
			File file = new File(realPath + fSNames[i]); // 서버에 생성된 파일명의 껍데기부터 생성
			
			// File copyAndRename = new File(realPath + fSNames[i]); // 업로드파일명을 리네이밍
			
			// 파일들의 이름 변경 : fSName -> fName으로 변경
			// renameTo() : copyAndRename의 것을 file로 바꾸겠다.
			// file.renameTo(copyAndRename);
			
			// fis = new FileInputStream(copyAndRename); // inputStream 이용하여 리네이밍 한 파일 압축
			
			fis = new FileInputStream(file); // .zip 만들기 위한 작업
			zos.putNextEntry(new ZipEntry(fNames[i])); 
			// zos 객체에 파일을 넣으려면 '객체'로 넣어야 하므로 ZipEntry객체 생성, 생성하면서 이름이 자동으로 변경됨. 따라서, renaming 할 필요X
			// 여기까지 zip파일 껍데기 생성 완료
			
			// 파입 업로드 전 바이너리 형식으로 변환하는 작업
			while((data = fis.read(b, 0, b.length)) != -1) {
				zos.write(b, 0, data);
			}
			// 2048 제외한 나머지도 담아주는 작업
			zos.flush();
			
			// 사용끝난 객체 닫기
			zos.closeEntry(); // close()로 닫으면 아예 zip 파일 담는 것 자체도 끝나므로, closeEntry로 닫아줌
			fis.close();
			
		}
		zos.close(); // 담는 것 완전히 끝남
		// 여기까지 서버에서 temp폴더에 zip파일 압축파일 생성 작업 종료 (server단 종료)
		
		
		/* 압축작업이 완료되면 1st. 서버 -> 클라이언트 전송 2ed. 서버에 압축되어 있는 파일(temp폴더의 .zip) 삭제. */
		
		// 전송프로토콜인 http헤더에 필요한 정보를 알려줌.
		String mimeType = request.getServletContext().getMimeType(zipName.toString()); // 문자형식으로 파일 변환
		if(mimeType == null) { // 만약 껍데기야?
			response.setContentType("application/octet-stre"); // 2진 바이너리 형식으로 변환
		}
		String downLoadName = "";
		if(request.getHeader("user-agent").indexOf("MSIE") == -1) {
			downLoadName = new String(zipName.getBytes("UTF-8"), "8859_1"); // 윈도우의 한글변환방식(8859_1)
		}
		else {
			downLoadName = new String(zipName.getBytes("EUC-KR"), "8859_1");
		}
		// 헤더정보를 가지고 서버의 zip파일을 클라이언트에게 전송 처리
		response.setHeader("Content-Disposition", "attachment;filename=" + downLoadName); // 서버에 저장된 이름으로 받아짐 (만약, 첨부한 이름으로 받고싶다면 filename=0_ 추가)

		// Java 형식의 실제파일을 클라이언트로 다운처리 시켜 줌
		fis = new FileInputStream(zipPath + zipName);
		sos = response.getOutputStream();
		
		while((data = fis.read(b, 0, b.length)) != -1) { // 서버에 있는 파일(fis)을 0부터 2048(b.length)만큼씩 data 그릇에 담아둔 게 없다면
			sos.write(b, 0, data); // 클라이언트에게 b만큼 0번째부터 data까지 담겠다. 
		}
		sos.flush();
		sos.close();
		fis.close();
		// 여기까지 클라이언트에게 전송 완료
		
		// 서버에 존재하는(temp폴더) zip파일 삭제 처리
		new File(zipPath + zipName).delete();
		
		// 다운로드 횟수 증가 처리
		dao.setPdsDownNum(idx);
	}
	

}
