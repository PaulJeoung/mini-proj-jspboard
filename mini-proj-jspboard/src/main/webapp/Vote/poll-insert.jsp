<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
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
    input[type="text"], select {
        width: calc(100% - 20px);
        padding: 10px;
        margin: 5px 0;
        border: 1px solid #ccc;
        border-radius: 5px;
    }
    input[type="submit"], input[type="reset"], input[type="button"] {
        background-color: #4CAF50;
        color: white;
        padding: 10px 15px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        margin: 5px;
        transition: background-color 0.3s;
    }
    input[type="submit"]:hover, input[type="reset"]:hover, input[type="button"]:hover {
        background-color: #45a049;
    }
    table {
        width: 100%;
        margin: 20px 0;
        border-collapse: collapse;
    }
    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #ccc;
    }
    th {
        background-color: #4CAF50;
        color: white;
    }
</style>
<script type="text/javascript" src="script.js"></script>
</head>
<body>
    <div class="container">
        <hr/>
        <h3>VOTE 2024</h3>
        <hr/>
        <b>설문작성양식</b><br/>
        <form name="voteFrm" method="post" action="poll-insert-proc.jsp" accept-charset="UTF-8">
            <table>
                <tr>
                    <td><b>질문</b></td>
                    <td>
                        <input type="text" name="question" placeholder="질문할 주제를 작성하세요" required>
                    </td>
                </tr>
                <tr>
                    <td rowspan="4" valign="top"><b>보기</b></td>
                    <td>
                        <input type="text" name="item" placeholder="보기" required>
                    </td>
                </tr>
                <%
                    for (int i=2; i<=4; i++) {
                        out.println("<tr><td><input type='text' name='item' placeholder='보기 " + i + "'></td></tr>");
                    }
                %>
                <tr>
                    <td><b>시작일</b></td>
                    <td>
                        <select name="sdateY">
                            <%
                                for (int i=2024; i<2026; i++) {
                                    out.println("<option value='" + i + "'>" + i + "</option>");
                                }
                            %>
                        </select>년
                        <select name="sdateM">
                            <%
                                for (int i=1; i<13; i++) {
                                    out.println("<option value='" + i + "'>" + i + "</option>");
                                }
                            %>
                        </select>월 
                        <select name="sdateD">
                            <%
                                for (int i=1; i<32; i++) {
                                    out.println("<option value='" + i + "'>" + i + "</option>");
                                }
                            %>
                        </select>일
                    </td>
                </tr>
                <tr>
                    <td><b>종료일</b></td>
                    <td>
                        <select name="edateY">
                            <%
                                for (int i=2024; i<2026; i++) {
                                    out.println("<option value='" + i + "'>" + i + "</option>");
                                }
                            %>
                        </select>년
                        <select name="edateM">
                            <%
                                for (int i=1; i<13; i++) {
                                    out.println("<option value='" + i + "'>" + i + "</option>");
                                }
                            %>
                        </select>월 
                        <select name="edateD">
                            <%
                                for (int i=1; i<32; i++) {
                                    out.println("<option value='" + i + "'>" + i + "</option>");
                                }
                            %>
                        </select>일
                    </td>
                </tr>
                <tr>
                    <td><b>복수 투표</b></td>
                    <td>
                        <input type="radio" name="type" value="1" checked="checked">허용
                        <input type="radio" name="type" value="0">비허용
                    </td>
                </tr>
                <tr>
                    <td colspan="2" align="center">
                    	<!-- input type="submit" value="작성하기" -->
                        <input type="button" value="작성하기" onclick="voteInfo()">
                        <input type="reset" value="다시쓰기">
                        <input type="button" value="리스트" onclick="javascript:location.href='poll-list.jsp'">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
