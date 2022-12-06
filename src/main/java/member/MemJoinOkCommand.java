package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import conn.SecurityUtil;

public class MemJoinOkCommand implements MemberInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String realPath = request.getServletContext().getRealPath("/data/member");
		int maxSize = 1024 * 1024 * 10;	// 서버에 저장할 최대용량을 10MByte로 한다.(1회 저장)
		String encoding = "UTF-8";

		MultipartRequest multipartRequest = new MultipartRequest(request, realPath, maxSize, encoding, new DefaultFileRenamePolicy());
		
	  // 회원 사진이 업로드 되었는지의 여부 처리? 업로드된 파일이 있으면 서버에 저장된 이름을, 없으면 'noimage.jpg'파일명을 filesystemName변수에 저장시켜준다.
		// String originalFileName = multipartRequest.getOriginalFileName("fName");  // 업로드 시킬때의 업로드 파일명이다.
		String filesystemName = multipartRequest.getFilesystemName("fName");			// 실제 서버에 저장된 파일명.
		if(filesystemName == null) filesystemName = "noimage.jpg";
		
		String mid = multipartRequest.getParameter("mid")==null ? "" : multipartRequest.getParameter("mid");
		String pwd = multipartRequest.getParameter("pwd")==null ? "" : multipartRequest.getParameter("pwd");
		String nickName = multipartRequest.getParameter("nickName")==null ? "" : multipartRequest.getParameter("nickName");
		String name = multipartRequest.getParameter("name")==null ? "" : multipartRequest.getParameter("name");
		String gender = multipartRequest.getParameter("gender")==null ? "" : multipartRequest.getParameter("gender");
		String birthday = multipartRequest.getParameter("birthday")==null ? "" : multipartRequest.getParameter("birthday");
		String tel = multipartRequest.getParameter("tel")==null ? "" : multipartRequest.getParameter("tel");
		String address = multipartRequest.getParameter("address")==null ? "" : multipartRequest.getParameter("address");
		String email = multipartRequest.getParameter("email")==null ? "" : multipartRequest.getParameter("email");
		String homePage = multipartRequest.getParameter("homePage")==null ? "" : multipartRequest.getParameter("homePage");
		String job = multipartRequest.getParameter("job")==null ? "" : multipartRequest.getParameter("job");
		String content = multipartRequest.getParameter("content")==null ? "" : multipartRequest.getParameter("content");
		String userInfor = multipartRequest.getParameter("userInfor")==null ? "" : multipartRequest.getParameter("userInfor");
		
		// 취미 전송에 대한 처리
		String[] hobbys = multipartRequest.getParameterValues("hobby");
		String hobby = "";
		if(hobbys.length != 0) {
			for(String strHobby : hobbys) {
				hobby += strHobby + "/";
			}
		}
		hobby = hobby.substring(0, hobby.lastIndexOf("/"));
		
		
		/*
		 * // 회원 사진이 업로드 되었는지? 여부 처리 String fileSystemName = ""; String photo =
		 * request.getParameter("photo"); // 이미 noimage 넣어뒀기때문에, null 값 체크 X
		 * if(photo.equals("noimage")) { fileSystemName = "noimage.jpg"; } else {
		 * fileSystemName = photo; }
		 */
		
		// DB 저장시, 테이블설계에서 지정한 각 필드의 길이체크 -> 길이체크는 알아서 하기
		
		// 아이디와 닉네임을 다시 한 번 중복체크 해준다. (백엔드에서 한번 더 체크하는 것)
		MemberDAO dao = new MemberDAO();
		
		MemberVO vo = dao.getLoginCheck(mid);
		if(vo != null) {
			request.setAttribute("msg", "idCheckNo");
			request.setAttribute("url", request.getContextPath()+"/member/memJoin.mem");
			return;
		}
		
		int nickRes = dao.getNickNameCheck(nickName);
		if(nickRes == 0) {
			request.setAttribute("msg", "nickCheckNo");
			request.setAttribute("url", request.getContextPath()+"/member/memJoin.mem");
			return;
		}
		
		// 비밀번호 암호화 처리 (SHA256) -> 관리자는 후에 다시 바꿔줘야 함
		SecurityUtil security = new SecurityUtil();
		pwd = security.encryptSHA256(pwd); // 암호화 된 pwd 받기
		
		// if) 모든 체크 완료 -> 회원정보를 vo에 담아 DB(DAO)로 넘겨준다.
		vo = new MemberVO();
		
		/*vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setJob(job);
		vo.setHobby(hobby);
		vo.setPhoto(filesystemName);
		vo.setContent(content);
		vo.setUserInfor(userInfor);*/
		
		vo.setMid(mid);
		vo.setPwd(pwd);
		vo.setNickName(nickName);
		vo.setName(name);
		vo.setGender(gender);
		vo.setBirthday(birthday);
		vo.setTel(tel);
		vo.setAddress(address);
		vo.setEmail(email);
		vo.setHomePage(homePage);
		vo.setJob(job);
		vo.setHobby(hobby);
		vo.setPhoto(filesystemName);
		vo.setContent(content);
		vo.setUserInfor(userInfor);
		
		int res = dao.setMemberJoinOk(vo);
		
		if(res == 1) {
			request.setAttribute("msg", "memJoinOk");
			request.setAttribute("url", request.getContextPath()+"/memLogin.mem");
		}
		else {
			request.setAttribute("msg", "memJoinNo");
			request.setAttribute("url", request.getContextPath()+"/memJoin.mem");
		}
	}

}
