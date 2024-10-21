<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="pMgr" class="vote.PollMgr"></jsp:useBean>
<jsp:useBean id="plBean" class="vote.PollListBean"></jsp:useBean>
<jsp:useBean id="piBean" class="vote.PollItemBean"></jsp:useBean>
<jsp:setProperty property="*" name="plBean"/>
<jsp:setProperty property="*" name="piBean"/>
<%
	request.setCharacterEncoding("UTF-8");
	String sdate = request.getParameter("sdateY") + "-" + request.getParameter("sdateM") + "-" + request.getParameter("sdateD");
	String edate = request.getParameter("edateY") + "-" + request.getParameter("edateM") + "-" + request.getParameter("edateD");
	
	String[] items = request.getParameterValues("item"); // 확인이 필요할때를 위해 추가
	
	plBean.setSdate(sdate);
	plBean.setEdate(edate);
	boolean flag = pMgr.insertPoll(plBean, piBean);
	String msg = "설문 추가에 실패 하였습니다";
	String url = "poll-insert.jsp";
	if (flag) {
		msg = "설문이 추가 되었습니다";
		url = "poll-list.jsp";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷Vote]</title>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>
</head>
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">

</body>
</html>
