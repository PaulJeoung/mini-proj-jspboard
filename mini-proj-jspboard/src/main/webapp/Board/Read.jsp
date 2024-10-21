<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="board.BoardBean" %>
<jsp:useBean id="bMgr" class="board.BoardMgr"></jsp:useBean>
<%
    request.setCharacterEncoding("UTF-8");
    int num = Integer.parseInt(request.getParameter("num"));
    String nowPage = request.getParameter("nowPage");
    String keyField = request.getParameter("keyField");
    String keyWord = request.getParameter("keyWord");
    bMgr.upCount(num);
    BoardBean bean = bMgr.getBoard(num);
    String name = bean.getName();
    String subject = bean.getSubject();
    String regdate = bean.getRegdate();
    String content = bean.getContent();
    String filename = bean.getFilename();
    String ip = bean.getIp();
    int filesize = bean.getFilesize();
    int count = bean.getCount();
    session.setAttribute("bean", bean);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷펑크]</title>
<script type="text/javascript">
    function list() {
        document.listFrm.submit();
    }
    function down(filename) {
        document.downFrm.filename.value = filename;
        document.downFrm.submit();
    }
</script>
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
    }
    .borderedLine {
        border: 1px solid #00aa00;
    }
    td {
        padding: 10px;
    }
    a {
        color: #00aa00;
        text-decoration: none;
    }
    a:hover {
        text-decoration: underline;
    }
</style>
</head>
<body>
<hr>
<h2>[Shake_it Funk Board]</h2>
<table class="borderedLine">
    <tr>
        <td bgcolor="gray" height="25" align="center"><h4><%=subject %></h4></td>
    </tr>
    <tr>
        <td>
            <table width="100%">
                <tr>
                    <td align="center" width="15%">작성자</td>
                    <td><%=name %></td>
                    <td align="center" width="15%">등록날짜</td>
                    <td><%=regdate %></td>
                </tr>
                <tr>
                    <td align="center">제목</td>
                    <td colspan="3"><%=subject %></td>
                </tr>
                <tr>
                    <td align="center">첨부파일</td>
                    <td colspan="3">
                    <%
                        if (filename != null && !filename.equals("")) {
                    %>
                        <a href="javascript:down('<%=filename %>')"><%=filename %></a>
                        &nbsp; <font color="blue">(<%=filesize %> KB)</font>
                    <%
                        } else {
                    %>
                        등록된 파일이 없습니다.
                    <%
                        }
                    %>
                    </td>
                </tr>
                <tr>
                    <td colspan="4"><br/><pre><%=content %></pre></td>
                </tr>
                <tr>
                    <td colspan="4" align="right">
                        <%=ip %>로 부터 글을 남겼습니다. / 조회수 <%=count %>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td align="center">
            [ <a href="javascript:list()">리스트</a> | 
            <a href="Update.jsp?nowPage=<%=nowPage %>&num=<%=num %>">수정</a> | 
            <a href="Reply.jsp?nowPage=<%=nowPage %>">답변</a> |  
            <a href="Delete.jsp?nowPage=<%=nowPage %>&num=<%=num %>">삭제</a> ]
        </td>
    </tr>
</table>
<form action="Download.jsp" name="downFrm" method="post">
    <input type="hidden" name="filename">
</form>
<form name="listFrm" method="post" action="List.jsp">
    <input type="hidden" name="nowPage" value="<%=nowPage%>">
    <%
        if (!(keyWord == null || keyWord.equals(""))) {
    %>
        <input type="hidden" name="keyField" value="<%=keyField%>">
        <input type="hidden" name="keyWord" value="<%=keyWord%>">
    <%
        }
    %>
</form>
<hr/>
</body>
</html>
