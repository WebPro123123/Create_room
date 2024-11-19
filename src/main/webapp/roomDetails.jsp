<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>방 정보 및 비용 계산</title>
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="css/roomdetails.css">
</head>
<body>
    <div class="main_room">
        <div class="left_sidebar">
            <h2>방 정보</h2>
            <button class="back_button"><a href="findingRoom.jsp">뒤로가기</a></button>
        </div>

        <div class="content-area">
            <sql:setDataSource var="dataSource" driver="org.mariadb.jdbc.Driver"
                               url="jdbc:mariadb://localhost:3306/roomdb" user="root" password="0000" />

            <sql:query var="roomDetails" dataSource="${dataSource}">
                SELECT room_name, room_id, room_pwd
                FROM room_info
                WHERE room_id = ?
                <sql:param value="${param.room_id}" />
            </sql:query>

            <c:if test="${not empty roomDetails.rows}">
                <c:set var="room" value="${roomDetails.rows[0]}" />
                <h2>방 이름: ${room.room_name}</h2>
                <p><strong>방 ID:</strong> ${room.room_id}</p>
          
                
                <form action="calculateShare.jsp" method="post">
                    <label for="product">상품 선택: </label>
                    <select name="product" id="product">
                        <option value="${room.product_name}">${room.product_name} - ${room.price} 원</option>
                    </select>

                    <label for="numOfPeople">인원 수: </label>
                    <input type="number" id="numOfPeople" name="numOfPeople" value="3" required>
                    
                    <button type="submit" class="submit_button">비용 계산</button>
                </form>
            </c:if>

            <c:if test="${empty roomDetails.rows}">
                <p>해당 방을 찾을 수 없습니다.</p>
            </c:if>
        </div>
    </div>
</body>
</html>
