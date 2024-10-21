<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome to Our Site</title>
    <style>
        body {
            background-color: #f9f9f9;
            color: #333;
            font-family: 'Arial', sans-serif;
            text-align: center;
            padding: 50px;
        }
        h1 {
            color: #66ff66;
        }
        .button {
            background-color: #007bff; /* 밝은 파란색 계열 */
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-size: 16px;
            margin: 10px;
            display: inline-block;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #0056b3; /* 어두운 파란색 */
        }
        .button-container {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <h1>Welcome to Our Chill Space</h1>
    <p>Explore our community and find your place!</p>

    <div class="button-container">
        <a class="button" href="Join/Member.jsp">회원 가입</a>
        <a class="button" href="Login/Login.jsp">로그인</a>
    </div>

    <p>
    <a class="button" href="Board/List.jsp">게시판 바로가기</a>
    </p>
    <p>
    <a class="button" href="Vote/poll-list.jsp">투표 게시판</a>
    </p>
</body>
</html>
