// 방 생성 이벤트
const createRoomButton = document.getElementById('create-room-button');
if (createRoomButton) {
    createRoomButton.addEventListener('click', function() {
        const roomName = document.getElementById('room-name').value.trim();
        const roomPwd = document.getElementById('password').value.trim();
        const roomId = document.getElementById('room-id').value.trim();

        if (!roomName || !roomPwd || !roomId) {
            alert('모든 입력 값을 채워주세요.');
            return;
        }

        console.log('방 생성 요청 중...');

        fetch('/CreateRoomServlet', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: `room_id=${roomId}&room_pwd=${roomPwd}&room_name=${roomName}`
        })
        .then(response => response.text())
        .then(data => {
            console.log('방 생성 응답:', data);
            alert('방이 생성되었습니다!');
            window.location.href = '/findingRoom.jsp';
        })
        .catch(error => console.error('방 생성 중 오류:', error));
    });
} else {
    console.error("'create-room-button' 요소를 찾을 수 없습니다.");
}

// 방 클릭 시 비밀번호 입력 모달 열기
function openPasswordModal(roomId) {
    console.log('비밀번호 모달 열기:', roomId);
    const modal = document.getElementById('passwordModal');
    if (modal) {
        modal.style.display = 'block';
        const confirmButton = document.getElementById('confirmPasswordButton');
        confirmButton.onclick = function() {
            checkPassword(roomId);
        };
    } else {
        console.error("'passwordModal' 요소를 찾을 수 없습니다.");
    }
}

// 모달 닫기
function closeModal() {
    const modal = document.getElementById('passwordModal');
    if (modal) {
        modal.style.display = 'none';
    } else {
        console.error("'passwordModal' 요소를 찾을 수 없습니다.");
    }
}

// 모달 닫기 버튼 이벤트
const closeButton = document.querySelector('.close');
if (closeButton) {
    closeButton.addEventListener('click', closeModal);
} else {
    console.error("'.close' 요소를 찾을 수 없습니다.");
}

// 비밀번호 확인하기 수정
function checkPassword(roomId) {
    const enteredPassword = document.getElementById('roomPassword').value.trim();

    console.log('비밀번호 확인 요청 중...');

    const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));

    fetch(`${contextPath}/CheckPasswordServlet`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `room_id=${roomId}&room_pwd=${enteredPassword}`
    })
    .then(response => {
        console.log('응답 상태 코드:', response.status);
        if (!response.ok) {
            throw new Error('비밀번호 확인 요청 실패 - 상태 코드: ' + response.status);
        }
        return response.json();
    })
    .then(data => {
        console.log('응답 데이터:', data);
        if (data.success) {
            alert('방에 입장합니다.');
            // JSP 파일 경로 수정
            window.location.href = `/Room/roomDetails.jsp?room_id=${roomId}`;

        } else {
            alert('비밀번호가 일치하지 않습니다.');
        }
    })
    .catch(error => {
        console.error('비밀번호 확인 중 오류:', error);
        alert('오류가 발생했습니다: ' + error.message);
    });
}

// 페이지 로드 시 이벤트 리스너 초기화
window.onload = function() {
    // 방 목록의 각 방 클릭 시 비밀번호 모달 열기
    const roomItems = document.querySelectorAll('.room-item');
    roomItems.forEach(roomElement => {
        roomElement.addEventListener('click', function() {
            const roomId = this.dataset.roomId;  // 방 ID를 데이터 속성으로 가져오기
            openPasswordModal(roomId);
        });
    });
};
