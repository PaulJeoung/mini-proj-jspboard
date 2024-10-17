package board;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Board/boardUpdate")
public class BoardUpdateServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("Update.jsp로 부터 submit 실행 후 servlet 동작");
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html; charset=UTF-8");
		
		HttpSession session = req.getSession();
		PrintWriter out = resp.getWriter();
		
		BoardMgr bMgr = new BoardMgr();
		BoardBean bean = (BoardBean) session.getAttribute("bean");
		String nowPage = req.getParameter("nowPage");
		
		BoardBean upBean = new BoardBean();
		upBean.setNum(Integer.parseInt(req.getParameter("num")));
		upBean.setName(req.getParameter("name"));
		upBean.setSubject(req.getParameter("subject"));
		upBean.setContent(req.getParameter("content"));
		upBean.setPass(req.getParameter("pass"));
		upBean.setIp(req.getParameter("ip"));
		
		String upPass = upBean.getPass();
		String inPass = bean.getPass();
		
		if(upPass.equals(inPass)) {
			bMgr.updateBoard(upBean);
			String url = "Read.jsp?nowPage=" + nowPage + "&num=" + upBean.getNum();
			resp.sendRedirect(url);
		} else {
			out.println("<script>");
			out.println("alert('입력하신 비밀번호가 아닙니다')");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}
