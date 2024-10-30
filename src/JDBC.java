
import java.sql.*;

public class JDBC {
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        //加载驱动
        Class.forName("com.mysql.jdbc.Driver");

        //用户信息和url
        String url = "jdbc:mysql://localhost:3306/db02?useUnicode=true&characterEncoding=utf8&useSSL=true";
        String user = "root";
        String password = "12341234";

        //连接数据库
        Connection connection = DriverManager.getConnection(url, user, password);

        //执行SQL的对象
        Statement statement = connection.createStatement();

        //执行SQL的对象
        String sql = "select * from pets";

        ResultSet resultSet = statement.executeQuery(sql);

        while (resultSet.next()){
            System.out.println(resultSet.getObject("details"));
        }

        //释放资源
        resultSet.close();
        statement.close();
        connection.close();
    }
}
