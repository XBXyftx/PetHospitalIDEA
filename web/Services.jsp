<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2024/10/30
  Time: 10:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>医疗服务</title>
    <link rel="stylesheet" href="css/Services.css">
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
    <div class="container">
        <h2>医疗服务记录</h2>
        <div class="form-group">
            <label for="petName">宠物名称:</label>
            <input type="text" id="petName" name="petName" required>
        </div>
        <div class="form-group">
            <input type="submit" value="查询就医记录" onclick="fetchMedicalRecords();">
        </div>

        <div id="medicalRecords">
            <!-- 就医记录将在这里显示 -->
        </div>
    </div>
    <!-- 主体end -->

</div>
<script>
    var Index = document.querySelectorAll(".header_choice")[0];
    Index.addEventListener("click",()=>{
        window.location.href = "index.jsp";
    })

    function fetchMedicalRecords() {
        var petName = document.getElementById('petName').value;
        // 这里需要从服务器获取数据
        var medicalRecords = [
            {
                date: '2024-03-15',
                stage: '检查',
                details: '进行了血液检查和X光检查。'
            },
            {
                date: '2024-03-18',
                stage: '诊断',
                details: '诊断为轻微关节炎。'
            },
            {
                date: '2024-03-20',
                stage: '取药',
                details: '开具了抗炎药物。'
            }
        ];

        var recordsHtml = '<h3>' + petName + "的就医记录</h3>";
        recordsHtml += '<div class="medical-record">';
        for (var i = 0; i < medicalRecords.length; i++) {
            var record = medicalRecords[i];
            recordsHtml += '<h4>' + record.date + ' - ' + record.stage + '</h4>';
            recordsHtml += '<p>' + record.details + '</p>';
        }
        recordsHtml += '</div>';

        document.getElementById('medicalRecords').innerHTML = recordsHtml;
    }

</script>
</body>
</html>
