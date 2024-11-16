import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/CreateRoomServlet")
public class CreateRoomServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mariadb://localhost:3306/roomdb?useUnicode=true&characterEncoding=utf8";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "0000";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 요청과 응답의 인코딩을 UTF-8로 설정
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String roomId = request.getParameter("room_id");
        String roomPwd = request.getParameter("room_pwd");
        String roomName = request.getParameter("room_name");
        
        try {
            // 비밀번호를 bcrypt로 해싱
            String hashedPwd = BCrypt.hashpw(roomPwd, BCrypt.gensalt());

            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

            String sql = "INSERT INTO room_info (room_id, room_pwd, room_name) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, roomId);
            stmt.setString(2, hashedPwd);  // 해싱된 비밀번호를 저장
            stmt.setString(3, roomName);
            
            stmt.executeUpdate();
            stmt.close();
            conn.close();

            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }

}
