<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="pMgr" class="vote.PollMgr"></jsp:useBean>

<%
	request.setCharacterEncoding("UTF-8");
	int num = Integer.parseInt(request.getParameter("num"));
	String[] itemnum = request.getParameterValues("itemnum");
	boolean flag = pMgr.updatePoll(num, itemnum);
	String msg = "투표가 등록되지 않았습니다";

	if (flag) {
		msg = "투표가 정상적으로 등록되었습니다";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷Vote]</title>
<script type="text/javascript">
	alert("<%=msg%>");
	location.href="poll-list.jsp?num=<%=num%>";
</script>
</head>
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">

</body>
</html>