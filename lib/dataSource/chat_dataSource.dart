


//채팅방 생성 /api/chat/creating (post, "members":  [{ "nickname": "kyu" }, {"nickname": "bom"}])
//채팅 보내기 /api/chat (post, sender, receiver, message)

//채팅 읽음 처리 /api/chat/{roomNum}/user/receiver (put)
//채팅방 목록 /api/chat/list/nickname/{nickname} (get, data:{"id":"664b1283c5ea8e1b3e504bdf","message":"hi","sender":"kyu","receiver":"bom","roomNum":"1","read":false,"createdAt)
//data:{"id":"664b1283c5ea8e1b3e504bdf","message":"hi","sender":"kyu","receiver":"bom","roomNum":"1","read":false,"createdAt":"2024-05-20T18:06:11.027"}

//채팅방 읽음 상태 목록 /api/chat/read/nickname/{nickname} (get, "roomNum": "3", "read": true)

//대화내역(방번호 기번){{base_url}}/api/chat/roomNum/{roomNum}


