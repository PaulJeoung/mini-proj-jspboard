<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷펑크]</title>
</head>
<body style="color: azure;" bgcolor="gray" >
	<div>
		<table width="600" cellpadding="3" align="center">
			<tr>
				<td bgcolor="gray" height="25" align="center">글쓰기</td>
			</tr>
		</table>
		<br/>
		<form name="postFrm" method="post" enctype="multipart/form-data" action="boardPost">
			<table width="600" cellpadding="3" align="center">
				<tr>
					<td align="center">
						<table align="center">
							<tr>
								<td width="20%">작성자</td>
								<td width="80%"><input name="name" size="50" maxlength="8" placeholder="이름을 적어주세요"></td>
							</tr>
							<tr>
								<td>제목</td>
								<td><input name="subject" size="50" maxlength="30" placeholder="제목을 작성해 주세요"></td>
							</tr>
							<tr>
								<td>내용</td>
								<td><textarea name="content" rows="10" cols="50" placeholder="내용을 입력해 주세요"></textarea></td>
							</tr>
							<tr>
								<td>비밀번호</td>
								<td><input type="password" name="pass" size="15" maxlength="15"></td>
							</tr>
							<tr>
								<td>파일찾기</td>
								<td><input type="file" name="filename" size="50" maxlength="50"></td>
							</tr>
							<tr>
								<td>내용타입</td>
								<td>
								HTML<input type="radio" name="contentType" value="HTTP">&nbsp; &nbsp; &nbsp;
								TEXT<input type="radio" name="contentType" value="TEXT" checked="checked">
								</td>
							</tr>
							<tr>
								<td colspan="2"></td>
							</tr>
							<tr>
								<td colspan="2" align="center">
									<input type="submit" value="등록">
									<input type="reset" value="다시쓰기">
									<input type="button" value="리스트" onclick="javascript:location.href='List.jsp'">
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
		</form>
	</div>
</body>
</html>