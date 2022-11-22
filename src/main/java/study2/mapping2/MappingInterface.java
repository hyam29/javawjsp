package study2.mapping2;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface MappingInterface {
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException;
	// 반환 타입 없어야 계산하고 끝나서 직렬화 가능! 따라서 인터페이스 무조건 void 리턴타입!!!
	// 컨트롤러의 값 request 로 넘겨받아서 response 로 처리할 Command한테 값 넘겨줄거야~
	// => 메소드를 정의만 하지, 구현하는 것 XXX 따라서 중괄호{} 없고 세미콜론; 으로 마감
	
	// execute 는 변수명으로 다른 걸로 해도 됨!!!
}
