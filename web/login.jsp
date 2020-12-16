<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/12/13
  Time: 22:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="zh">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!--icon    -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.png" type="image/x-icon"/>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
    <link rel="stylesheet" href="css/jigsaw.css">
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="http://www.huangwx.cn/css/sweetalert.css">

    <script type="text/javascript" src="http://www.huangwx.cn/js/sweetalert-dev.js"></script>
    <style>
        #msg {
            width: 100%;
            line-height: 40px;
            font-size: 14px;
            text-align: center;
        }
    </style>
    <script>
        function checkForm() {
            const username = document.getElementById("users").value;
            const pwd = document.getElementById("pwd").value;
            const pwdRepeat = document.getElementById("pwdRepeat").value;
            const email=document.getElementById("email").value;
            if (username === "") {
                swal("用户名不能为空哦");
                return false;
            }
            if(email===""){
                swal("邮箱不能为空哦");
                return false;
            }
            if (pwd === "") {
                swal("密码不能为空哦");
                return false;
            }
            if (pwd !== pwdRepeat) {
                swal("两次密码不一致哦");
                return false;
            }
            return confirm("确定提交了吗？");
        }
        function checkLogin() {
            const username = document.getElementById("emailLogin").value;
            const password = document.getElementById("password").value;
            if(username===""){
                swal("邮箱不能为空哦！");
                return false;
            }
            if(password===""){
                swal("密码不能为空哦！");
                return false;
            }
        }
    </script>

</head>
<body>

<div  style="padding-top:100px">
    <div class="login-wrap">
        <div class="login-html">
            <input id="tab-1" type="radio" name="tab" class="sign-in" checked><label for="tab-1"
                                                                                     class="tab">登录</label>
            <input id="tab-2" type="radio" name="tab" class="sign-up"><label for="tab-2" class="tab">注册</label>
            <div class="login-form">
                <form action="login" method="post" >
                    <div class="sign-in-htm">
                        <div class="group">
                            <label for="emailLogin" class="label">邮箱</label>
                            <input id="emailLogin" name="emailLogin" type="email" class="input">
                        </div>
                        <div class="group">
                            <label for="password" class="label">密码</label>
                            <input id="password" name="password" type="password" class="input" data-type="password">
                        </div>
                        <div class="group">
                            <input id="check" type="checkbox" class="check" checked>
                            <label for="check"><span class="icon"></span> 保持登录</label>
                        </div>
                        <div class="group">
                            <button type="submit" class="button" onclick="return checkLogin()">登录</button>
                        </div>
                        <div class="hr"></div>
                        <div class="foot-lnk">
                            <a href="#forgot" data-toggle="modal" data-target="#forget">忘记密码?</a>
                        </div>
                    </div>
                </form>
                <!-- 模态框 -->
                <div class="modal fade" id="forget">
                    <div class="modal-dialog">
                        <div class="modal-content">

                            <!-- 模态框头部 -->
                            <div class="modal-header">
                                <h4 class="modal-title">你的邮箱</h4>
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                            </div>

                            <!-- 模态框主体 -->
                            <div class="modal-body">
                                <form action="findPwd" method="post" >
                                    <div class="form-group">
                                        <label for="forgetPwd"></label>
                                        <input type="email" class="form-control" id="forgetPwd" name="forgetPwd" placeholder="Email" style="text-align: center">
                                    </div>
                                    <button type="submit" class="btn btn-outline-info">Submit</button>
                                </form>
                            </div>

                        </div>
                    </div>
                </div>
                <form action="register" method="post" onsubmit="return checkForm()">
                    <div class="sign-up-htm">
                        <div class="group">
                            <label for="users" class="label">用户名</label>
                            <input id="users" name="user" type="text" class="input">
                        </div>
                        <div class="group">
                            <label for="email" class="label">邮箱地址</label>
                            <input id="email" name="email" type="text" class="input">
                        </div>
                        <div class="group">
                            <label for="pwd" class="label">密码</label>
                            <input id="pwd" name="pwd" type="password" class="input" data-type="password" value="">
                        </div>
                        <div class="group">
                            <label for="pwdRepeat" class="label">重复密码</label>
                            <input id="pwdRepeat" name="pwdRepeat" type="password" class="input" data-type="password">
                        </div>
                        <div class="group">
                            <button id="register" type="submit" class="button">注册</button>
                        </div>
                        <div class="hr"></div>
                        <div class="foot-lnk">
                            <label for="tab-1">已经成员?</label>>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script src="js/jquery.min.js"></script>
<script src="js/popper.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<script src="js/jquery.easing.min.js"></script>
<script src="js/jquery.waypoints.min.js"></script>
<script src="js/owl.carousel.min.js"></script>
<script src="js/jquery.counterup.js"></script>
<script src="js/isotope.pkgd.min.js"></script>
<script src="js/jquery.magnific-popup.min.js"></script>
<script src="js/particles.js"></script>
<script src="js/typed.min.js"></script>
<script>
    function postTest(){

        const data = {
            "username": $("#users").val(),
            "email": $("#email").val(),
            "pwd": $("#pwd").val()
        };
        $.ajax({
            type: "post",
            url: "http://localhost:8080/Login_war_exploded/register",
            data: data,
            cache: false,
            async : true,
            //  dataType: "JSON",
            success: function (data ,textStatus, jqXHR)
            {

                changeData(data);
            },
            error:function (XMLHttpRequest, textStatus, errorThrown) {

            }
        });

    }
    $("#register").bind("click",function(){

        postTest();
    });
    function changeData(da){
        $("#username").val(da.username);
        $("#email").val(da.email);
        $("#pwd").val(da.pwd);
    }
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
    });
</script>


</body>
</html>

