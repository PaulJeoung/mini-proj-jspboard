<%@page import="board.BoardBean"%>
<%@page import="board.BoardMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean>
<%
    request.setCharacterEncoding("UTF-8");
    String nowPage = request.getParameter("nowPage");
    int num = Integer.parseInt(request.getParameter("num"));
    if (request.getParameter("pass") != null) {
        String inPass = request.getParameter("pass");
        BoardBean bean = (BoardBean) session.getAttribute("bean");
        String dbPass = bean.getPass();
        
        if (inPass.equals(dbPass)) {
            bMgr.deleteBoard(num);
            String url = "List.jsp?nowPage=" + nowPage;
            response.sendRedirect(url);
        } else {
%>
            <script type="text/javascript">
                alert("잘못된 비밀번호입니다.");
                history.back();
            </script>
<%      }
    } else { %>
        <script type="text/javascript">
            function check() {
                if (document.delFrm.pass.value == "") {
                    alert("패스워드를 입력하세요.");
                    document.delFrm.pass.focus();
                    return false;
                }
                document.delFrm.submit();
            }
        </script>
<% } %>
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
        background-color: white;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        border-collapse: collapse;
    }
    .header {
        background-color: #666;
        color: white;
        height: 30px;
        text-align: center;
        vertical-align: middle;
    }
    input[type="password"] {
        width: 100%;
        padding: 10px;
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
</style>
</head>
<body>
<div align="center">
    <hr>
    <h2>[Shake_it Funk Board]</h2>
    <br/>
    <table cellpadding="3">
        <tr>
            <td class="header">삭제를 위해서 비밀번호를 입력해 주세요</td>
        </tr>
    </table>
    <form name="delFrm" method="post" action="Delete.jsp">
        <table cellpadding="2">
            <tr>
                <td align="center">
                    <input type="password" name="pass" placeholder="비밀번호 입력">
                </td>
            </tr>
            <tr>
                <td align="center">
                    <input type="button" value="삭제완료" onclick="check()">
                    <input type="reset" value="다시쓰기">
                    <input type="button" value="뒤로" onclick="history.go(-1)">
                </td>
            </tr>
        </table>
        <input type="hidden" name="nowPage" value="<%=nowPage %>">
        <input type="hidden" name="num" value="<%=num %>">
    </form>
</div>
<hr/>
</body>
</html>
