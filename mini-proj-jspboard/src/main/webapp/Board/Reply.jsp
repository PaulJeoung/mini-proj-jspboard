<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bean" class="board.BoardBean" scope="session"></jsp:useBean>
<%
    String nowPage = request.getParameter("nowPage");
    String subject = bean.getSubject();
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
        width: 80%;
        margin: auto;
        border-collapse: collapse;
    }
    .header {
        background-color: gray;
        height: 25px;
        text-align: center;
        color: white;
    }
    input[type="text"], input[type="password"], textarea {
        width: 100%;
        padding: 8px;
        margin: 4px 0;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    input[type="submit"], input[type="reset"], input[type="button"] {
        background-color: #4CAF50;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
    input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover {
        background-color: #45a049;
    }
    textarea {
        height: 150px;
    }
</style>
</head>
<body>
<div>
    <hr>
    <h2>[Shake_it Funk Board]</h2>
    <table>
        <tr>
            <td class="header">답변하기</td>
        </tr>
    </table>
    <form method="post" action="boardReply">
        <table>
            <tr>
                <td align="center">
                    <table>
                        <tr>
                            <td width="20%" align="center">이름</td>
                            <td width="80%"><input name="name" type="text" maxlength="20" placeholder="이름을 입력하세요"/></td>
                        </tr>
                        <tr>
                            <td align="center">제목</td>
                            <td><input name="subject" type="text" maxlength="50" value="답변 : <%=subject %>"/></td>
                        </tr>
                        <tr>
                            <td align="center">내용</td>
                            <td>
                                <textarea name="content">
<%=content %>
============= 댓글 달아주세요 =============
                                </textarea>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">비밀번호</td>
                            <td><input type="password" name="pass" maxlength="20" placeholder="비밀번호를 입력하세요"/></td>
                        </tr>
                        <tr>
                            <td colspan="2" align="center">
                                <input type="submit" value="답변등록"/>
                                <input type="reset" value="다시쓰기"/>
                                <input type="button" value="뒤로" onclick="history.back()"/>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <input type="hidden" name="ip" value="<%= request.getRemoteAddr() %>">
        <input type="hidden" name="nowPage" value="<%= nowPage %>">
        <input type="hidden" name="ref" value="<%= bean.getRef() %>">
        <input type="hidden" name="pos" value="<%= bean.getPos() %>">
        <input type="hidden" name="depth" value="<%= bean.getDepth() %>">
    </form>
</div>
<hr/>
</body>
</html>
