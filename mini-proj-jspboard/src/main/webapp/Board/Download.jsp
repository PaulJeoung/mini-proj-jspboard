<%@page import="board.BoardMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean>
<%
	bMgr.download(request, response, out, pageContext);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷펑크]</title>
</head>
<body style="color: azure;" bgcolor="gray" >

</body>
</html>