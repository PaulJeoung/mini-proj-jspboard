<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vote.*" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="pMgr" class="vote.PollMgr"></jsp:useBean>
<%
	int num = 0;
	if(!(request.getParameter("num")==null || request.getParameter("num").equals(""))) {
		num = Integer.parseInt(request.getParameter("num"));
	}
	
	PollListBean plBean = pMgr.getList(num);
	Vector<String> vlist = pMgr.getItem(num);
	
	String question = plBean.getQuestion();
	int type = plBean.getType();
	int active = plBean.getActive();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷Vote]</title>
</head>
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">
	<form method="post" action="poll-form-proc.jsp">
		<table>
			<tr>
				<td colspan="2"> Question : <%=question %> </td>
			</tr>
			<tr>
				<td colspan="2"><%
					for (int i=0; i<vlist.size(); i++) {
						String itemList = vlist.get(i);
						if(type==1){
							out.println("<input type=checkbox name='itemnum' value='" + i + "'>");
						} else {
							out.println("<input type=radio name='itemnum' value='" + i + "'>");
						}
						out.println(itemList + "<br/>");
					}
				%></td>
			</tr>
			<tr>
				<td><%
					if(active==1) {
						out.println("<input type=submit value='투표'>");
					} else {
						out.println("투표");
					}
				%>
				</td>
				<td>
					<input type="button" value="결과" onclick="javascript:window.open('poll-view.jsp?num=<%=num %>', PollView', 'width=500, height=350')">
				</td>
			</tr>
		</table>
		<input type="hidden" name="num" value="<%=num %>">
	</form>
</body>
</html>