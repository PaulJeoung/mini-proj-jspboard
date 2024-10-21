<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷Vote]</title>
</head>
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;">
	<div align="center">
		<br/><hr/><h3>VOTE 2024</h3>
		<hr width="80%"/>
		<b>설문작성양식</b><br/>
		<form method="post" action="poll-insert-proc.jsp" accept-charset="UTF-8">
			<table>
				<tr>
					<td colspan="2" align="center"><br/></td>
				</tr>
				<tr>
					<td><b>질문</b></td>
					<td colspan="2">
						<input type="text" name="question" size="30">
					</td>
				</tr>
				<tr>
						<td colspan="2" align="center"><br/></td>
				</tr>
				<tr>
					<td rowspan="4" valign="top"><b>보기</b></td>
					<%
						for (int i=1; i<=4; i++) {
							// out.println("<td>" + (i*2-1) + " : <input type='text' name='item'></td>");
							out.println("<td>" + i + "<input type='text' name='item' size='27'></td>");
							if(i==4) {
								out.println("");
							} else {
								out.println("<tr>");
							}
						}
					%>
					<tr>
						<td colspan="2" align="center"><br/></td>
					</tr>
					<tr>
						<td>시작일</td>
						<td colspan="2">
							<select name="sdateY">
							<%
								for (int i=2024; i<2026; i++) {
									out.println("<option value'" + i + "'>" + i);
								}
							%>
							</select>년
							<select name="sdateM">
							<%
								for (int i=1; i<13; i++) {
									out.println("<option value'" + i + "'>" + i);
								}
							%>
							</select>월 
							<select name="sdateD">
							<%
								for (int i=1; i<32; i++) {
									out.println("<option value'" + i + "'>" + i);
								}
							%>
							</select>일
						</td>
					</tr>
					<tr>
						<td>종료일</td>
						<td colspan="2">
							<select name="edateY">
							<%
								for (int i=2024; i<2026; i++) {
									out.println("<option value'" + i + "'>" + i);
								}
							%>
							</select>년
							<select name="edateM">
							<%
								for (int i=1; i<13; i++) {
									out.println("<option value'" + i + "'>" + i);
								}
							%>
							</select>월 
							<select name="edateD">
							<%
								for (int i=1; i<32; i++) {
									out.println("<option value'" + i + "'>" + i);
								}
							%>
							</select>일
						</td>
					</tr>
					<tr>
						<td colspan="2" align="center"><br/></td>
					</tr>	
					<tr>
						<td>복수 투표</td>
						<td colspan="2" align="center">
							<input type="radio" name="type" value="1" checked="checked">허용
							<input type="radio" name="type" value="0" >비허용
						</td>
					</tr>
					<tr>
						<td colspan="3" align="center"><br/></td>
					</tr>	
					<tr>
						<td colspan="3" align="center">
							<input type="submit" value="작성하기" >
							<input type="reset" value="다시쓰기" >
							<input type="button" value="리스트" onclick="javascript:location.href='poll-list.jsp'">
						</td>
					</tr>
				<!-- /tr -->
			</table>
		</form>
	</div>
</body>
</html>