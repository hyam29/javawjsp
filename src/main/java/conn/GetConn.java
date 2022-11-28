package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class GetConn {
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	private String driver ="com.mysql.jdbc.Driver";
	private String url = "jdbc:mysql://localhost:3306/javaworks";
	private String user = "root";
	private String password = "1234";
	
	// DB 생성하면서 instance(싱글톤) 함께 생성 -> 함부로 생성하면 안되니까 private -> gettersetter 생성해야함 => 이후에 부를 때는 클래스명.메소드명으로 어디서든지 사용할 때 불러올 수 있음
	private static GetConn instance = new GetConn(); // 메소드메모리에 올려야 하므로 static으로 생성
	
	// 객체 생성 시 DB 연결 (외부에서 함부로 연결하면 안되니까, 접근제한자는 private)
	private GetConn() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, password);
		} catch (ClassNotFoundException e) {
			System.out.println("드라이버 검색 실패 (lib의 mysql connector 유무확인)");
		} catch (SQLException e) {
			System.out.println("DB 연동 실패 (url, user, pwd, MySQL 확인)");
		}
	}
	
	// 웹에서 호출하지 못했을 때 사용할 대체 메소드 생성 (연결 목적이니까, 타입은 Connection 객체)
	public Connection getConn() {
		return conn;
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

	// 싱글톤 객체 생성시 private 으로 생성했으니, 읽을 때 필요한 getter 생성! (set은 안하니까, get만 생성함)
	public static GetConn getInstance() {
		return instance;
	}
	
}
