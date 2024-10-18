<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.LoginResult" %>
<%@ page import="member.MemberMgr" %>
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
	
	LoginResult result = mMgr.loginMember(id, pwd);
	
	if(result.isSuccess()) {
		session.setAttribute("idKey", id);
		msg = "로그인에 성공 하였습니다";
		} else {
			if(!result.isIdValid()){
				msg = "유효하지 않은 ID 입니다";
			} else if(!result.isPwdValid()) {
				msg = "비밀번호가 일치 하지 않습니다";
			}
		}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=location%>"
</script>
<title>회원로그인확인</title>
</head>
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">

</body>
</html>