<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String nowPage = request.getParameter("nowPage");
    BoardBean bean = (BoardBean)session.getAttribute("bean");
    String subject = bean.getSubject();
    String name = bean.getName();
    String content = bean.getContent();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷펑크]</title>
<style>
    body {
        background-color: #f5f5f5;
        color: #333;
        font-family: 'Arial', sans-serif;
        padding: 20px;
    }
    h2 {
        color: #4CAF50;
        text-align: center;
    }
    table {
        width: 70%;
        margin: auto;
        border-collapse: collapse;
        background-color: white;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }
    .header {
        background-color: #333;
        color: white;
        height: 30px;
        text-align: center;
        vertical-align: middle;
    }
    input[type="text"], input[type="password"], textarea {
        width: 100%;
        padding: 8px;
        margin: 4px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    input[type="button"], input[type="reset"] {
        background-color: #4CAF50;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    input[type="button"]:hover, input[type="reset"]:hover {
        background-color: #45a049;
    }
    textarea {
        height: 150px;
    }
</style>
<script>
    function check() {
        if (document.updateFrm.pass.value == "") {
            alert("수정을 위해 패스워드를 입력하세요");
            document.updateFrm.pass.focus();
            return false;
        }
        document.updateFrm.submit();
    }
</script>
</head>
<body>
<div align="center">
    <hr>
    <h2>[Shake_it Funk Board]</h2>
    <table cellspacing="0" cellpadding="3">
        <tr>
            <td class="header">수정하기</td>
        </tr>
    </table>
    <form name="updateFrm" method="post" action="boardUpdate">
        <table cellspacing="0" cellpadding="7">
            <tr>
                <td align="center">
                    <table>
                        <tr>
                            <td width="20%">성명</td>
                            <td width="80%"><input name="name" value="<%=name %>" type="text" maxlength="20"/></td>
                        </tr>
                        <tr>
                            <td>제목</td>
                            <td><input name="subject" value="<%=subject %>" type="text" maxlength="50"/></td>
                        </tr>
                        <tr>
                            <td>내용</td>
                            <td><textarea name="content"><%=content %></textarea></td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td><input type="password" name="pass" maxlength="15" placeholder="수정을 위해 비밀번호를 넣어 주세요"/></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input type="button" value="수정완료" onclick="check()" />
                                <input type="reset" value="다시수정" />
                                <input type="button" value="뒤로" onclick="history.go(-1)" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <input type="hidden" name="nowPage" value="<%=nowPage%>" />
        <input type="hidden" name="num" value="<%=num%>" />
    </form>
</div>
</body>
</html>
