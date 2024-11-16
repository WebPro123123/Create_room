<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>방 만들기</title>
    <link rel="stylesheet" href="css/create_room.css">
</head>
<body>
    <form method="post" action="CreateRoomServlet">
        <div class="main_room">
            <div class="left_sidebar">
                <h2>방 만들기</h2>
                <button class="back_button"><a href="index.jsp">뒤로가기</a></button>
            </div>
            <div id="content-area" class="content-area">
                <h2>정보를 입력해주세요</h2>
                <label for="room_id">방 ID :</label>
                <input type="text" id="room_id" name="room_id" placeholder="방 ID를 입력하세요" required><br><br>

                <label for="room_pwd">비밀번호 :</label>
                <input type="password" id="room_pwd" name="room_pwd" placeholder="비밀번호 입력" required><br><br>

                <label for="room_name">방 이름 :</label>
                <input type="text" id="room_name" name="room_name" placeholder="방 이름을 입력하세요" required><br><br>

                <button type="submit">방 만들기</button>
            </div>
        </div>
    </form>
</body>
</html>
