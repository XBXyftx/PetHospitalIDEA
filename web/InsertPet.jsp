<%@ page pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%
    String url = "jdbc:mysql://localhost:3306/db02?useUnicode=true&characterEncoding=utf8&useSSL=true";// 数据库连接URL
    String user = "root";
    String password = "12341234";


    // 获取当前日期
    LocalDate currentDate = LocalDate.now();
    // 定义日期格式
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");// 设置日期格式
    // 格式化日期
    String formattedDate = currentDate.format(formatter);

    String name = request.getParameter("petName");
    System.out.println(name);
    int id = (int) System.currentTimeMillis();// 生成一个唯一的ID
    String date = formattedDate;// 获取当前日期
//    String stage = "入院";
//    String details = "无";

    if (name != null && !name.isEmpty()) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");// 加载驱动
            try (Connection connection = DriverManager.getConnection(url, user, password)) {// 连接数据库
                String sql = "INSERT INTO pets (id,name,date,stage,details) VALUES (?, ?, ?, ?, ?)";// SQL语句
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {// 准备SQL语句
                    preparedStatement.setInt(1, id);// 设置参数
                    preparedStatement.setString(2, name);// 设置参数
                    preparedStatement.setString(3, date);// 设置参数
                    preparedStatement.setString(4, "入院");// 设置参数
                    preparedStatement.setString(5, "成功登记入院");// 设置参数
                    int rows = preparedStatement.executeUpdate();// 执行SQL语句

                    if (rows > 0) {
                        out.println("登记成功");// 输出结果
                    } else {
                        out.println("登记失败");
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();// 打印异常信息
            out.println("数据库错误，请稍后重试。");
        }
    } else {
        out.println("无效的输入");
    }
%>
