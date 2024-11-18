document.getElementById('create-room-button').addEventListener('click', function() {
    const roomId = document.getElementById('room-id').value;
    const roomName = document.getElementById('room-name').value;
    const roomPwd = document.getElementById('password').value;

    // 폼 데이터를 서버에 POST 방식으로 전송
    fetch('/CreateRoomServlet', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `room_id=${roomId}&room_name=${roomName}&room_pwd=${roomPwd}`
    })
    .then(response => response.text())
    .then(data => {
        console.log(data);
        alert('방이 생성되었습니다!');
        // 방 생성 후 해당 방으로 이동
        window.location.href = `/roomDetails.jsp?room_id=${roomId}`;
    })
    .catch(error => console.error('Error:', error));
});
