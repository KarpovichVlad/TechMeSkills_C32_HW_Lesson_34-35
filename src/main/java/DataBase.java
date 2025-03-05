import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBase {

    private static final String URL = "jdbc:postgresql://localhost:5432/postgres";
    private static final String USER = "postgres";
    private static final String PASSWORD = "root";

    public static Connection connect() {
        Connection connection = null;
        try {
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Подключение к БД успешно!");
        } catch (SQLException e) {
            System.err.println("Ошибка подключения: " + e.getMessage());
        }
        return connection;
    }

    public static void main(String[] args) {
        connect();
    }
}
