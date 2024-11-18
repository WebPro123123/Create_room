<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Room List</title>
</head>
<body>
	<h2>Room List</h2>

	<%
	Class.forName("org.mariadb.jdbc.Driver");
	String connString = "jdbc:mariadb://localhost:3306/roomdb";
	String id = "root"; // MariaDB 사용자명
	String password = "0000"; // MariaDB 비밀번호

	String sql = "SELECT room_id, room_pwd, room_name FROM room_info";

	try (Connection conn = DriverManager.getConnection(connString, id, password);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery()) {
	%>
	<table border="1">
		<tr>
			<th>Room ID</th>
			<th>Password</th>
			<th>Room Name</th>
		</tr>
		<%
		while (rs.next()) {
		%>
		<tr>
			<td><%=rs.getString("room_id")%></td>
			<td><%=rs.getString("room_pwd")%></td>
			<td><%=rs.getString("room_name")%></td>
		</tr>
		<%
		}
		%>
	</table>
	<%
	} catch (SQLException e) {
	out.println("Error: " + e.getMessage());
	}
	%>

</body>
</html>
