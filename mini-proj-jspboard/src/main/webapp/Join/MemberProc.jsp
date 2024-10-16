<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mgr" class="member.MemberMgr"/>
<jsp:useBean id="bean" class="member.MemberBean"/>
<jsp:setProperty property="*" name="bean"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%
	boolean result = mgr.insertMember(bean);
	String msg = "회원가입에 실패 하였습니다";
	String location ="Member.jsp";
	if(result) {
		msg = "회원가입이 완료 되었습니다";
		location = "../Login/Login.jsp";
	}
%>
<script>
	alert("<%=msg%>");
	location.href = "<%=location%>"
</script>
<title>회원가입확인</title>
</head>
<body>

</body>
</html>