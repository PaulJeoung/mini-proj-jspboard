<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	session.invalidate();
	String location = "Login.jsp";
%>
<script>
	alert("로그아웃 되었습니다");
	location.href = "<%=location%>"
</script>
<title>회원로그아웃확인</title>
</head>
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">

</body>
</html>