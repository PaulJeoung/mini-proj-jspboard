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
		System.out.println("Delete.jsp :: pass 확인 완료");
		if(inPass.equals(dbPass)) {
			bMgr.deleteBoard(num);
			String url = "List.jsp?nowPage=" + nowPage;
			response.sendRedirect(url);
			System.out.println("Delete.jsp :: 삭제후 List.jsp 리다이렉트");
		} else {
			System.out.println("Delete.jsp :: pass 확인 실패");
		%>
			<script type="text/javascript">
				alert("잘못된 비밀번호 입니다");
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
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">
<div align="center">
	<hr><h2 align="center">[Shake_it Funk Board]</h2>
	<br/>
	<table width="500" cellpadding"3">
		<tr>
			<td bgcolor=gray height="21" align="center">
			삭제를 위해서 비밀번호를 입력해 주세요
			</td>
		</tr>
		<tr><td><br/></td></tr>
	</table>
	<form name="delFrm" method="post" action="Delete.jsp">
		<table width="600" cellpadding="2">
			<tr>
				<td align="center">
					<table>
						<tr>
							<td align="center">
								<input type="password" name="pass" size="17" maxlength="15" placeholder="비밀번호 입력" >
							</td>
						</tr>
						<tr>
							<td><br/></td>
						</tr>
						<tr>
							<td>
								<input type="button" value="삭제완료" onclick="check()">
								<input type="reset" value="다시쓰기">
								<input type="button" value="뒤로" onclick="history.go(-1)">
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<input type="hidden" name="nowPage" value="<%=nowPage %>">
		<input type="hidden" name="num" value="<%=num %>">
	</form>
</div>
<hr/>
</body>
</html>