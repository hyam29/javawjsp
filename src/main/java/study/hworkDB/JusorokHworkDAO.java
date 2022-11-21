package study.hworkDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class JusorokHworkDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	JusorokHworkVO vo = null;
	
	public JusorokHworkDAO() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			 // 변수 바깥에 선언시, private
			String url = "jdbc:mysql://localhost:3306/javaworks";
			String user = "root";
			String password = "1234";
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패...");
		} catch (SQLException e) {
			System.out.println("DB 연동 실패...");
			e.printStackTrace();
		}
	}
	
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

//로그인 체크 처리 
	public JusorokHworkVO loginCheck(String mid, String pwd) {
		 vo = new JusorokHworkVO();
		try {
			sql = "select * from jusorok where mid=? and pwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, pwd);
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

	// 로그아웃 처리
	public void logout() {
	}

	// 회원 정보 조회
	public JusorokHworkVO getMemberSearch(String mid) {
		vo = new JusorokHworkVO();
		try {
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
	public int setJoinOk(JusorokHworkVO vo) {
		int res = 0; // res 변수를 줘서, 0이면 회원가입 정상XX, 1이면 가입 정상처리 완료
		vo = new JusorokHworkVO();
		
		try {
			sql = "insert into jusorok (mid, pwd, name) values (?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getPwd());
			pstmt.setString(3, vo.getName());
			
			res = 1;
			
		} catch (SQLException e) {
			System.out.println("SQL 오류 : " + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 전체 회원 조회 처리
	public ArrayList<JusorokHworkVO> getMemberList() {
		ArrayList<JusorokHworkVO> vos = new ArrayList<>(); 
		try {
			sql = "select * from jusorok order by idx desc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new JusorokHworkVO();
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
