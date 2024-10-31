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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // 数据库配置
        String url = "jdbc:mysql://localhost:3306/db02?useUnicode=true&characterEncoding=utf8&useSSL=true";
        String user = "root";
        String password = "12341234";

        // 查询数据库并生成 JSON
        List<PetRecord> records = new ArrayList<>();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(url, user, password);
                 Statement statement = connection.createStatement()) {

                String petName = request.getParameter("name");
                String sql = "SELECT * FROM pets WHERE name = '" + petName + "'";
                ResultSet resultSet = statement.executeQuery(sql);

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
        } catch (Exception e) {
            e.printStackTrace();
        }

        // JSON 转换
        Gson gson = new Gson();
        String json = gson.toJson(records);
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
