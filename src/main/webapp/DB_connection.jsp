<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.Statement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
    </head>
    <body>

        <%
            Class.forName("org.mariadb.jdbc.Driver");
            String connString = "jdbc:mariadb://127.0.0.1:3306/ROOM_DB";
            String id = "root";
            String password = "0000";
            String sql = "select * from room_info where room_id=?";

            try(Connection conn = DriverManager.getConnection(connString, id, password);
                PreparedStatement pstmt = conn.prepareStatement(sql))
            {
                pstmt.setString(1,"admin");
                try(ResultSet rs = pstmt.executeQuery())
                {
                    while(rs.next())
                    {
                        out.print(rs.getString("room_id") + ", ");
                        out.print(rs.getString("room_name") + "<br>");
                    }
                }
            }catch(SQLException se){
                se.printStackTrace();
            }
        %>
    </body>
</html>