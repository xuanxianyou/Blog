<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/12/16
  Time: 20:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=GB2312" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kaneziki ����ϵͳ��������</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.png" type="image/x-icon"/>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        body{
            padding: 50px 100px;
        }
    </style>
</head>
<body>
<%!String username="";%>
<%
    username=session.getAttribute("username").toString();
%>
<div class="container" style="margin: 50px;">
    <table align="center" border="0" cellspacing="0" cellpadding="0" width="100%" bgcolor="#EDF0F3" style="height: 100px; table-layout: fixed; font-family: PingFangSC-Light,serif;">
        <tbody>
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" style="max-width: 600px; margin: 0 auto;">
                    <tr>
                        <td align="center">
                            <h1 style="font-size: 25px; color: #3c4858;font-weight: bolder; letter-spacing: 0; margin: 6px auto; padding-left: 5px;">
                                Kaneziki
                            </h1>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <table border="0" width="100%" cellspacing="0" cellpadding="0" style="box-shadow: 0 1px 2px 0 rgba(0,0,0,0.20);
                                       color: #273444;
                                       background: #FFF;
                                       border-radius: 4px;
                                       margin-top: 18px;">
                                <tr>
                                    <td colspan="4" style="border-top-left-radius: 4px;border-top-right-radius: 4px;">
                                        <table border="0" width="100%" cellspacing="15" cellpadding="15">
                                            <tr>
                                                <td style="border-top-left-radius: 4px;border-top-right-radius: 4px;">
                                                    <table  width="100%" cellspacing="20" cellpadding="0" style="width: 100%; background: #FFF;border-top-left-radius: 4px;border-top-right-radius: 4px; padding: 20px;">

                                                        <tr>
                                                            <td>
                                                                <div class="row" style="margin: 10px 0;font-size: 16px;font-weight: bolder;">
                                                                    �𾴵�<spqn id="username" style="white-space: nowrap;"><%=username%></spqn>��
                                                                </div>
                                                            </td>
                                                        </tr>


                                                        <tr>
                                                            <td width="100%">
                                                                <div style="margin: 10px 0;font-size: 14px; line-height: 1.6;">
                                                                    <div>
                                                                        �����±���������д�������룬�´β�Ҫ����Ŷ��
                                                                    </div>

                                                                </div>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td>
                                                                <span style="margin:10px 0;border-bottom:1px solid #E0E6ED;width: 150px;height: 0;display: inline-block;"></span>
                                                            </td>
                                                        </tr>


                                                        <tr>
                                                            <td align="center">
                                                                <form action="resetPwd" method="post">
                                                                    <div class="form-group">
                                                                        <label for="YourEmail"></label>
                                                                        <input type="email" class="form-control" id="YourEmail" name="YourEmail" aria-describedby="emailHelp" placeholder="Your Email" style="text-align: center;">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="Password"></label>
                                                                        <input type="password" class="form-control" id="Password" name="Password" placeholder="Your Password" style="text-align: center;">
                                                                    </div>
                                                                    <div class="form-group">
                                                                        <label for="confirmPassword"></label>
                                                                        <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" style="text-align: center;">
                                                                    </div>
                                                                    <button type="submit" class="btn btn-info" style="float: right;">Submit</button>
                                                                </form>
                                                            </td>
                                                        </tr>

                                                    </table>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <table width="100%" style="background: #F9FAFC;padding: 16px  40px;">
                                                        <tbody>

                                                        <tr style="vertical-align: middle;">
                                                            <td align="center">
                                                                <div style="vertical-align: middle;">
                                                                    <p style="font-size: 14px; color: #3C4858;; margin:0 0 5px 0;">
                                                                        ��л����Kaneziki�Ĺ�ע��֧��</p>
                                                                    <p style="margin: 0; font-size: 12px; color: #8796A8;">
                                                                        �������ʿ���ϵ���ǣ�17331987381 | <a href="#" style="color: #4289DB; text-decoration: none;">1848224883@qq.com</a>
                                                                    </p>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        </tbody>
                                                    </table>
                                                </td>
                                            </tr>

                                        </table>
                                    </td>
                                </tr>


                                <tr>
                                    <td width="25%;" style="background: #3C4858;font-size: 12.6px;color: #CAD3DE;text-align: center;border-bottom-left-radius: 4px;">
                                            <span style="padding: 15px 0px;display: inline-block;">
                                                <a href="#">��������</a>
                                            </span>
                                    </td>
                                    <td width="25%;" style="background: #3C4858;font-size: 12.6px;color: #CAD3DE;text-align: center;">
                                            <span style="padding: 15px 0px;display: inline-block;">
                                                <a href="#">�����Ŀ</a>
                                            </span>
                                    </td>
                                    <td width="25%;" style="background: #3C4858;font-size: 12.6px;color: #CAD3DE;text-align: center;">
                                            <span style="padding: 15px 0px;display: inline-block;">
                                                <a href="#">��������</a>
                                            </span>
                                    </td>
                                    <td width="25%;" style="background: #3C4858;font-size: 12.6px;color: #CAD3DE;text-align: center;border-bottom-right-radius: 4px;">
                                            <span style="padding: 15px 0px;display: inline-block;">
                                                <a href="#">��������</a>
                                            </span>
                                    </td>
                                </tr>


                            </table>
                        </td>
                    </tr>
                    <tr style="font-size: 9px; color: #3C4858;">
                        <td style="text-align: center; padding-top: 5px;">
                            <span>Copyright  : Kaneziki 1848224883@qq.com</span>
                        </td>
                    </tr>

                </table>
            </td>
        </tr>

        </tbody>
    </table>
</div>

</body>
</html>