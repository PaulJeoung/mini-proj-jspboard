<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<jsp:useBean id="mMgr" class="member.MemberMgr"/>
<html>
<head>
<meta charset="UTF-8">
<title>ID VAILDATION CHECK</title>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	boolean result = mMgr.checkId(id);
%>

<link href="style.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div align="center">
		<b><%=id %></b>
		<%
			if (result) {
				out.println(" 는 이미 존재 하는 ID 입니다<p/>");
			} else {
				out.println(" 는 사용 가능한 ID 입니다<p/>");
			}
		%>
		<a href="#" onClick="self.close()">닫기</a>
	
	</div>
</body>
</html>