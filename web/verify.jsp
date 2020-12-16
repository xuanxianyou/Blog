<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/12/14
  Time: 20:52
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>verifyCode</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.png" type="image/x-icon"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        body {
            margin: 0;
            color: mediumslateblue;
            background: url(./img/timg.jpg) no-repeat fixed 0 0;
            background-size: cover;
            -webkit-background-size: cover;
            -o-background-size: cover;
            -moz-background-size: cover;
            -ms-background-size: cover;
            font: 600 16px/18px 'Open Sans', sans-serif;
        }
    </style>
    <script>
        function checkForm() {
            const verifyCode = document.getElementById("verifyCode").value;
            if (verifyCode === "") {
                alert("验证码不能为空哦");
                return false;
            }
        }
    </script>
</head>

<body>
<div class="col-sm-3"
     style="margin-top: 200px;margin-left: auto;margin-right: auto;background:rgba(30%, 30%, 30%, 0.5);border-radius: 10px;text-align: center;padding-bottom: 100px;">
    <div class="img">
        <img src="./img/icon.png" alt="">
    </div>
    <div class="title" style="margin-bottom:20px;font-size: 25px;">
        <span>Kaneziki</span>
    </div>
    <form action="verify" method="post" class="form-inline" onsubmit="return checkForm()">
        <label class="sr-only" for="verifyCode">Name</label>
        <input id="verifyCode" name="verifyCode" type="text" class="form-control mb-2 offset-sm-1" placeholder="6-bits-验证码"
               style="margin: 0 auto;">
        <button type="submit" class="btn btn-info mb-2" style="margin: 0 auto;">验证</button>
    </form>
    <div>
        <a class="btn btn-block" href="verify" style="color: seagreen;font-weight: bold;">没有收到？</a>
    </div>
</div>
</body>

</html>
