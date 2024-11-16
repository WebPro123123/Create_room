<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>방 찾기</title>
    <link rel="stylesheet" href="css/find_room.css">
</head>
<body>
    <div class="main_room">
        <div class="left_sidebar">
            <h2>방 찾기</h2>
            <button class="back_button"><a href="index.jsp">뒤로가기</a></button>
        </div>
        <div id="content-area" class="content-area">
            <h2>원하는 방을 선택하세요</h2>
            <table border="1">
                <tr>
                    <th>방 ID</th>
                    <th>방 이름</th>
                    <th>비밀번호</th>
                </tr>
                <%
                    try {
                        Class.forName("org.mariadb.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/roomdb", "root", "0000");
                        String sql = "SELECT room_id, room_pwd, room_name FROM room_info";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getString("room_id") %></td>
                    <td><%= rs.getString("room_name") %></td>
                    <td><%= rs.getString("room_pwd") %></td>
                </tr>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
