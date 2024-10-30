<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2024/10/30
  Time: 10:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>宠物医院首页</title>
    <link rel="stylesheet" href="css/Index.css">

</head>

<body>
<div class="base">
    <!-- 头部start -->
    <div class="header_base">
        <div class="header_logo">
            <img src="img/logo.svg" alt="logo" class="header_logo_img">
            <span class="header_logo_text">爱宠一方</span>
        </div>
        <div class="header_choices">
            <span class="header_choice">首页</span>
            <span class="header_choice">医疗团队</span>
            <span class="header_choice">诊疗服务</span>
            <span class="header_choice">康复故事</span>
            <span class="header_choice">宠物商城</span>
        </div>
        <div class="header_login">
            <img src="img/call.svg" alt="电话" class="header_login_img">
            <span class="header_choice">|</span>
            <img src="img/wechat.svg" alt="微信" class="header_login_img">
            <span class="header_choice">|</span>
            <span class="header_choice">登录</span>
            <span class="header_choice">|</span>
            <span class="header_choice">注册</span>
        </div>
    </div>
    <!-- 头部end -->

    <!-- 主体start -->
    <div class="main_base">
        <div class="main_checkIn">
            <div class="main_checkIn_title">
                <div class="main_checkIn_title_text">宠物到院登记</div>
                <div class="main_checkIn_title_text">Pet Check In</div>
                <img src="img/in.svg" alt="进入" class="main_checkIn_title_img">
                <div class="main_checkIn_title_text_tips">未登记的爱宠请先登记</div>
            </div>
        </div>
        <div class="main_medicalService">
            <div class="main_medicalService_title">
                <div class="main_medicalService_title_text">医疗服务</div>
                <div class="main_medicalService_title_text">Medical Service</div>
                <img src="img/in.svg" alt="进入" class="main_medicalService_title_img">
                <div class="main_medicalService_title_text_tips">登记过的宠物点这里</div>
            </div>
        </div>
    </div>
    <!-- 主体end -->
</div>
<script>
    var checkInTitle = document.querySelector(".main_checkIn_title");
    var medicalServiceTitle = document.querySelector(".main_medicalService_title");

    checkInTitle.addEventListener("click", ()=>{
        window.location.href = 'CheckIn.jsp';
        console.log("click");
    });

    medicalServiceTitle.addEventListener("click", ()=>{
        window.location.href = 'Services.jsp';
        console.log("click");
    });
</script>

</body>
</html>
