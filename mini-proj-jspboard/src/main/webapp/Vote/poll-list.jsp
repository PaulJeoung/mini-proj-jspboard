<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vote.*" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="pMgr" class="vote.PollMgr"></jsp:useBean>
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
    h3 {
        color: #4CAF50;
    }
    a {
        color: #4CAF50;
        text-decoration: none;
    }
    a:hover {
        text-decoration: underline;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
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
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    .container {
        max-width: 800px;
        margin: auto;
        background: white;
        border-radius: 8px;
        padding: 20px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
</style>
</head>
<body>
    <div class="container">
    <p>
		<a href="../Board/List.jsp" style="color: #007b00; text-decoration: none; padding: 10px 15px; border: 0px dotted #ff7bff; border-radius: 5px; transition: background-color 0.3s;">투표 게시판으로 이동</a>
		</p>
        <h3 align="center">VOTE 2024</h3>
        <hr/>

        <div style="text-align: right;">
            <a href="poll-insert.jsp">투표 만들기</a>
        </div>

        <h4>최근 투표 리스트</h4>
        <table>
            <tr>
                <th>NO</th>
                <th>제목</th>
                <th>시작일-종료일</th>
            </tr>
            <%
                Vector<PollListBean> vlist = pMgr.getAllList();
                int count = vlist.size();
                for (int i = 0; i < vlist.size(); i++) {
                    PollListBean plBean = vlist.get(i);
                    int num = plBean.getNum();
                    String question = plBean.getQuestion();
                    String sdate = plBean.getSdate();
                    String edate = plBean.getEdate();
                    
                    out.println("<tr><td>" + count + "</td>");
                    out.println("<td><a href='poll-list.jsp?num=" + num + "'>" + question + "</a></td>");
                    out.println("<td>" + sdate + " ~ " + edate + "</td></tr>");
                    
                    count = count - 1;
                }
            %>
        </table>

        <hr/>
        <p><b>선택된 투표 내용</b></p>
        <jsp:include page="poll-form.jsp"></jsp:include>
    </div>
</body>
</html>
