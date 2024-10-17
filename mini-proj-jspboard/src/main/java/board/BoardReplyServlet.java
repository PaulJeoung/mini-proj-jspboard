package board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Board/boardReply")
public class BoardReplyServlet extends HttpServlet{
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println(getClass() + " :: doPost() :: reply 서블릿 메소드 시작");
		
		req.setCharacterEncoding("UTF-8");
		BoardMgr bMgr = new BoardMgr();
		BoardBean reBean = new BoardBean();
		reBean.setName(req.getParameter("name"));
		reBean.setSubject(req.getParameter("subject"));
		reBean.setContent(req.getParameter("content"));
		reBean.setRef(Integer.parseInt(req.getParameter("ref")));
		reBean.setPos(Integer.parseInt(req.getParameter("pos")));
		reBean.setDepth(Integer.parseInt(req.getParameter("depth")));
		reBean.setPass(req.getParameter("pass"));
		reBean.setIp(req.getParameter("ip"));
		
		bMgr.replyUpBoard(reBean.getRef(), reBean.getPos());
		bMgr.replyBoard(reBean);
		
		String nowPage = req.getParameter("nowPage");
		resp.sendRedirect("List.jsp?nowPage=" + nowPage);
	}
}