<!-- 
	create : 2024-10-14
	author : paul jeoung
	file   : FileSelect.jsp
	title  : 파일 업로드를 위한 파일 셀렉트 페이지
	desc   : cos.jar 다운로드
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<style>
		table {
			text-align: "center";
		}
	</style>
</head>
<body>
	<form name="frmName" method="post" enctype="multipart/form-data" action="ViewPage.jsp">
		<table border="1" width="60%" >
			<tr>
				<td>USER</td>
				<td><input name="user"  /></td>
			</tr>
			<tr>
				<td>TITLE</td>
				<td><input name="title"  /></td>
			</tr>
			<tr>
				<td>FILE</td>
				<td><input type="file" name="uploadFile" /></td>
			</tr>
            <tr>
                <td colspan="2">
                    <input type="submit" value="UPLOAD"/>
                </td>
            </tr>
		</table>
	</form>
</body>
</html>