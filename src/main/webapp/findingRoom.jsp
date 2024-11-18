<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<title>방 찾기</title>
<link rel="stylesheet" href="css/find_room.css">
<script src="script.js" defer></script>
<!-- JavaScript 추가 -->
</head>
<body>
	<div class="main_room">
		<div class="left_sidebar">
			<h2>방 찾기</h2>
			<button class="back_button">
				<a href="index.jsp">뒤로가기</a>
			</button>
		</div>
		<div id="content-area" class="content-area">
			<h2>원하는 방을 선택하세요</h2>
			<table border="1">
				<thead>
					<tr>
						<th>방 ID</th>
						<th>방 이름</th>
					</tr>
				</thead>
				<tbody>
					<%
					try {
						Class.forName("org.mariadb.jdbc.Driver");
						Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/roomdb", "root", "0000");
						String sql = "SELECT room_id, room_name FROM room_info";
						PreparedStatement stmt = conn.prepareStatement(sql);
						ResultSet rs = stmt.executeQuery();
						while (rs.next()) {
							String roomId = rs.getString("room_id");
							String roomName = rs.getString("room_name");
					%>
					<tr onclick="openPasswordModal('<%=rs.getString("room_id")%>')">
						<td><%=rs.getString("room_id")%></td>
						<td><%=rs.getString("room_name")%></td>
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
				</tbody>
			</table>
		</div>
	</div>

	<!-- 비밀번호 입력 모달 -->
	<div id="passwordModal" class="modal" style="display: none;">
		<div class="modal-content">
			<span class="close" onclick="closeModal()">&times;</span>
			<h2>비밀번호 입력</h2>
			<label for="roomPassword">비밀번호:</label> <input type="password"
				id="roomPassword">
			<button id="confirmPasswordButton">확인</button>
		</div>
	</div>
</body>
</html>
