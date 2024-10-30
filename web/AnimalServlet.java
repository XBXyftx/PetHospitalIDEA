import com.google.gson.Gson;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/AnimalServlet")
public class AnimalServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 加载驱动
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        // 用户信息和数据库 URL
        String url = "jdbc:mysql://localhost:3306/db02?useUnicode=true&characterEncoding=utf8&useSSL=true";
        String user = "root";
        String password = "12341234";

        // 查询数据库并生成 JSON
        List<PetRecord> records = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(url, user, password);
             Statement statement = connection.createStatement()) {

            String sql = "SELECT * FROM pets";
            ResultSet resultSet = statement.executeQuery(sql);

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

            // 转换为 JSON 格式
            Gson gson = new Gson();
            String json = gson.toJson(records);
            response.setContentType("application/json");
            response.getWriter().write(json);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}

// 创建 PetRecord 类用于存储每条记录的信息
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

    // Getters 和 Setters （如果需要）
}
