<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bean" class="board.BoardBean" scope="session"></jsp:useBean>
<%
	String nowPage = request.getParameter("nowPage");
	String subject = bean.getSubject();
	String content = bean.getContent();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷펑크]</title>
</head>
<body style="color: azure;" bgcolor="gray" >
<div align="center">
	<hr/>
	<table width="460" cellspacing="0" cellpadding="3">
		<tr>
			<td bgcolor="black" height="21" align="center">답변하기</td>
		</tr>
	</table>
	<form method="post" action="boardReply">
		<table width="600" cellpadding="7">
			<tr>
				<td align="center">
					<table>
						<tr>
							<td width="20%">이름</td>
							<td width="80%"><input name="name" size="30" maxlength="20" /></td>
						</tr>
						<tr>
							<td>제목</td>
							<td><input name="subject" size="50" maxlength="50" value="ㄴ 답변 : <%=subject %>"/></td>
						</tr>
						<tr>
							<td>내용</td>
							<td>
							<textarea name="content" rows="12" cols="50" >
								<%=content %>
								============= 댓글 달아주세요 =============
							</textarea>
							</td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td><input type="password" name="pass" size="20" maxlength="20" placeholder="비밀번호를 넣어주세요"/></td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="submit" value="답변등록"/>
								<input type="reset" value="다시쓰기"/>
								<input type="button" value="뒤로" onclick="history.back()"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
			<input type="hidden" name="ip" value="<%= request.getRemoteAddr() %>">
			<input type="hidden" name="nowPage" value="<%= nowPage %>">
			<input type="hidden" name="ref" value="<%= bean.getRef() %>">
			<input type="hidden" name="pos" value="<%= bean.getPos() %>">
			<input type="hidden" name="depth" value="<%= bean.getDepth() %>">
	</form>
</div>
</body>
</html>