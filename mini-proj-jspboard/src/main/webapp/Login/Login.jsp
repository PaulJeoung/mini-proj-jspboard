<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
    String id = (String) session.getAttribute("idKey");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <style>
        body {
            background-color: #f9f9f9;
            color: #333;
            font-family: 'Arial', sans-serif;
            padding: 20px;
            text-align: center;
        }
        h2 {
            color: #66ff66;
        }
        input[type="text"], input[type="password"] {
            padding: 10px;
            margin: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            width: 200px;
        }
        input[type="button"] {
            background-color: #007bff; /* 파란색 계통 */
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
        }
        input[type="button"]:hover {
            background-color: #0056b3; /* 어두운 파란색 */
        }
        a {
            color: #0056b3; /* 링크 색상 */
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
    <script type="text/javascript">
        function loginCheck() {
            if (document.loginFrm.id.value == "") {
                alert("아이디를 입력해 주세요");
                document.loginFrm.id.focus();
                return;
            }
            if (document.loginFrm.pwd.value == "") {
                alert("비밀번호를 입력해 주세요");
                document.loginFrm.pwd.focus();
                return;
            }
            document.loginFrm.submit();
        }

        function redirectToList() {
            setTimeout(function() {
                window.location.href = '../Board/List.jsp';			
            }, 3000);
        }
    </script>
</head>
<body>
    <hr/><br/>
    <div align="center">
        <% if (id != null) { %>
            <h2><%= id %> 님 환영합니다</h2><br/><br/>
            <p>
                <b>잠시 후 SHAKE_IT FUNK BOARD로 이동합니다.</b><br/>
                <b>원하지 않으시면 3초 안에 아래 로그아웃을 누르세요.</b><br/><br/>
                아래 눌러서 도망가기<br/>
                🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽🔽<br/><br/>
            </p>
            <a href="Logout.jsp">로그아웃</a>
            
            <script type="text/javascript">
                redirectToList();
            </script>
        <% } else { %>
            <form name="loginFrm" method="post" action="LoginProc.jsp">
                <table>
                    <tr><td><br/></td></tr>
                    <tr>
                        <td>ID</td>
                        <td><input type="text" name="id" placeholder="아이디 입력"/></td>
                    </tr>
                    <tr>
                        <td>PASSWORD</td>
                        <td><input type="password" name="pwd" placeholder="비밀번호 입력"/></td>
                    </tr>
                    <tr><td><br/></td></tr>
                    <tr>
                        <td colspan="2" align="center">
                            <input type="button" value="로그인" onclick="loginCheck()"/>&nbsp;
                            <input type="button" value="회원가입" onclick="javascript:location.href='../Join/Member.jsp'"/>
                        </td>
                    </tr>
                </table>
            </form>
        <% } %>
    </div>
</body>
</html>
