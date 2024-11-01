<%@ page import="java.sql.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%
    String url = "jdbc:mysql://localhost:3306/db02?useUnicode=true&characterEncoding=utf8&useSSL=true";
    String user = "root";
    String password = "12341234";


    // 获取当前日期
    LocalDate currentDate = LocalDate.now();
    // 定义日期格式
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    // 格式化日期
    String formattedDate = currentDate.format(formatter);

    String name = request.getParameter("petName");
    String id = System.currentTimeMillis()+"";
    String date = formattedDate;
    String stage = "入院";
    String details = "无";

    if (name != null && !name.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(url, user, password)) {
                String sql = "INSERT INTO pets (id,name,date,stage,details) VALUES (?)";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, id);
                    preparedStatement.setString(2, name);
                    preparedStatement.setString(3, date);
                    preparedStatement.setString(4, stage);
                    preparedStatement.setString(5, details);
                    int rows = preparedStatement.executeUpdate();

                    if (rows > 0) {
                        out.println("登记成功");
                    } else {
                        out.println("登记失败");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            out.println("数据库错误，请稍后重试。");
        }
    } else {
        out.println("无效的输入");
    }
%>
