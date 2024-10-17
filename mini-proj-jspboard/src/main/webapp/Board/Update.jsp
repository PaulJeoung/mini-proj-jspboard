<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- <jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean> -->
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String nowPage = request.getParameter("nowPage");
	BoardBean bean = (BoardBean)session.getAttribute("bean");
	String subject = bean.getSubject();
	String name = bean.getName();
	String content = bean.getContent();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷펑크]</title>
<script>
	function check() {
		if(document.updateFrm.pass.value=="") {
			alert("수정을 위해 패스워드를 입력하세요");
			document.updateFrm.pass.focus();
			return false;
		}
		document.updateFrm.submit();
	}
</script>
</head>
<body style="color: azure;" bgcolor="gray" >
	<div align="center">
	<hr/>
		<table width="460" cellspacing="0" cellpadding="3">
			<tr>
				<td bgcolor="black" height="21" align="center">수정하기</td>
			</tr>
		</table>
		<form name="updateFrm" method="post" action="boardUpdate">
			<table widthi="70%" cellspacing="0" cellpadding="7">
				<tr>
					<td align="center">
						<table>
							<tr>
								<td width="20%">성명</td>
								<td width="80%"><input name="name" value="<%=name %>" size="30" maxlength="20"/></td>
							</tr>
							<tr>
								<td>제목</td>
								<td><input name="subject" value="<%=subject %>" size="50" maxlength="50"/></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea name="content" value="<%=content %>" rows="10" cols="50"></textarea></td>
							</tr>
							<tr>
								<td>비밀번호</td>
								<td><input type="password" name="pass" size="35" maxlength="15" placeholder="수정을 위해 비밀번호를 넣어 주세요"/></td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="button" value="수정완료" onclick="check()" />
									<input type="reset" value="다시수정" />
									<input type="button" value="뒤로" onclick="history.go(-1)" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="nowPage" value="<%=nowPage%>" />
			<input type="hidden" name="num" value="<%=num%>" />
		</form>
	</div>
</body>
</html>