<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>비용 계산 결과</title>
    <link rel="stylesheet" href="styles.css"> <!-- 원하는 스타일 시트 링크 -->
</head>
<body>
    <h1>비용 계산 결과</h1>

    <%
        // 파라미터 가져오기
        String product = request.getParameter("product");
        String numOfPeopleStr = request.getParameter("numOfPeople");
        String roomId = request.getParameter("room_id");

        // null 체크 및 값 검증
        if (product == null || numOfPeopleStr == null || roomId == null) {
    %>
        <p>필수 데이터가 전달되지 않았습니다. 방 정보 페이지로 돌아가서 다시 시도해 주세요.</p>
        <a href="findingRoom.jsp">방 목록으로 돌아가기</a>
    <%
        } else {
            try {
                // 인원 수 파싱
                int numOfPeople = Integer.parseInt(numOfPeopleStr);
                
                // 상품과 가격 정보 파싱 (상품명 - 가격 형식으로 들어옴)
                String[] productInfo = product.split(" - ");
                if (productInfo.length < 2) {
                    throw new IllegalArgumentException("상품 정보가 올바르지 않습니다.");
                }

                String productName = productInfo[0];
                int price = Integer.parseInt(productInfo[1].replaceAll("[^0-9]", ""));

                // 각자 부담해야 하는 금액 계산
                if (numOfPeople > 0) {
                    int costPerPerson = price / numOfPeople;

                    // 계산 결과를 JSP 페이지에 출력
    %>
                    <div>
                        <p><strong>선택한 상품: </strong> <%= productName %></p>
                        <p><strong>총 금액: </strong> <%= price %> 원</p>
                        <p><strong>인원 수: </strong> <%= numOfPeople %> 명</p>
                        <p><strong>각자 부담금: </strong> <%= costPerPerson %> 원</p>
                    </div>
    <%
                } else {
    %>
                    <p>인원 수는 1명 이상이어야 합니다. 다시 입력해 주세요.</p>
    <%
                }
            } catch (NumberFormatException e) {
                // 숫자로 파싱하는 과정에서 오류 발생 시
    %>
                <p>입력한 값에 오류가 있습니다. 숫자를 올바르게 입력했는지 확인해 주세요.</p>
    <%
            } catch (IllegalArgumentException e) {
                // 잘못된 상품 정보 예외 처리
    %>
                <p><%= e.getMessage() %></p>
    <%
            } catch (Exception e) {
                // 기타 예외 발생 시
    %>
                <p>서버에서 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.</p>
    <%
            }
        }
    %>

    <a href="roomDetails.jsp?room_id=<%= roomId %>">방 정보로 돌아가기</a>
</body>
</html>
