<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vote.*" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="pMgr" class="vote.PollMgr"></jsp:useBean>
<%
	request.setCharacterEncoding("UTF-8");
	int num = 0;
	if (request.getParameter("num")!=null) {
		num = Integer.parseInt(request.getParameter("num"));
	}
	int sum = pMgr.sumCount(num);
	Vector<PollItemBean> vlist = pMgr.getView(num);
	PollListBean plBean = pMgr.getList(num);
	String question = plBean.getQuestion();
	Random r = new Random();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷Vote]</title>
</head>
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">
	<div align="center">
		<table border="1" width="600">
			<tr>
				<td colspan="4"><b>총 투표수 : <%=sum %>명</b>
				</td>
				<td width="40">Count</td>
			</tr>
			<%
				for (int i=0; i<vlist.size(); i++) {
					PollItemBean piBean = vlist.get(i);
					String[] item = piBean.getItem();
					int rgb = r.nextInt(255 * 255 * 255);
					String rgbt = Integer.toHexString(rgb);
					String hRGB = '#' + rgbt;
					int count = piBean.getCount();
					int ratio = (new Double(Math.ceil((double) count / sum * 100))).intValue();
			%>
			<tr>
				<td width="20" align="center"><%=i+1 %></td>
				<td width="120" ><%=item[0] %></td>
				<td>
					<table>
						<tr>
							<td bgcolor="<%=hRGB%>"></td>
						</tr>
					</table>
				</td>
				<td width="40"><%=count %></td>
			</tr>
			<% } %>
		</table>
		<p/>
		<a style="color: #ffffff;" href="javascript:window.close()">닫기</a>
	</div>
</body>
</html>