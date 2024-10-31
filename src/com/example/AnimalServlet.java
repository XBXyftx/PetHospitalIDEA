package com.example;

import com.google.gson.Gson;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AnimalServlet")
public class AnimalServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 设置响应类型为 JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 数据库配置
        String url = "jdbc:mysql://localhost:3306/db02?useUnicode=true&characterEncoding=utf8&useSSL=true";
        String user = "root";
        String password = "12341234";

        // 获取查询参数
        String petName = request.getParameter("name");
        System.out.println("Received request with petName: " + petName);

        // 查询数据库并生成 JSON
        List<PetRecord> records = new ArrayList<>();
        try {
            // 加载数据库驱动
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("MySQL JDBC Driver loaded successfully.");

            // 建立数据库连接
            try (Connection connection = DriverManager.getConnection(url, user, password)) {
                System.out.println("Connected to database.");

                String sql = "SELECT * FROM pets WHERE name = ?";
                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, petName); // 使用 PreparedStatement 防止 SQL 注入
                    ResultSet resultSet = preparedStatement.executeQuery();

                    // 检查是否有结果
                    if (!resultSet.isBeforeFirst()) {
                        System.out.println("No records found for pet name: " + petName);
                    }

                    // 遍历结果集并存储到列表中
                    while (resultSet.next()) {
                        PetRecord record = new PetRecord(
                                resultSet.getInt("id"),
                                resultSet.getString("name"),
                                resultSet.getString("date"),
                                resultSet.getString("stage"),
                                resultSet.getString("details")
                        );
                        records.add(record);
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("SQL Exception encountered:");
            e.printStackTrace();
        }

        // 将结果转换为 JSON 并返回
        Gson gson = new Gson();
        String json = gson.toJson(records);
        System.out.println("Generated JSON response: " + json); // 输出生成的 JSON 数据
        response.getWriter().write(json);
    }
}

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
}
