<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <script type="text/javascript" src="script.js"></script>
    <script type="text/javascript">
        function idCheck(id) {
            if (id == "") {
                alert("ID를 입력해주세요.");
                frm.id.focus();
                return;
            }
            const url = "IdCheck.jsp?id=" + id;
            window.open(url, "ID_CHECK", "width=450, height=250");
        }
        function zipCheck() {
            const url = "ZipSearch.jsp?check=n";
            window.open(url, "ZIP_CODE_SEARCH", "width=450, height=600, scrollbars=yes");
        }
    </script>
    <style>
        body {
            background-color: #f9f9f9;
            color: #333;
            font-family: 'Arial', sans-serif;
            padding: 20px;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #0056b3;
        }
        table {
            width: 80%;
            margin: auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="date"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f1f1f1;
            color: #333;
        }
        input[type="button"],
        input[type="reset"] {
            background-color: #0056b3;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 10px;
        }
        input[type="button"]:hover,
        input[type="reset"]:hover {
            background-color: #004494;
        }
        label {
            margin-right: 10px;
        }
    </style>
</head>
<body onLoad="regFrm.id.focus()">
    <div align="center">
        <h2>NEWBIE COMEIN (SIGNIN)</h2>
        <form name="regFrm" method="post" action="MemberProc.jsp">
            <table>
                <tr>
                    <td>ID</td>
                    <td>
                        <input type="text" name="id" placeholder="ID를 입력하세요">
                    </td>
                    <td>
                        <input type="button" value="ID 유효성 검사" onClick="idCheck(this.form.id.value)">
                    </td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td>
                        <input type="password" name="pwd" placeholder="비밀번호를 입력하세요">
                    </td>
                    <td>
                        <input type="password" name="repwd" placeholder="비밀번호 확인">
                    </td>
                </tr>
                <tr>
                    <td>이름</td>
                    <td colspan="2">
                        <input type="text" name="name" placeholder="이름을 입력하세요">
                    </td>
                </tr>
                <tr>
                    <td>성별</td>
                    <td colspan="2">
                        남성<input type="radio" name="gender" value="1" checked>
                        여성<input type="radio" name="gender" value="2">
                    </td>
                </tr>
                <tr>
                    <td>생년월일</td>
                    <td colspan="2">
                        <input type="text" name="birthday" placeholder="ex) 950827">
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td colspan="2">
                        <input type="email" name="email" placeholder="ex) guest1014@newpage.com">
                    </td>
                </tr>
                <tr>
                    <td>우편번호</td>
                    <td>
                        <input type="text" name="zipcode" placeholder="우편번호 검색" readonly>
                    </td>
                    <td>
                        <input type="button" value="우편번호 검색" onClick="zipCheck()">
                    </td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td colspan="2">
                        <input type="text" name="address" placeholder="주소를 입력하세요">
                    </td>
                </tr>
                <tr>
                    <td>취미</td>
                    <td colspan="2">
                        <input type="checkbox" name="hobby" value="인터넷"><label>인터넷 서핑</label>
                        <input type="checkbox" name="hobby" value="여행"><label>여행</label>
                        <input type="checkbox" name="hobby" value="게임"><label>게임</label>
                        <input type="checkbox" name="hobby" value="영화"><label>영화 감상</label>
                        <input type="checkbox" name="hobby" value="운동"><label>운동</label>
                    </td>
                </tr>
                <tr>
                    <td>직업</td>
                    <td colspan="2">
                        <select name="job">
                            <option value="0" selected>직업 선택</option>
                            <option value="회사원">회사원</option>
                            <option value="연구전문직">연구/전문직</option>
                            <option value="교수,학생">교수/학생</option>
                            <option value="일반자영업">일반자영업</option>
                            <option value="공무원">공무원</option>
                            <option value="의료인">의료인</option>
                            <option value="법조인">법조인</option>
                            <option value="종교,언론,예술인">종교/언론/예술인</option>
                            <option value="농산,축산,수산,광업인">농/축/수산/광업인</option>
                            <option value="주부">주부</option>
                            <option value="무직">무직</option>
                            <option value="기타">기타</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td colspan="3" align="center">
                        <input type="button" value="가입하기" onclick="inputCheck()">
                        <input type="reset" value="초기화">
                        <input type="button" value="로그인" onClick="location.href='../Login/Login.jsp'">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
