<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="vote.*" %>
<%@ page import="java.util.Vector" %>
<jsp:useBean id="pMgr" class="vote.PollMgr"></jsp:useBean>
<%
    int num = 0;
    if (!(request.getParameter("num") == null || request.getParameter("num").equals(""))) {
        num = Integer.parseInt(request.getParameter("num"));
    }
    
    PollListBean plBean = pMgr.getList(num);
    Vector<String> vlist = pMgr.getItem(num);
    
    String question = plBean.getQuestion();
    int type = plBean.getType();
    int active = plBean.getActive();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[쉐킷Vote]</title>
<style>
    body {
        background-color: #f4f4f4;
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
        max-width: 600px;
        margin: auto;
        background: white;
        border-radius: 8px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        padding: 20px;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 20px 0;
    }
    th, td {
        padding: 10px;
        text-align: left;
    }
    th {
        background-color: #4CAF50;
        color: white;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    input[type="submit"], input[type="button"] {
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 15px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    input[type="submit"]:hover, input[type="button"]:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
    <div class="container">
        <h2>투표하기</h2>
        <form method="post" action="poll-form-proc.jsp">
            <table>
                <tr>
                    <td colspan="2">질문: <strong><%= question %></strong></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <%
                            for (int i = 0; i < vlist.size(); i++) {
                                String itemList = vlist.get(i);
                                if (type == 1) {
                                    out.println("<input type='checkbox' name='itemnum' value='" + i + "'>" + itemList + "<br/>");
                                } else {
                                    out.println("<input type='radio' name='itemnum' value='" + i + "'>" + itemList + "<br/>");
                                }
                            }
                        %>
                    </td>
                </tr>
                <tr>
                    <td>
                        <%
                            if (active == 1) {
                                out.println("<input type='submit' value='투표'>");
                            } else {
                                out.println("투표 불가능");
                            }
                        %>
                    </td>
                    <td>
                        <input type="button" value="결과" onclick="javascript:window.open('poll-view.jsp?num=<%= num %>', 'PollView', 'width=750,height=600')">
                    </td>
                </tr>
            </table>
            <input type="hidden" name="num" value="<%= num %>">
        </form>
    </div>
</body>
</html>
