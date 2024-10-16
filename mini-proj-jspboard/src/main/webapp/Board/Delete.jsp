<%@page import="board.BoardBean"%>
<%@page import="board.BoardMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	String nowPage = request.getParameter("nowPage");
	int num = Integer.parseInt(request.getParameter("num"));
	if(request.getParameter("pass")!=null){
		String inPass = request.getParameter("pass");
		BoardBean bean = (BoardBean) session.getAttribute("bean");
		String dbPass = bean.getPass();
		if(inPass.equals(dbPass)) {
			bMgr.deleteBoard(num);
			String url = "List.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);
		} else {
		%>
			<script type="text/javascript">
				alert("입력하신 비밀번호가 압니다");
				history.back();
			</script>
	<%	}
	} else {
	%>
		<script type="text/javascript">
			function check() {
				if(document.delFrm.pass.value=="") {
					alert("패스워드를 입력하세요");
					document.delFrm.pass.focus();
					return false;
					} document.delFrm.submit();
				}
		</script>
	<% } %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷펑크]</title>
</head>
<body style="color: azure;" bgcolor="gray" >

</body>
</html>