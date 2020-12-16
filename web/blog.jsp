<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.nio.charset.StandardCharsets" %><%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/12/15
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <meta name="description" content="Personal Portfolio Html5 One Page Template">
    <meta name="keywords" content="agency, bootstrap, business, corporate, creative, landing page, marketing, multipurpose, product, product launch, responsive, software, startup, startup landing page">
    <meta name="author" content="ParExcellence">
    <!-- Site Title -->
    <title><%=username%>User Index</title>
    <!--    icon-->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/img/icon.png" type="image/x-icon"/>

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <!-- Material Icon -->
    <link rel="stylesheet" href="css/materialdesignicons.min.css">
    <!-- Magnific Popup -->
    <link rel="stylesheet" href="css/magnific-popup.css" />
    <!-- Carousel Slider -->
    <link rel="stylesheet" href="css/owl.carousel.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600&display=swap" rel="stylesheet">
    <!-- Custom  CSS -->
    <link rel="stylesheet" href="css/style.css">
</head>
<style>
    .list-group-horizontal>li {
        display: inline-block;
        margin-right:180px;
        margin-bottom: 0;
    }
    .list-group-horizontal>li>label{
        float: left;
    }

</style>

<body>
<jsp:useBean id="user" class="utils.User" scope="session" />
<%!String username="";%>
<%
    //查询数据库
    try{
        HttpSession session1=request.getSession();
        String email=session1.getAttribute("EMAIL").toString();
        out.print(email);
        //连接数据库
        Class.forName("com.mysql.cj.jdbc.Driver");
        String URL = "jdbc:mysql://127.0.0.1:3306/Login?characterEncoding=utf-8";
        String USER = "root";
        String PASSWORD = "123456";
        Connection conn= DriverManager.getConnection(URL, USER, PASSWORD);
        out.println("Database Connecting...");
        //查询语句
        String findUserTable=" SELECT id,username,email,work,phone,address,registerTime FROM USER WHERE email=?;";
        PreparedStatement statement=conn.prepareStatement(findUserTable);
        statement.setString(1,email);
        ResultSet result=statement.executeQuery();
        while(result.next()){
            String id = result.getString(1);
            byte[] username=result.getBytes(2);
            email=result.getString(3);
            String work=new String(result.getBytes(4),"gb2312");;
            String phone=result.getString(5);
            String address=new String(result.getBytes(6));
            String registerTime=result.getString(7);
            user.setId(id);
            user.setUsername(new String(username));
            user.setEmail(email);
            user.setWork(work);
            user.setPhone(phone);
            user.setAddress(address);
            user.setRegisterTime(registerTime);

        }
        //查询hobbies

        conn.close();
    }catch (Exception e ){
        e.printStackTrace();
    }
%>
<!-- Start Preloader -->
<div class="spinner-wrapper">
    <div class="spinner">
        <div class="bounce1"></div>
        <div class="bounce2"></div>
        <div class="bounce3"></div>
    </div>
</div>
<!-- End preloader -->

