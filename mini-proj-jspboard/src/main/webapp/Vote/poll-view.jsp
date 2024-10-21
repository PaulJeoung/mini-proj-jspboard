<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vote.*" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="pMgr" class="vote.PollMgr"></jsp:useBean>
<%
    request.setCharacterEncoding("UTF-8");
    int num = 0;
    if (request.getParameter("num") != null) {
        num = Integer.parseInt(request.getParameter("num"));
    }
    int sum = pMgr.sumCount(num);
    Vector<PollItemBean> vlist = pMgr.getView(num);
    PollListBean plBean = pMgr.getList(num);
    String question = plBean.getQuestion();
    Random r = new Random();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷Vote]</title>
<style>
    body {
        background-color: #f0f0f0;
        color: #333;
        font-family: 'Arial', sans-serif;
        margin: 0;
        padding: 20px;
    }
    .container {
        max-width: 800px;
        margin: auto;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }
    h3 {
        color: #4CAF50;
        text-align: center;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }
    th, td {
        border: 1px solid #ccc;
        padding: 10px;
        text-align: center;
    }
    th {
        background-color: #4CAF50;
        color: white;
    }
    .bar {
        height: 30px;
        margin: 5px 0;
        text-align: right;
        padding-right: 10px;
        color: white;
        font-weight: bold;
        border-radius: 5px;
    }
    .close-button {
        display: block;
        margin: 20px auto;
        color: #fff;
        text-decoration: none;
        padding: 10px 20px;
        background-color: #4CAF50;
        border-radius: 5px;
        text-align: center;
        transition: background-color 0.3s;
    }
    .close-button:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
    <div class="container">
        <h3><%= question %></h3>
        <table>
            <tr>
                <th>항목</th>
                <th>투표 수</th>
                <th>비율</th>
            </tr>
            <%
                for (int i = 0; i < vlist.size(); i++) {
                    PollItemBean piBean = vlist.get(i);
                    String[] item = piBean.getItem();
                    int count = piBean.getCount();
                    int ratio = (int) Math.ceil((double) count / sum * 100);
                    String barColor = String.format("#%06X", r.nextInt(0xFFFFFF));
            %>
            <tr>
                <td><%= item[0] %></td>
                <td><%= count %></td>
                <td>
                    <div class="bar" style="width: <%= ratio %>%; background-color: <%= barColor %>;">
                        <%= ratio %>%
                    </div>
                </td>
            </tr>
            <% } %>
        </table>
        <a class="close-button" href="javascript:window.close()">닫기</a>
    </div>
</body>
</html>
