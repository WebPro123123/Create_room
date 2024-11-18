<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 데이터베이스 연결 설정 -->
<sql:setDataSource var="dataSource" driver="org.mariadb.jdbc.Driver"
                   url="jdbc:mariadb://localhost:3306/roomdb" user="root" password="0000" />

<!-- 파라미터에서 room_id 값을 가져와서 변수에 저장 -->
<c:set var="roomId" value="${param.room_id}" />

<!-- 디버깅용 로그 - room_id 출력 -->
<p>디버깅: 요청된 room_id: ${roomId}</p>

<!-- MariaDB에 쿼리 수행 -->
<sql:query var="roomDetails" dataSource="${dataSource}">
    SELECT room_name, room_id, room_pwd, product_name, price 
    FROM room_info WHERE room_id = ?
    <sql:param value="${roomId}" />
</sql:query>

<!-- 방 정보를 보여주는 부분 -->
<c:if test="${not empty roomDetails.rows}">
    <c:set var="room" value="${roomDetails.rows[0]}" />
    <h2>방 이름: ${room.room_name}</h2>
    <p><strong>방 ID:</strong> ${room.room_id}</p>
    <p><strong>방 비밀번호:</strong> ${room.room_pwd}</p>
    
    <!-- 사용자가 선택할 수 있는 상품 목록과 비용 계산 폼 -->
    <form action="calculateShare.jsp" method="post">
        <label for="product">상품 선택: </label>
        <select name="product" id="product">
            <option value="${room.product_name}">${room.product_name} - ${room.price} 원</option>
        </select>

        <label for="numOfPeople">인원 수: </label>
        <input type="number" id="numOfPeople" name="numOfPeople" value="3" required>
        
        <button type="submit">비용 계산</button>
    </form>
</c:if>

<!-- 방이 없는 경우 메시지 출력 -->
<c:if test="${empty roomDetails.rows}">
    <p>해당 방을 찾을 수 없습니다.</p>
</c:if>
