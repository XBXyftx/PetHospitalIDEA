<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2024/10/30
  Time: 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>宠物登记界面</title>
    <link rel="stylesheet" href="css/CheckIn.css">
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
        <div class="main_content">
            <div class="main_content_center">
                <h2>宠物到院登记</h2>
                <form id="checkInForm">
                    <div class="form-group">
                        <label for="petName">宠物名称:</label>
                        <input type="text" id="petName" name="petName" required>
                    </div>
                    <div class="form-group">
                        <label for="petType">宠物种类:</label>
                        <select id="petType" name="petType">
                            <option value="dog">狗</option>
                            <option value="cat">猫</option>
                            <option value="bird">鸟</option>
                            <option value="other">其他</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="ownerName">主人姓名:</label>
                        <input type="text" id="ownerName" name="ownerName" required>
                    </div>
                    <div class="form-group">
                        <label for="ownerContact">联系方式:</label>
                        <input type="text" id="ownerContact" name="ownerContact" required>
                    </div>
                    <div class="form-group">
                        <label for="petHealth">宠物健康状况:</label>
                        <textarea id="petHealth" name="petHealth" rows="4"></textarea>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="提交登记">
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- 主体end -->
</div>

<script>
    var Index = document.querySelectorAll(".header_choice")[0];
    Index.addEventListener("click",()=>{
        window.location.href = "index.jsp";
    })

</script>

</body>
</html>
