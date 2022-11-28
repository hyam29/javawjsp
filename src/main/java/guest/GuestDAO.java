package guest;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class GuestDAO {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	GuestVO vo = null;
	
	private String url = "jdbc:mysql://localhost:3306/javaworks";
	private String user = "root";
	private String password = "1234";
	
	// 객체 생성 시 DB 연결
	public GuestDAO() {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패 (lib의 mysql connector 유무확인)");
		} catch (SQLException e) {
			System.out.println("DB 연동 실패 (url, user, pwd, MySQL 확인)");
		}
	}

	// 객체 소멸 처리
	public void pstmtClose() {
		if (pstmt != null) {
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

	// 방명록 게시글 전체 리스트 읽어오기
//	public ArrayList<GuestVO> getGuestList() {
		// 페이징 처리를 위해 메소드 매개변수 change
		public ArrayList<GuestVO> getGuestList(int startIdxNo, int pageSize) {
		ArrayList<GuestVO> vos = new ArrayList<>();
		try {
			sql = "select * from guest order by idx desc limit ?,?";
			// limit의 첫번째 ? = 시작index번호, 두번째 ? = 가져올 index번호(?)
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIdxNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new GuestVO();
				
				vo.setIdx(rs.getInt("idx"));
				vo.setName(rs.getString("name"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setVisitDate(rs.getString("visitDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setContent(rs.getString("content"));
				
				vos.add(vo);
			}
		} catch (Exception e) {
			System.out.println("SQL 에러" + e.getMessage());
		} finally {
			rsClose();
		}
		return vos;
	}

	// 방명록 글쓰기 처리
	public int setGuInput(GuestVO vo) {
		int res = 0;
		
		try {
			sql = "insert into guest values (default,?,?,?,default,?,?)";
			// 디폴트값이 많으면 guest 에 field 로 넣는 게 좋음!
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getName());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getHomePage());
			pstmt.setString(4, vo.getHostIp());
			pstmt.setString(5, vo.getContent());
			pstmt.executeUpdate(); // 비정상일 때 여기서 걸림. 따라서, res=0
			res = 1;
		} catch (Exception e) {
			System.out.println("SQL 에러" + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 방명록 글 삭제 처리
	public int setGuDelete(int idx) {
		int res = 0;
		try {
			sql = "delete from guest where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (Exception e) {
			System.out.println("SQL 에러" + e.getMessage());
		} finally {
			pstmtClose();
		}
		return res;
	}

	// 방명록의 총 레코드 건수 구하기 (for. 페이징 처리)
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as cnt from guest";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			// rs 무조건 넘어옴! 자료가 없으면 "0" 이 넘어옴.
			rs.next();
//			totRecCnt = rs.getInt(1); 이렇게 사용해도 되지만, VO 사용 시 불편함 -> 이렇게 사용XXX, 무조건 변수(=>SQL 별명주는 명령어 as 사용)에 담아서 VO랑 같이 사용할 수 있게끔 하기!
			totRecCnt = rs.getInt("cnt");
		} catch (Exception e) {
			System.out.println("SQL 에러" + e.getMessage());
		} finally {
			rsClose();
		}
		return totRecCnt;
	}

	// 방명록 작성 총 개수 구하기
	public int getGuInputCnt(String name) {
		int guCntNum = 0;
		try {
			sql = "select count(*) as cnt from guest where name = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				guCntNum = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("SQL 에러" + e.getMessage());
		} finally {
			rsClose();
		}
		return guCntNum;
	}
}
