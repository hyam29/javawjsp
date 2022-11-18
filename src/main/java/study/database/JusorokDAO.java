package study.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class JusorokDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	JusorokVO vo = null;
	
	public JusorokDAO() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			 // 변수 바깥에 선언시, private
			String url = "jdbc:mysql://localhost:3306/javaworks";
			String user = "root";
			String password = "1234";
			conn = DriverManager.getConnection(url, user, password);
			// connection 사용하려면 변수에 담아줘야 하는데 안담아줘서 conn이 null 상태라 nullPointException 예외 발생
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패...");
		} catch (SQLException e) {
			System.out.println("DB 연동 실패...");
			e.printStackTrace();
		}
	}
	
	// 사용한 객체 반납
	public void pstmtClose() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {}
		}
	}
	
	public void rsClose() {
		if(rs != null) {
			try {
				rs.close();
				pstmt.close();
			} catch (SQLException e) {}
		}
	}
	
	// 로그인 체크 처리 
	// (타입이 void에서, 원래 name만 받았다가 값 여러개 담으려고 VO 생성해서 JusorokVO로 타입 변경)
	public JusorokVO loginCheck(String mid, String pwd) {
//		String name = "";
		 vo = new JusorokVO();
		try {
//			sql = "select name from jusorok where mid=? and pwd=?";
			sql = "select * from jusorok where mid=? and pwd=?";
			// field 많을 때, select * 대신 직접 변수명 name 적는 게 좋음
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
//				name = rs.getString("name"); 
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setName(rs.getString("name")); 
				vo.setPoint(rs.getInt("point"));
				vo.setLastDate(rs.getString("lastDate"));
			}
			// name에 값이 없다면 위의 변수선언에 의해서 name에 공백("") 값 넘어감
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
//		return name;
		return vo;
	}

	// 로그아웃 처리
	public void logout() {
		// 종료전에 DB에 처리해야 할 내용들을 기록...!
		// (최종 방문일자는 로그인할 때 일자를 기록하는 게 일반적) -> 프로그램 만들 때는 비워두고 후에 다시 작성
	}

	// 회원 정보 조회
	public JusorokVO getMemberSearch(String mid) {
		vo = new JusorokVO();
		try {
//			sql = "select name from jusorok where mid=?";
			sql = "select * from jusorok where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			rs = pstmt.executeQuery();
			
			if(rs.next()) { 
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setName(rs.getString("name")); 
				vo.setPoint(rs.getInt("point"));
				vo.setLastDate(rs.getString("lastDate"));
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vo;
	}

	// 방문 포인트 증가 + 최종 방문일자 업데이트
	public void setVisitUpdate(int visitPoint, String mid) {
		try {
			sql = "update jusorok set point=?, lastDate=now() where mid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, visitPoint);
			pstmt.setString(2, mid);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
	}

	// 회원 가입 처리
	public int setJoinOk(JusorokVO vo) {
		int res = 0; // res 변수를 줘서, 0이면 회원가입 정상XX, 1이면 가입 정상처리 완료
		
		try {
			sql = "insert into jusorok (mid, pwd, name) values (?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 전체 회원 조회 처리 (큰일남... 배열 담는 거 까먹음 -> 여기 복습 필요)
	public ArrayList<JusorokVO> getMemberList() {
		ArrayList<JusorokVO> vos = new ArrayList<>(); 
		try {
			sql = "select * from jusorok order by idx desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new JusorokVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setPwd(rs.getString("pwd"));
				vo.setName(rs.getString("name"));
				vo.setPoint(rs.getInt("point"));
				vo.setLastDate(rs.getString("lastDate"));
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}
}
