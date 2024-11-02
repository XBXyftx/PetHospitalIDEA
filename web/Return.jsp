<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 2024/10/31
  Time: 21:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
<%--    <style>--%>
<%--        .white {--%>
<%--            width: 100%;--%>
<%--            height: 100px;--%>
<%--            /*background-color: white;*/--%>
<%--            background-color: rgba(255, 255, 255, 0.56);--%>
<%--        }--%>
<%--    </style>--%>
</head>
<body>
    <div class="white">

    </div>
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
            try {
                // 加载数据库驱动
                Class.forName("com.mysql.cj.jdbc.Driver");

                // 建立数据库连接
                try (Connection connection = DriverManager.getConnection(url, user, password)) {
                    String sql = "SELECT * FROM pets WHERE name = ?";
                    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {// 使用 try-with-resources 确保资源被正确关闭
                        //prepareStatement(sql)：这是 Connection 接口的一个方法，用于创建一个 PreparedStatement 对象。你需要传递一个 SQL 语句作为参数给这个方法。
                       // sql是一个字符串变量，包含了要执行的 SQL 语句。当使用 PreparedStatement 时，SQL 语句中的参数需要用 ? 占位符来表示。
                        preparedStatement.setString(1, petName); // 使用 PreparedStatement 防止 SQL 注入
                        ResultSet resultSet = preparedStatement.executeQuery();// 执行查询

                        // 遍历结果集并生成 HTML
                        if (!resultSet.isBeforeFirst()) {// 检查是否有结果resultSet.isBeforeFirst()有结果为真，此处加了!代表没结果进入
                            out.println("<p>未找到该宠物的就医记录。</p>");
                        } else {
                            out.println("<h3>" + petName + " 的就医记录</h3>");
                            while (resultSet.next()) {
                                out.println("<div class=\"medical-record\">");// 每条记录用一个 div 包裹
                                out.println("<h4>" + resultSet.getString("date") + " - " + resultSet.getString("stage") + "</h4>");
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
