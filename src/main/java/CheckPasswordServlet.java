import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/CheckPasswordServlet")
public class CheckPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String roomId = request.getParameter("room_id").trim();
        String enteredPwd = request.getParameter("room_pwd").trim();

        boolean isPasswordCorrect = false;
        String roomName = null;

        String jdbcUrl = "jdbc:mariadb://localhost:3306/roomdb";
        String dbUser = "root";
        String dbPwd = "0000";

        try {
            Class.forName("org.mariadb.jdbc.Driver");
            Connection conn = DriverManager.getConnection(jdbcUrl, dbUser, dbPwd);
            String sql = "SELECT room_pwd, room_name FROM room_info WHERE room_id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, roomId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String dbPassword = rs.getString("room_pwd");
                roomName = rs.getString("room_name");

                // 디버깅 로그 추가
                System.out.println("입력된 비밀번호: " + enteredPwd);
                System.out.println("DB에서 가져온 비밀번호 해시: " + dbPassword);

                if (BCrypt.checkpw(enteredPwd, dbPassword)) {
                    isPasswordCorrect = true;
                }
            }

            rs.close();
            pstmt.close();
            conn.close();

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();

            if (isPasswordCorrect) {
                out.write("{\"success\": true, \"room_name\": \"" + roomName + "\"}");
            } else {
                out.write("{\"success\": false, \"message\": \"비밀번호가 틀렸습니다.\"}");
            }
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"서버 오류가 발생했습니다.\"}");
        }
    }
}
