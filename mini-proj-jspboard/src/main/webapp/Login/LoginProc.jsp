<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	String location = "Login.jsp";
	String msg = "로그인에 실패 했습니다";
	
	boolean result = mMgr.loginMember(id, pwd);
	if (result) {
		session.setAttribute("idKey", id);
		msg = "로그인에 성공 하였습니다";
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=location%>"
</script>
<title>회원로그인확인</title>
</head>
<body>

</body>
</html>