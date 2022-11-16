package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;


@WebFilter("/*") // 모든 파일 여기 거치도록!
// Filter(인터페이스)는 servlet 걸 implements 하기!
public class EncodingFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		request.setCharacterEncoding("utf-8");
//		response.setCharacterEncoding("utf-8"); // -> jsp에서 필요하니까 필수는 XXX
		response.setContentType("text/html; charset=utf-8");
		
//		System.out.println("이곳은 Filter 통과 전전전전전전!!!");
		
		// 나는 어떤 것이든 다 통과시킬래! (기억 잘 해두기!!!!!!!!)
		chain.doFilter(request, response);
		
//		System.out.println("이곳은 Filter 통과 후후후후후후!!!");
		
	}
	
}
