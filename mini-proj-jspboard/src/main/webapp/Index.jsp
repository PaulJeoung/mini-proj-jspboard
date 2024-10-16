<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[쉐킷펑크]</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: "black";
            margin: 0;
            padding: 0;
        }
        .hero {
            background-image: url('https://source.unsplash.com/1600x900/?nature,water');
            background-size: cover;
            color: gray;
            text-align: center;
            padding: 100px 20px;
        }
        .button-container {
            margin-top: 30px;
        }
        .btn-custom {
            background-color: #007bff;
            color: white;
            padding: 15px 30px;
            font-size: 18px;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
        }
        .btn-custom:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

    <div class="hero">
        <h1>WELCOME!</h1>
        <p>[쉐킷펑크]에 오신것을 환영합니다. 지금 시작해보세요!</p>
        <div class="button-container">
            <a href="Join/Member.jsp" class="btn btn-custom">회원 가입</a>
            <a href="Login/Login.jsp" class="btn btn-custom" style="margin-left: 20px;">로그인</a>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
