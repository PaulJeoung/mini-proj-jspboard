<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vote.*" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="pMgr" class="vote.PollMgr"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷Vote]</title>
</head>
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">
	<div align="center">
		<br/>
		<h3>VOTE 2024</h3>
		<hr width="95%"/><br/>
		<b>최신 투표</b>
		<jsp:include page="poll-form.jsp"></jsp:include><br/>
		<hr width="95%"/>
		<b>투표 리스트</b>
		<table>
			<tr><td colspan="3"><br/></td></tr>
			<tr>
				<td>
					<table width=500" border="1" style="">
						<tr>
							<td align="center"><b>NO</b>
							</td>
							<td align="center"><b>제목</b></td>
							<td align="center"><b>시작일-종료일</b></td>
						</tr>
						<%
							Vector<PollListBean> vlist = pMgr.getAllList();
							int count = vlist.size();
							for (int i=0; i<vlist.size(); i++) {
								PollListBean plBean = vlist.get(i);
								int num = plBean.getNum();
								String question = plBean.getQuestion();
								String sdate = plBean.getSdate();
								String edate = plBean.getEdate();
								
								out.println("<tr><td align='center'>" + count + "</td>");
								out.println("<td><a style='color:#ffffff' href='poll-list.jsp?num=" + num + "'>" + question + "</a></td>");
								out.println("<td>" + sdate + " ~ " + edate + "</td></tr>");
								
								count = count-1;
							}
						%>
					</table>
				</td>
			</tr>
			<tr><td colspan="3"><br/></td></tr>
			<tr>
				<td align="center"><a style="color: #ffffff" href="poll-insert.jsp">투표만들기</a></td>
			</tr>
		</table>
	</div>
</body>
</html>