package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import conn.GetConn;

public class BoardDAO {
	// 싱글톤을 이용한 DB연결객체(Connection) 연결 => DB열림(javaworks)
	GetConn getConn = GetConn.getInstance();
	
	private Connection conn = getConn.getConn();
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String sql = "";
	
	BoardVO vo = null;

	// 전체() 레코드 건수 구하기
	public int totRecCnt() {
		int totRecCnt = 0;
		try {
			sql = "select count(*) as cnt from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			rs.next(); // 자료가 0건이라도 나오므로 rs.next() 만 작성
			totRecCnt = rs.getInt("cnt"); // 필드명이니까 cnt를 "" 로 둘러쌈
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return totRecCnt;
	}

	// 전체 게시글 가져오기
	public ArrayList<BoardVO> getBoList(int startIndexNo, int pageSize) {
		ArrayList<BoardVO> vos = new ArrayList<>(); // List = arrayList
		try {
			//sql = "select *, datediff(now(), wDate) as day_diff from board order by idx desc limit ?, ?";
			//sql = "select *, timestampdiff(hour, wDate, now()) as hour_diff from board order by idx desc limit ?, ?";
			sql = "select *, datediff(now(), wDate) as day_diff,"
					+ " timestampdiff(hour, wDate, now()) as hour_diff"
					+ " from board order by idx desc limit ?, ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndexNo);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setContent(rs.getString("content"));
				vo.setwDate(rs.getString("wDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setGood(rs.getInt("good"));
				vo.setMid(rs.getString("mid"));
				
				vo.setDay_diff(rs.getInt("day_diff")); 
				vo.setHour_diff(rs.getInt("hour_diff"));
				
				vos.add(vo);
				
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}
	
	// 게시글 작성 내용 DB에 저장
	public int setBoInputOk(BoardVO vo) {
		int res = 0;
		try {
			sql = "insert into board values (default, ?, ?, ?, ?, ?, default, ?, default, default, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNickName());
			pstmt.setString(2, vo.getTitle());
			pstmt.setString(3, vo.getEmail());
			pstmt.setString(4, vo.getHomePage());
			pstmt.setString(5, vo.getContent());
			pstmt.setString(6, vo.getHostIp());
			pstmt.setString(7, vo.getMid());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 개별 자료 검색 (게시글 내용 검색)
	public BoardVO getBoContentSearch(int idx) {
		try {
			sql = "select * from board where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			rs.next();
			
			vo = new BoardVO();
			vo.setIdx(rs.getInt("idx"));
			vo.setNickName(rs.getString("nickName"));
			vo.setTitle(rs.getString("title"));
			vo.setEmail(rs.getString("email"));
			vo.setHomePage(rs.getString("homePage"));
			vo.setContent(rs.getString("content"));
			vo.setwDate(rs.getString("wDate"));
			vo.setHostIp(rs.getString("hostIp"));
			vo.setReadNum(rs.getInt("readNum"));
			vo.setGood(rs.getInt("good"));
			vo.setMid(rs.getString("mid"));
			
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 조회수 증가 처리 
	public void setReadNumPlus(int idx) {
		try {
			sql = "update board set readNum = readNum + 1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 게시글 좋아요 횟수 증가 처리
	public void setBoGood(int idx) {
		try {
			sql = "update board set good = good + 1 where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 따봉 증가 감소 처리
	public void setGoodPlusMinus(int idx, int goodCnt) {
		try {
			sql = "update board set good = (good + ?) where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, goodCnt);
			pstmt.setInt(2, idx);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
	}

	// 게시글 삭제 처리
	public int setBoDeleteOk(int idx) {
		int res = 0;
		try {
			sql = "delete from board where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 게시글 수정 처리
	public int setBoUpdateOk(BoardVO vo) {
		int res = 0;
		try {
			sql = "update board set title=?, email=?, homePage=?, content=?, hostIp=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getTitle());
			pstmt.setString(2, vo.getEmail());
			pstmt.setString(3, vo.getHomePage());
			pstmt.setString(4, vo.getContent());
			pstmt.setString(5, vo.getHostIp());
			pstmt.setInt(6, vo.getIdx());
			pstmt.executeUpdate();
			res = 1;
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	
	// 이전글/다음글에 필요한 내용 검색 처리
	public BoardVO getPreNextSearch(String str, int idx) {
		vo = new BoardVO();
		try {
			if(str.equals("pre")) {
				sql = "select * from board where idx < ? order by idx desc limit 1";
			}
			else {
				sql = "select * from board where idx > ? limit 1";				
			}
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			if(str.equals("pre") && rs.next()) { // pre랑 같으면서, rs에 값이 있다면 꺼내오기
				vo.setPreIdx(rs.getInt("idx"));
				vo.setPreTitle(rs.getString("title"));
			}
			else if(str.equals("next") && rs.next()) {
				vo.setNextIdx(rs.getInt("idx"));
				vo.setNextTitle(rs.getString("title"));				
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vo;
	}

	// 검색기 처리
	public ArrayList<BoardVO> getBoContentSearch(String search, String searchString) {
		ArrayList<BoardVO> vos = new ArrayList<>();
		try {
			sql = "select * from board where "+search+" like ? order by idx desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+searchString+"%");
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				vo = new BoardVO();
				vo.setIdx(rs.getInt("idx"));
				vo.setNickName(rs.getString("nickName"));
				vo.setTitle(rs.getString("title"));
				vo.setEmail(rs.getString("email"));
				vo.setHomePage(rs.getString("homePage"));
				vo.setContent(rs.getString("content"));
				vo.setwDate(rs.getString("wDate"));
				vo.setHostIp(rs.getString("hostIp"));
				vo.setReadNum(rs.getInt("readNum"));
				vo.setGood(rs.getInt("good"));
				vo.setMid(rs.getString("mid"));
				
				/*
				 * vo.setDay_diff(rs.getInt("day_diff"));
				 * vo.setHour_diff(rs.getInt("hour_diff"));
				 */
				
				vos.add(vo);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return vos;
	}

	// 댓글 입력하기
	public String setReplyInputOk(BoardReplyVO replyVo) {
		String res = "0";
		try {
			sql = "insert into boardReply values (default, ?, ?, ?, default, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyVo.getBoardIdx());
			pstmt.setString(2, replyVo.getMid());
			pstmt.setString(3, replyVo.getNickName());
			pstmt.setString(4, replyVo.getHostIp());
			pstmt.setString(5, replyVo.getContent());
			pstmt.executeUpdate();
			res = "1";
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}

	// 댓글 출력을 위해 가져오기
	public ArrayList<BoardReplyVO> getBoReply(int idx) {
		ArrayList<BoardReplyVO> replyVos = new ArrayList<>();
		try {
			sql = "select * from boardReply where boardIdx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardReplyVO replyVo = new BoardReplyVO();
				
				replyVo.setIdx(rs.getInt("idx"));
				replyVo.setBoardIdx(idx);
				replyVo.setMid(rs.getString("mid"));
				replyVo.setNickName(rs.getString("nickName"));
				replyVo.setwDate(rs.getString("wDate"));
				replyVo.setHostIp(rs.getString("hostIp"));
				replyVo.setContent(rs.getString("content"));
				
				replyVos.add(replyVo);
				System.out.println("replyVos : " + replyVos);
			}
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.rsClose();
		}
		return replyVos;
	}

	//댓글 삭제하기
	public String setBoReplyDeleteOk(int idx) {
		String res = "0";
		try {
			sql = "delete from boardReply where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, idx);
			pstmt.executeUpdate();
			res = "1";
		} catch (SQLException e) {
			System.out.println("SQL 에러 : " + e.getMessage());
		} finally {
			getConn.pstmtClose();
		}
		return res;
	}
	
}
	

