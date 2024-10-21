<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷펑크]</title>
<style>
    body {
        background-color: #f0f0f0;
        color: #333;
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 20px;
    }
    h2 {
        color: #4CAF50;
        text-align: center;
    }
    .container {
        width: 600px;
        margin: auto;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }
    table {
        width: 100%;
        margin-bottom: 20px;
    }
    td {
        padding: 10px;
    }
    input[type="text"], input[type="password"], textarea, input[type="file"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-top: 5px;
    }
    input[type="submit"], input[type="reset"], input[type="button"] {
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        transition: background-color 0.3s;
        margin: 5px 0;
    }
    input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover {
        background-color: #45a049;
    }
    .radio-group {
        display: inline-block;
        margin-right: 20px;
    }
</style>
</head>
<body>
    <div class="container">
        <h2>[Shake_it Funk Board]</h2>
        <table>
            <tr>
                <td bgcolor="gray" height="25" align="center">글쓰기</td>
            </tr>
        </table>
        <form name="postFrm" method="post" enctype="multipart/form-data" action="boardPost">
            <table>
                <tr>
                    <td>작성자</td>
                    <td><input name="name" maxlength="8" placeholder="이름을 적어주세요"></td>
                </tr>
                <tr>
                    <td>제목</td>
                    <td><input name="subject" maxlength="30" placeholder="제목을 작성해 주세요"></td>
                </tr>
                <tr>
                    <td>내용</td>
                    <td><textarea name="content" rows="10" placeholder="내용을 입력해 주세요"></textarea></td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass" maxlength="15" placeholder="비밀번호를 입력하세요"></td>
                </tr>
                <tr>
                    <td>파일찾기</td>
                    <td><input type="file" name="filename"></td>
                </tr>
                <tr>
                    <td>내용타입</td>
                    <td>
                        <div class="radio-group">
                            HTML<input type="radio" name="contentType" value="HTTP">
                        </div>
                        <div class="radio-group">
                            TEXT<input type="radio" name="contentType" value="TEXT" checked="checked">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                        <input type="submit" value="등록">
                        <input type="reset" value="다시쓰기">
                        <input type="button" value="리스트" onclick="javascript:location.href='List.jsp'">
                    </td>
                </tr>
            </table>
            <input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
        </form>
    </div>
</body>
</html>