<div id="main-wrapper">
    <!-- Start Navbar -->
    <div class="menu-toggler">
            <span>
                <i class="mdi mdi-menu"></i>
            </span>
    </div>
    <header>
        <div class="header-navbar h-100">
            <div class="dropright">
                <a id="dropdown" class="navbar-brand" href="#"><b>H</b><span>${user.username}</span></a>
            </div>
            <div class="dropdown-menu" aria-labelledby="dropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <a class="dropdown-item" href="#">Something else here</a>
            </div>
            <nav class="navbar menu-list">
                <ul class="list-group text-center" id="menu">
                    <li class="list-group-item">
                        <a class="active" href="#home">
                            <span class="menu-icon mx-auto"><i class="mdi mdi-home-outline"></i></span>
                            <span>home</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#aboutus">
                            <span class="menu-icon mx-auto"><i class="mdi mdi-account-outline"></i></span>
                            <span>About</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#portfolio">
                            <span class="menu-icon mx-auto"><i class="mdi mdi-grid-large"></i></span>
                            <span>Blog</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#client">
                            <span class="menu-icon mx-auto"><i class="mdi mdi-chart-bubble"></i></span>
                            <span>Clients</span>
                        </a>
                    </li>
                    <li class="list-group-item">
                        <a href="#contact">
                            <span class="menu-icon mx-auto"><i class="mdi mdi-chat-processing-outline"></i></span>
                            <span>Contact</span>
                        </a>
                    </li>
                </ul>
            </nav>

        </div>

    </header>
    <!-- End Navbar -->
    <!-- Start Home -->
    <section class="home-bg section active" id="home">
        <div id="particles-js">
        </div>
        <div class="section-area">
            <div class="section-content">
                <div class="hero-text-area">
                    <div class="welcome-area">
                        <div class="container">
                            <div class="row align-items-center">
                                <div class="col-md-12">
                                    <div class="hero-text text-center">
                                        <div class="wel-txt">Hello</div>
                                        <h1>I Am&nbsp;<span class="typed"></span></h1>
                                    </div>
                                    <ul class="informative-txt d-flex justify-content-center align-items-center">
                                        <li>Golang</li>
                                        <li><i class="mdi mdi-circle mdi-10px ml-3 mr-3"></i></li>
                                        <li>Python</li>
                                        <li><i class="mdi mdi-circle mdi-10px ml-3 mr-3"></i></li>
                                        <li>Java</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Home -->
    <!-- Start About-Us -->
    <section class="section bg-light line-vector" id="aboutus">
        <div class="section-area">
            <div class="section-content">
                <div class="container">
                    <div class="title-block mx-auto">
                        <div class="section_title mb-4 text-center">
                            <h2><span>About Me</span></h2>
                        </div>
                    </div>
                    <div class="row " style="font-size: large;">
                        <div class="col-md-5 offset-md-1">
                            <div class="raw" data-toggle="tooltip" data-placement="left" title="点击更换头像">
                                <a href="#" data-toggle="modal" data-target="#avatars"><img src="img/玄弦幽_s.jpg" alt="头像" width="50px" height="50px"
                                                                                            style="border: 5px solid white;border-radius: 50%">
                                </a>
                                <!-- 模态框 -->
                                <div class="modal fade" id="avatars">
                                    <div class="modal-dialog">
                                        <div class="modal-content">

                                            <!-- 模态框头部 -->
                                            <div class="modal-header">
                                                <h4 class="modal-title">上传头像</h4>
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            </div>

                                            <!-- 模态框主体 -->
                                            <div class="modal-body">
                                                <form action="#" method="post" class="dropzone" id="myDropzone"
                                                      enctype="multipart/form-data"></form>
                                                <button id="upload" type="submit" class="btn btn-outline-info float-right" style="margin: 5px">提交</button>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="raw">
                                <label>昵称：${user.username}
                                    <%--                                    <div id="username">${user.username}</div>--%>

                                </label>
                            </div>
                            <div class="raw">
                                <label>
                                    邮箱：
                                    ${user.email}

                                </label>
                            </div>
                            <div class="raw">
                                <label>
                                    工作：${user.work}
                                    <%--                                    <div id="work">${user.work}</div>--%>

                                </label>
                            </div>
                            <div class="raw">
                                <label>
                                    电话：
                                    ${user.phone}

                                </label>
                            </div>
                            <div class="raw">
                                <label>
                                    地址：
                                    ${user.address}

                                </label>
                            </div>
                            <div class="raw">
                                <label>
                                    注册时间：
                                    ${user.registerTime}

                                </label>
                            </div>

                            <!-- 按钮：用于打开模态框 -->
                            <button type="button" class="btn btn-outline-info" data-toggle="modal"
                                    data-target="#ModifyUser">
                                修改信息
                            </button>

                            <!-- 模态框 -->
                            <div class="modal fade" id="ModifyUser">
                                <div class="modal-dialog">
                                    <div class="modal-content">

                                        <!-- 模态框头部 -->
                                        <div class="modal-header">
                                            <h4 class="modal-title">请输入要修改的信息</h4>
                                            <button type="button" class="close"
                                                    data-dismiss="modal">&times;</button>
                                        </div>

                                        <!-- 模态框主体 -->
                                        <div class="modal-body">
                                            <form method="post" action="blog">
                                                <div class="form-group">
                                                    <label for="nickname"></label>



                                                    <input class="form-control" id="nickname" name="nickname" placeholder="昵称" required type="text" value="">
                                                </div>

                                                <%--                                                <ul class="radio list-group-horizontal" id="gender" style="display:inline-block;list-style:none;margin:0"><li><input checked id="gender-0" name="gender" type="radio" value="男"> <label for="gender-0">男</label></li><li><input id="gender-1" name="gender" type="radio" value="女"> <label for="gender-1">女</label></li></ul>--%>
                                                <div class="form-group">
                                                    <label for="career"></label>
                                                    <input class="form-control" id="career" name="career" placeholder="工作" type="text" value="">

                                                </div>

                                                <div class="form-group">
                                                    <label for="phone"></label>
                                                    <input class="form-control" id="phone" name="phone" placeholder="电话" type="text" value="">

                                                </div>

                                                <div class="form-group">
                                                    <label for="address"></label>
                                                    <input class="form-control" id="address" name="address" placeholder="地址" type="text" value="">

                                                </div>


                                                <%--                                                <div class="form-group" style="height: 64px;">--%>
                                                <%--                                                    <label for="BornTime"></label>--%>
                                                <%--                                                    <div class="input-group date" data-data="" data-date-format="hh:ii" data-link-field="BornTime" data-link-format="hh:ii">--%>
                                                <%--                                                        <input class="form-control form_YMD" id="BornTime" name="bornTime" placeholder="出生日期" size="16" type="text" value="">--%>
                                                <%--                                                    </div>--%>
                                                <%--                                                </div>--%>


                                                <input class="btn btn-outline-info" id="submit" name="submit" type="submit" value="提交">
                                            </form>
                                        </div>

                                        <!-- 模态框底部 -->
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary"
                                                    data-dismiss="modal">关闭</button>
                                        </div>

                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="col-md-6 col-sm-12">
                            <div class="about-img-box">
                                <div class="image">
                                    <img src="img/about-img.jpg" class="img-fluid" alt="">
                                </div>
                            </div>
                        </div>
                    </div>
                </div></div>
        </div>
    </section>
    <!-- End About-Us -->
    <!-- Start Portfolio -->
    <section id="portfolio" class="section portfolio-section">
        <div class="section-area">
            <div class="section-content">
                <div class="container">
                    <div class="title-block mx-auto">
                        <div class="section_title mb-4 text-center">
                            <h2><span>Blog</span></h2>
                            <p class="section_subtitle mx-auto">this dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. this dolor sit amet.</p>
                        </div>
                    </div>
                    <div class="row">
                        <!--   Portfolio Filters   -->
                        <ul id="portfolio-filter" class="portfolio-filter filters">
                            <li class="button-border list-inline-item">
                                <a href="#" data-filter="*" class="pill-button active">All</a>
                            </li>
                            <li class="button-border list-inline-item">
                                <a href="#" data-filter=".webdesign" class="pill-button">Web Design</a>
                            </li>
                            <li class="button-border list-inline-item">
                                <a href="#" data-filter=".mobiledesign" class="pill-button">Mobile Design</a>
                            </li>
                            <li class="button-border list-inline-item">
                                <a href="#" data-filter=".seo" class="pill-button">Seo</a>
                            </li>
                            <li class="button-border list-inline-item">
                                <a href="#" data-filter=".graphic" class="pill-button">Graphic</a>
                            </li>
                        </ul>
                    </div>
                    <div class="portfolio-items row">
                        <!-- Item 01 -->
                        <div class="col-lg-4 portfolio-item seo">
                            <div class="image-border">
                                <div class="portfolio-box">
                                    <img src="img/portfolio/01.jpg" class="img-fluid" alt="">
                                    <div class="img-overlay text-center">
                                        <div class="portfolio-icon">
                                            <a href="img/portfolio/big/01.jpg" class="js-zoom-gallery">
                                                <i class="mdi mdi-magnify-plus-outline"></i>
                                            </a>
                                        </div>
                                        <h5 class="mt-3 mb-0">My Work</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Item 02 -->
                        <div class="col-lg-4 portfolio-item graphic webdesign">
                            <div class="image-border">
                                <div class="portfolio-box">
                                    <img src="img/portfolio/02.jpg" class="img-fluid" alt="">
                                    <div class="img-overlay text-center">
                                        <div class="portfolio-icon">
                                            <a href="img/portfolio/big/02.jpg" class="js-zoom-gallery">
                                                <i class="mdi mdi-magnify-plus-outline"></i>
                                            </a>
                                        </div>
                                        <h5 class="mt-3 mb-0">My Work</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Item 03 -->
                        <div class="col-lg-4 portfolio-item webdesign graphic">
                            <div class="image-border">
                                <div class="portfolio-box">
                                    <img src="img/portfolio/03.jpg" class="img-fluid" alt="">
                                    <div class="img-overlay text-center">
                                        <div class="portfolio-icon">
                                            <a href="img/portfolio/big/03.jpg" class="js-zoom-gallery">
                                                <i class="mdi mdi-magnify-plus-outline"></i>
                                            </a>
                                        </div>
                                        <h5 class="mt-3 mb-0">My Work</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Item 04 -->
                        <div class="col-lg-4 portfolio-item mobiledesign webdesign">
                            <div class="image-border">
                                <div class="portfolio-box">
                                    <img src="img/portfolio/04.jpg" class="img-fluid" alt="">
                                    <div class="img-overlay text-center">
                                        <div class="portfolio-icon">
                                            <a href="img/portfolio/big/04.jpg" class="js-zoom-gallery">
                                                <i class="mdi mdi-magnify-plus-outline"></i>
                                            </a>
                                        </div>
                                        <h5 class="mt-3 mb-0">My Work</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Item 05 -->
                        <div class="col-lg-4 portfolio-item mobiledesign seo">
                            <div class="image-border">
                                <div class="portfolio-box">
                                    <img src="img/portfolio/05.jpg" class="img-fluid" alt="">
                                    <div class="img-overlay text-center">
                                        <div class="portfolio-icon">
                                            <a href="img/portfolio/big/05.jpg" class="js-zoom-gallery">
                                                <i class="mdi mdi-magnify-plus-outline"></i>
                                            </a>
                                        </div>
                                        <h5 class="mt-3 mb-0">My Work</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Item 06 -->
                        <div class="col-lg-4 portfolio-item mobiledesign">
                            <div class="image-border">
                                <div class="portfolio-box">
                                    <img src="img/portfolio/06.jpg" class="img-fluid" alt="">
                                    <div class="img-overlay text-center">
                                        <div class="portfolio-icon">
                                            <a href="img/portfolio/big/06.jpg" class="js-zoom-gallery">
                                                <i class="mdi mdi-magnify-plus-outline"></i>
                                            </a>
                                        </div>
                                        <h5 class="mt-3 mb-0">My Work</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Item 07 -->
                        <div class="col-lg-4 portfolio-item mobiledesign webdesign">
                            <div class="image-border">
                                <div class="portfolio-box">
                                    <img src="img/portfolio/07.jpg" class="img-fluid" alt="">
                                    <div class="img-overlay text-center">
                                        <div class="portfolio-icon">
                                            <a href="img/portfolio/big/07.jpg" class="js-zoom-gallery">
                                                <i class="mdi mdi-magnify-plus-outline"></i>
                                            </a>
                                        </div>
                                        <h5 class="mt-3 mb-0">My Work</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Item 08 -->
                        <div class="col-lg-4 portfolio-item webdesign graphic">
                            <div class="image-border">
                                <div class="portfolio-box">
                                    <img src="img/portfolio/08.jpg" class="img-fluid" alt="">
                                    <div class="img-overlay text-center">
                                        <div class="portfolio-icon">
                                            <a href="img/portfolio/big/08.jpg" class="js-zoom-gallery">
                                                <i class="mdi mdi-magnify-plus-outline"></i>
                                            </a>
                                        </div>
                                        <h5 class="mt-3 mb-0">My Work</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Item 09 -->
                        <div class="col-lg-4 portfolio-item seo">
                            <div class="image-border">
                                <div class="portfolio-box">
                                    <img src="img/portfolio/09.jpg" class="img-fluid" alt="">
                                    <div class="img-overlay text-center">
                                        <div class="portfolio-icon">
                                            <a href="img/portfolio/big/09.jpg" class="js-zoom-gallery">
                                                <i class="mdi mdi-magnify-plus-outline"></i>
                                            </a>
                                        </div>
                                        <h5 class="mt-3 mb-0">My Work</h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!--  End Portfolio -->
    <!-- Start Testimonial -->
    <section class="section client-Testimonials" id="client">
        <div class="section-area">
            <div class="section-content">
                <div class="container">
                    <div class="title-block mx-auto">
                        <div class="section_title mb-4 text-center">
                            <h2><span>Client's Says</span></h2>
                            <p class="section_subtitle mx-auto">this dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. this dolor sit amet.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
                            <div class="owl-carousel owl-theme client-slider">
                                <div class="item">
                                    <div class="testi-content">
                                        <div class="title"><h3>Via Facebook</h3></div>
                                        <div class="text"><p>“ this dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. this dolor sit amet.  “</p></div>
                                        <div class="rating">
                                            <span class="mdi mdi-star"></span>
                                            <span class="mdi mdi-star"></span>
                                            <span class="mdi mdi-star"></span>
                                            <span class="mdi mdi-star-half"></span>
                                            <span class="mdi mdi-star-outline"></span>
                                        </div>
                                    </div>
                                    <div class="img-holder">
                                        <div class="img-box">
                                            <img src="img/testi/client01.jpg" class="img-fluid" alt="">
                                        </div>
                                        <div class="designation">Monica Morna</div>
                                        <div class="name"><h4>Jaksan Mora</h4></div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="testi-content">
                                        <div class="title"><h3>Via Twitter</h3></div>
                                        <div class="text"><p>“ this dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. this dolor sit amet. “</p></div>
                                        <div class="rating">
                                            <span class="mdi mdi-star"></span>
                                            <span class="mdi mdi-star"></span>
                                            <span class="mdi mdi-star"></span>
                                            <span class="mdi mdi-star-half"></span>
                                            <span class="mdi mdi-star-outline"></span>
                                        </div>
                                    </div>
                                    <div class="img-holder">
                                        <div class="img-box">
                                            <img src="img/testi/client01.jpg" class="img-fluid" alt="">
                                        </div>
                                        <div class="designation">Monica Morna</div>
                                        <div class="name"><h4>Jaksan Mora</h4></div>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="testi-content">
                                        <div class="title"><h3>Via Twitter</h3></div>
                                        <div class="text"><p>“ this dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. this dolor sit amet.  “</p></div>
                                        <div class="rating">
                                            <span class="mdi mdi-star"></span>
                                            <span class="mdi mdi-star"></span>
                                            <span class="mdi mdi-star"></span>
                                            <span class="mdi mdi-star-half"></span>
                                            <span class="mdi mdi-star-outline"></span>
                                        </div>
                                    </div>
                                    <div class="img-holder">
                                        <div class="img-box">
                                            <img src="img/testi/client01.jpg" class="img-fluid" alt="">
                                        </div>
                                        <div class="designation">Monica Morna</div>
                                        <div class="name"><h4>Jaksan Mora</h4></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Testimonial -->
    <!-- Start Contact -->
    <section class="section" id="contact">
        <div class="section-area">
            <div class="section-content">
                <div class="container">
                    <div class="title-block mx-auto">
                        <div class="section_title mb-4 text-center">
                            <h2><span>Contact Me</span></h2>
                            <p class="section_subtitle mx-auto">this dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. this dolor sit amet.</p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="contact-info text-center">
                                <div class="icon">
                                    <i class="mdi mdi-cellphone"></i>
                                </div>
                                <div class="content">
                                    <h4 class="title font-weight-bold">Phone</h4>
                                    <p class="text-muted">It is a long established fact that a reader will be distracted by the readable content</p>
                                    <a href="" class="h6 text-theme">+123 456-789-012</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="contact-info text-center">
                                <div class="icon">
                                    <i class="mdi mdi-email"></i>
                                </div>
                                <div class="content">
                                    <h4 class="title font-weight-bold">Email</h4>
                                    <p class="text-muted">It is a long established fact that a reader will be distracted by the readable content</p>
                                    <a href="mailto:contact@example.com" class="h6 text-theme">contact@example.com</a>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="contact-info text-center">
                                <div class="icon">
                                    <i class="mdi mdi-map-marker-radius-outline"></i>
                                </div>
                                <div class="content">
                                    <h4 class="title font-weight-bold">Location</h4>
                                    <p class="text-muted">C/54 Northwest Freeway,<br /> Near Northwest Street Road, <br>Houston, USA 485</p>
                                    <a href="https://www.google.com/maps" class="h6 text-theme">View on Google map</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row align-items-center">
                        <div class="col-md-6 order-2 order-md-1">
                            <div class="p-4 contact-box rounded form-box">
                                <h4 class="m-0">Get In Touch !</h4>
                                <div class="custom-form">
                                    <div id="message"></div>
                                    <form>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group position-relative">
                                                    <label>Your Name <span class="text-danger">*</span></label>
                                                    <i class="mdi mdi-account ml-3 icons"></i>
                                                    <label for="name"></label><input name="name" id="name" type="text" class="form-control pl-5" placeholder="First Name :" required>
                                                </div>
                                            </div><!--end col-->
                                            <div class="col-md-6">
                                                <div class="form-group position-relative">
                                                    <label>Your Email <span class="text-danger">*</span></label>
                                                    <i class="mdi mdi-email ml-3 icons"></i>
                                                    <%--                                                    <label for="email"></label><label>--%>
                                                    <input name="email"  type="email" class="form-control pl-5" placeholder="Your email :" required>
                                                    </label>
                                                </div>
                                            </div><!--end col-->
                                            <div class="col-md-12">
                                                <div class="form-group position-relative">
                                                    <label>Subject</label>
                                                    <i class="mdi mdi-book ml-3 icons"></i>
                                                    <label for="subject"></label><input name="subject" id="subject" type="text" class="form-control pl-5" placeholder="Subject">
                                                </div>
                                            </div><!--end col-->
                                            <div class="col-md-12">
                                                <div class="form-group position-relative">
                                                    <label>Comments</label>
                                                    <i class="mdi mdi-comment-text-outline ml-3 icons"></i>
                                                    <label for="comments"></label><textarea name="comments" id="comments" rows="4" class="form-control pl-5" placeholder="Your Message :"></textarea>
                                                </div>
                                            </div>
                                        </div><!--end row-->
                                        <div class="row">
                                            <div class="col-sm-12 text-center">
                                                <input type="submit" name="send" class="btn btn-hover send-btn btn-block" value="Send Message">
                                                <div id="simple-msg"></div>
                                            </div><!--end col-->
                                        </div><!--end row-->
                                    </form><!--end form-->
                                </div><!--end custom-form-->
                            </div>
                        </div><!--end col-->
                        <div class="col-md-6 order-1 order-md-2">
                            <div class="contact-img">
                                <img src="img/contact/contact-vector.png" class="img-fluid " alt="">
                            </div>
                        </div><!--end col-->
                    </div>

                    <div class="row">
                        <div class="col-12 ">
                            <p class="copy-right text-center">Copyright © 2020. Template has been designed by <b><a href="http://www.bootstrapmb.com/">Kaneziki</a></b></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- End Contact -->
</div>
<!-- Javascript -->
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
<!-- Main Js   -->
<script src="js/main.js"></script>
<script>
    $('.form_YMD').getYMD().on('changeDate', function (event) {
        event.preventDefault();
        event.stopPropagation();
    });
    $(document).ready(function(){
        $('[data-toggle="tooltip"]').tooltip();
    });

</script>
</body>

</html>

