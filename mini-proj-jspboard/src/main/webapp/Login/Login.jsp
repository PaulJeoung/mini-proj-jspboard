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
	
	function rediectToList() {
		setTimeout(function() {
			window.location.href = '../Board/List.jsp';			
		}, 3000);
	}
</script>
</head>
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">
<hr/><br/>
	<div align="center">
		<% if (id != null) { %>
		<h2><%=id %> 님 환영합니다</h2><br/><br/>
		<p>
			<b>잠시 후 SHAKE_IT FUNK BOARD 로 이동 합니다</b><br/>
			<b>원하지 않으시면 3초 안에 아래 로그아웃을 누르세요</b><br/><br/><br/><br/>
			아래 눌러서 도망가기<br/>
			🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽<br/><br/>
			<!-- input type="button" value="SHAKE_IT FUNK BOARD" onClick="javascript:location.href='../Board/List.jsp'" -->
		</p>
		<a style="color: #66ff66;" href="Logout.jsp">로그아웃</a>
		
		<script type="text/javascript">
			rediectToList();
		</script>
		
		<% } else { %>
		<form name="loginFrm" method="post" action="LoginProc.jsp">
			<table>
				<tr><td><br/></td></tr>
				<tr>
					<td>ID</td>
					<td><input type="text" name="id" placeholder="input your id"/></td>
				</tr>
				<tr>
					<td>PASSWORD</td>
					<td><input type="password" name="pwd" placeholder="password here!!"/></td>
				</tr>
				<tr><td><br/></td></tr>
				<tr>
					<td colspan="2" align="center">
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