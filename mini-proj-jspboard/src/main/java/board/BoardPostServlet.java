package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Board/boardPost")
public class BoardPostServlet extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println(getClass() + " :: doPost() :: Post.jsp에서 servlet을 호출");
		req.setCharacterEncoding("UTF-8");
		BoardMgr bMgr = new BoardMgr();
		System.out.println(getClass() + " :: doPost() :: BoardMgr의 insertBoard() 로직 시작");
		bMgr.insertBoard(req);
		System.out.println(getClass() + " :: doPost() :: 포스팅 완료 후 List.jsp 리다이렉트");
		resp.sendRedirect("List.jsp");
	}
}
