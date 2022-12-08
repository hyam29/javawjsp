package schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class ScheduleDAO {
	// 싱글톤을 이용한 DB연결객체(Connection) 연결 => DB열림(javaworks)
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	ScheduleVO vo = null;

	// 선택된 날짜의 해당회원에 대한 스케줄의 모든 정보 가져오기
	public ArrayList<ScheduleVO> getScMenu(String mid, String ymd, int sw) {
		ArrayList<ScheduleVO> vos = new ArrayList<>();
		try {
			if(sw == 0) {
				sql = "select * from schedule where mid=? and date_format(sDate,'%Y-%m')=? order by sDate,part";
			}
			else {
				sql = "select * from schedule where mid=? and date_format(sDate, '%Y-%m-%d')=?";
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mid);
			pstmt.setString(2, ymd);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new ScheduleVO();
				
				vo.setIdx(rs.getInt("idx"));
				vo.setMid(rs.getString("mid"));
				vo.setsDate(rs.getString("sDate"));
				vo.setPart(rs.getString("part"));
				vo.setContent(rs.getString("content"));
				
				vo.setYmd(ymd);
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// ajax 일정등록 처리
	public String setScheduleInputOk(ScheduleVO vo) {
		String res = "0";
		try {
			sql = "insert into schedule values (default, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getMid());
			pstmt.setString(2, vo.getsDate());
			pstmt.setString(3, vo.getPart());
			pstmt.setString(4, vo.getContent());
			pstmt.executeUpdate();
			res = "1";
		} catch (SQLException e) {
			System.out.println("일정등록 SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

}
	

