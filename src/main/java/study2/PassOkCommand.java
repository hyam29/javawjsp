package study2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PassOkCommand implements StudyInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid") == null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd") == null ? "" : request.getParameter("pwd");
		int idx = request.getParameter("idx") == null ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		System.out.println("mid : " + mid);
		System.out.println("pwd : " + pwd);
		System.out.println("idx : " + idx);
		System.out.println();

		
		if(idx == 1) {
			// idx == 1 -> myform에서 숫자를 넘긴 것

			// 암호화를 위한 키(0x1234ABCD) (0x : java에서 16진수 표현, 뒤에는 해시키 (직접 개발자가 만드는 것)
			int key = 0x1234ABCD;
			int encPwd, decPwd;
			
			encPwd = Integer.parseInt(pwd) ^ key; // ^ : exclusive 연산자
			System.out.println("인코딩 된 비밀번호 : " + encPwd);
			System.out.println("인코딩 된 pwd를 DB에 저장처리 함.");
			
			System.out.println(" . . . 시간이 . . . 흘러서 . . .");

			System.out.println("DB에 저장된 pwd를 다시 복호화(디코딩) 처리");
			decPwd = encPwd ^ key;
			System.out.println("디코딩 된 비밀번호 : " + decPwd);
		}
		else {
			// 문자형식으로 입력된 비밀번호를 1문자씩 숫자로 변환처리 해야함.
			long intPwd;
			String strPwd = "";
			for(int i=0; i<pwd.length(); i++) {
				intPwd = (long) pwd.charAt(i); // ASCII 코드로 변환됨
				strPwd += intPwd; // 숫자로 변환된 비밀번호를 문자형식에 누적
			}
			System.out.println("strPwd는 (아스키코드로 문자로 변환된 비밀번호) : " + strPwd);
			
			// 암호화 (인코딩)
			
			intPwd = Long.parseLong(strPwd);
			
			long key = 0x1234ABCD;
			long encPwd;
			
			encPwd = intPwd ^ key;
			strPwd = String.valueOf(encPwd); // 문자형식으로 다시 변환
			System.out.println("인코딩된 비밀번호(DB 저장할 비밀번호) : " + strPwd);
			System.out.println(" . . . 시 간 이 흘 러 서 . . .");
			
			// DB에 저장된 암호를 다시 복호화(디코딩) 처리 => 원래 안되는 건데 해보는 것!
			long decPwd;
			intPwd = Long.parseLong(strPwd); // DB에 넣었던 strPwd(암호화된 값)을 다시 불러와 복호화 준비
			decPwd = intPwd ^ key;
			System.out.println("복호화 된 비밀번호 : " + decPwd);
			
			// 복원된 비밀번호는 숫자이기에 문자로 변환 후 2개씩 처리시켜야 함.
			strPwd = String.valueOf(decPwd);
			
			String result = "";
			char ch;
			
			for(int i=0; i<strPwd.length(); i+=2) { // 2자리 ASCII 코드, 따라서 i++ XXX
				ch = (char) Integer.parseInt(strPwd.substring(i, i+2));
				result += ch;
			}
			System.out.println();
			System.out.println("최종 변환된 비밀번호 : " + result);
		}
		System.out.println();
	}
}
