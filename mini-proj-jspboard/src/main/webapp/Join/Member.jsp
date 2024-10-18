<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JOIN</title>
<!-- link href="style.css" rel="stylesheet" type="text/css" -->
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
	function idCheck(id) {
		if (id == "") {
			alert("Hey, input your ID now");
			frm.id.focus();
			return;
		}
		url = "IdCheck.jsp?id="+id;
		window.open(url, "ID_CHECK", "width=450, height=250");
	}
	function zipCheck() {
		url = "ZipSearch.jsp?check=n";
		window.open(url, "ZIP_CODE_SEARCH", "width=450, height=600, scrollbars=yes");
	}
</script>
</head>
<!-- body onLoad="regFrm.id.focus()" -->
<body style="color: #66ff66; background-color: #1c1c1c; font-family: consolas;" onLoad="regFrm.id.focus()">
	<div align="center">
		<hr/>
		<form name="regFrm" method="post" action="MemberProc.jsp">
			<table align="center" style="color: #66ff66;">
				<tr><td><br/></td></tr>
				<tr>
					<td colspan="3" align="center">NEWBIE COMEIN (SIGNIN)</td>
				</tr>
				<tr><td><br/></td></tr>
				<tr>
					<td width="30%">ID</td>
					<td width="40%">
						<input type="text" name="id" size="25" placeholder="put the ID">
					</td>
					<td width="30%">
						<input type="button" value="ID vaild Check" onClick="idCheck(this.form.id.value)">
					</td>
				</tr>
				<tr>
					<td>PASSWORD</td>
					<td>
						<input type="password" name="pwd" size="25" placeholder="put your password">
					</td>
					<td>
						<input type="password" name="repwd" size="25" placeholder="check your password">
					</td>
				</tr>
				<tr>
					<td>NAME</td>
					<td colspan="2">
						<input type="text" name="name" size="25" placeholder="What`s your name">
					</td>
				</tr>
				<tr>
					<td>GENDER</td>
					<td colspan="2">
						MALE<input type="radio" name="gender" value="1" checked="checked">&nbsp;&nbsp;
						FEMALE<input type="radio" name="gender" value="2">
					</td>
				</tr>
				<tr>
					<td>BIRTHDAY</td>
					<td colspan="2">
						<input type="text" name="birthday" size="25" placeholder="ex) 950827">
					</td>
				</tr>
				<tr>
					<td>EMAIL</td>
					<td colspan="2">
						<input type="email" name="email" size="25" placeholder="ex) guest1014@newpage.com">
					</td>
				</tr>
				<tr>
					<td>ZIPCODE</td>
					<td>
						<input type="text" name="zipcode" size="25" placeholder="search button please..." readonly>
					</td>
					<td>
						<input type="button" value="SEARCH ZIP_CODE" onClick="zipCheck()">
					</td>
				</tr>
				<tr>
					<td>ADDRESS</td>
					<td colspan="2">
						<input type="text" name="address" size="50" placeholder="HOME address here">
					</td>
				</tr>
				<tr>
					<td>CHOOSE IT</td>
					<td colspan="2">
						<input type="checkbox" name="hobby" value="인터넷"><label>NET SURFING</label>&nbsp;
						<input type="checkbox" name="hobby" value="여행"><label>JOURNEY</label>&nbsp;
						<input type="checkbox" name="hobby" value="게임"><label>PLAY GAMEING</label>&nbsp;
						<input type="checkbox" name="hobby" value="영화"><label>JUST TV</label>&nbsp;
						<input type="checkbox" name="hobby" value="운동"><label>GYM HOLICS</label>
					</td>
				</tr>
				<tr>
					<td>JOB</td>
					<td colspan="2">
						<select name="job">
							<option value="0" selected>CHOOSE IT!!
							<option value="회사원">회사원
							<option value="연구전문직">연구/전문직
							<option value="교수,학생">교수/학생
							<option value="일반자영업">일반자영업
							<option value="공무원">공무원
							<option value="의료인">의료인
							<option value="법조인">법조인
							<option value="종교,언론,예술인">종교/언론/예술인
							<option value="농산,축산,수산,광업인">농/축/수산/광업인
							<option value="주부">주부
							<option value="무직">무직
							<option value="기타">기타
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="3" align="center">
						<input type="button" value="SIGNIN" onclick="inputCheck()">&nbsp;&nbsp;
						<input type="reset" value="RESET">&nbsp;&nbsp;
						<input type="button" value="LOGIN" onClick="javascript:location.href='../Login/Login.jsp'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>