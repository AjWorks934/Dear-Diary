import java.sql.Connection;
import com.deardiary.DBConnection;

public class TestDBConnection {
    public static void main(String[] args) {
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                System.out.println("Database connection successful!");
            } else {
                System.out.println("Database connection failed!");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
