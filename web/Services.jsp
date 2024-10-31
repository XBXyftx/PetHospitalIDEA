<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>医疗服务</title>
    <link rel="stylesheet" href="css/Services.css">
</head>
<body>
<div class="base">
    <!-- 头部 -->
    <div class="header_base">
        <div class="header_logo">
            <img src="img/logo.svg" alt="logo" class="header_logo_img">
            <span class="header_logo_text">爱宠一方</span>
        </div>
        <div class="header_choices">
            <span class="header_choice" onclick="window.location.href='index.html'">首页</span>
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

    <!-- 主体 -->
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
</div>

<script>
    var Index = document.querySelectorAll(".header_choice")[0];
    Index.addEventListener("click",()=>{
        window.location.href = "index.jsp";
    })
    function fetchMedicalRecords() {
        const petName = document.getElementById('petName').value;

        // AJAX请求
        const xhr = new XMLHttpRequest();
        xhr.open("GET", "Return.jsp?name=" + encodeURIComponent(petName), true);

        xhr.onload = function() {
            if (xhr.status === 200) {
                // 直接覆盖整个页面内容
                document.getElementById("medicalRecords").innerHTML = xhr.responseText;
            } else {
                console.error('Error: ' + xhr.statusText);
                document.getElementById('medicalRecords').innerHTML = `<p>查询失败，请重试。</p>`;
            }
        };

        xhr.onerror = function() {
            console.error('Request failed');
            document.getElementById('medicalRecords').innerHTML = `<p>查询失败，请重试。</p>`;
        };

        xhr.send();
    }
</script>

<%
    // PetRecord 类
    class PetRecord {
        private int id;
        private String name;
        private String date;
        private String stage;
        private String details;

        public PetRecord(int id, String name, String date, String stage, String details) {
            this.id = id;
            this.name = name;
            this.date = date;
            this.stage = stage;
            this.details = details;
        }

        public int getId() { return id; }
        public String getName() { return name; }
        public String getDate() { return date; }
        public String getStage() { return stage; }
        public String getDetails() { return details; }
    }
    // 数据库配置
    String url = "jdbc:mysql://localhost:3306/db02?useUnicode=true&characterEncoding=utf8&useSSL=true";
    String user = "root";
    String password = "12341234";

    // 获取查询参数
    String petName = request.getParameter("name");
    if (petName != null) {
        response.setContentType("text/html;charset=UTF-8"); // 确保在输出HTML之前设置内容类型
        List<PetRecord> records = new ArrayList<>();
        try {
            // 加载数据库驱动
            Class.forName("com.mysql.cj.jdbc.Driver");

            // 建立数据库连接
            try (Connection connection = DriverManager.getConnection(url, user, password)) {
                String sql = "SELECT * FROM pets WHERE name = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, petName); // 使用 PreparedStatement 防止 SQL 注入
                    ResultSet resultSet = preparedStatement.executeQuery();

                    // 遍历结果集并生成 HTML
                    if (!resultSet.isBeforeFirst()) {
                        out.println("<p>未找到该宠物的就医记录。</p>");
                    } else {
                        out.println("<h3>" + petName + " 的就医记录</h3>");
                        while (resultSet.next()) {
                            out.println("<div class=\"medical-record\">");
                            out.println("<h4>" + resultSet.getString("data") + " - " + resultSet.getString("stage") + "</h4>");
                            out.println("<p>" + resultSet.getString("details") + "</p>");
                            out.println("</div>");
                        }
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

</body>
</html>

