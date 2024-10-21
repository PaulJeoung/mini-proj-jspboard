<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<jsp:useBean id="mMgr" class="member.MemberMgr"></jsp:useBean>
<html>
<head>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	boolean result = mMgr.checkId(id);
%>

    <meta charset="UTF-8">
    <title>ID 유효성 검사</title>
    <style>
        body {
            background-color: #f9f9f9;
            color: #333;
            font-family: 'Arial', sans-serif;
            padding: 20px;
            text-align: center;
        }
        a {
            color: #0056b3;
            text-decoration: none;
            margin-top: 20px;
            display: inline-block;
        }
        a:hover {
            text-decoration: underline;
        }
        b {
            font-size: 24px;
            color: #66ff66;
        }
    </style>
</head>
<body>
    <div>
        <b><%= id %></b>
        <%
            if (result) {
                out.println(" 는 이미 존재하는 ID입니다.<p/>");
            } else {
                out.println(" 는 사용 가능한 ID입니다.<p/>");
            }
        %>
        <a href="#" onClick="self.close()">닫기</a>
    </div>
</body>
</html>
