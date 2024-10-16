<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JOIN</title>
<link href="style.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="script.js"></script>
<script type="text/javascript">
	function idCheck(id) {
		if (id == "") {
			alert("아이디를 입력해 주세요");
			frm.id.focus();
			return;
		}
		url = "IdCheck.jsp?id="+id;
		window.open(url, "ID_CHECK", "width=300, height=150");
	}
	function zipCheck() {
		url = "ZipSearch.jsp?check=n";
		window.open(url, "ZIP_CODE_SEARCH", "width=500, heught=300, scrollbars=yes");
	}
</script>
</head>
<body onLoad="regFrm.id.focus()">
	<div align="center">
		<hr/>
		<form name="regFrm" method="post" action="MemberProc.jsp">
			<table align="center" >
				<tr>
					<td colspan="3" align="center">회원가입</td>
				</tr>
				<tr>
					<td width="30%">아이디</td>
					<td width="40%">
						<input type="text" name="id" size="25" placeholder="아이디를 적어주세요">
					</td>
					<td width="30%">
						<input type="button" value="ID중복확인" onClick="idCheck(this.form.id.value)">
					</td>
				</tr>
				<tr>
					<td>패스워드</td>
					<td>
						<input type="password" name="pwd" size="25" placeholder="비밀번호를 넣어주세요">
					</td>
					<td>
						<input type="password" name="repwd" size="25" placeholder="비밀번호를 확인합니다">
					</td>
				</tr>
				<tr>
					<td>이름</td>
					<td colspan="2">
						<input type="text" name="name" size="25" placeholder="이름을 넣어 주세요">
					</td>
				</tr>
				<tr>
					<td>성별</td>
					<td colspan="2">
						남<input type="radio" name="gender" value="1" checked="checked">&nbsp;&nbsp;
						여<input type="radio" name="gender" value="2">
					</td>
				</tr>
				<tr>
					<td>생년월일</td>
					<td colspan="2">
						<input type="text" name="birthday" size="25" placeholder="ex) 950827">
					</td>
				</tr>
				<tr>
					<td>이메일</td>
					<td colspan="2">
						<input type="email" name="email" size="25" placeholder="ex) guest1014@newpage.com">
					</td>
				</tr>
				<tr>
					<td>우편번호</td>
					<td>
						<input type="text" name="zipcode" size="25" placeholder="찾기버튼을 눌러주세요" readonly>
					</td>
					<td>
						<input type="button" value="우편번호찾기" onClick="zipCheck()">
					</td>
				</tr>
				<tr>
					<td>주소</td>
					<td colspan="2">
						<input type="text" name="address" size="50" placeholder="주소를 적어주세요">
					</td>
				</tr>
				<tr>
					<td>취미</td>
					<td colspan="2">
						<input type="checkbox" name="hobby" value="인터넷"><label>인터넷</label>&nbsp;
						<input type="checkbox" name="hobby" value="여행"><label>여행</label>&nbsp;
						<input type="checkbox" name="hobby" value="게임"><label>게임</label>&nbsp;
						<input type="checkbox" name="hobby" value="영화"><label>영화</label>&nbsp;
						<input type="checkbox" name="hobby" value="운동"><label>운동</label>
					</td>
				</tr>
				<tr>
					<td>직업</td>
					<td colspan="2">
						<select name="job">
							<option value="0" selected>선택하세요.
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
						<input type="button" value="회원가입" onclick="inputCheck()">&nbsp;&nbsp;
						<input type="reset" value="다시쓰기">&nbsp;&nbsp;
						<input type="button" value="로그인" onClick="javascript:location.href='../Login/Login.jsp'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>