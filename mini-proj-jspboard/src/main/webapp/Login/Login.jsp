<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script type="text/javascript">
	function loginCheck() {
		if (document.loginFrm.id.value == "") {
			alert("아이디를 입력해 주세요");
			document.loginFrm.id.focus();
			return;
		}
		if (document.loginFrm.pwd.value == "") {
			alert("비밀번호를 입렵해 주세요");
			document.loginFrm.pwd.focus();
			return;
		}
		document.loginFrm.submit();
	}
</script>
</head>
<body>
	<div align="center">
		<% if (id != null) { %>
		<b><%=id %>님 환영합니다</b>
		<p>
			제한된 기능을 사용 할 수가 있습니다
		</p>
		<a href="Logout.jsp">로그아웃</a>
		<% } else { %>
		<form name="loginFrm" method="post" action="LoginProc.jsp">
			<table>
				<tr>
					<td>아이디</td>
					<td><input type="text" name="id"/></td>
				</tr>
				<tr>
					<td>비밀번호</td>
					<td><input type="password" name="pwd"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="로그인" onclick="loginCheck()"/>&nbsp;
						<input type="button" value="회원가입" onclick="javascript:location.href='../Join/Member.jsp'"/>
					</td>
				</tr>
			</table>
		
		</form>
		<% } %>
	</div>


</body>
</html>