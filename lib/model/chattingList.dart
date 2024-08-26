class ChattingList {
  final String id;
  final String lastMessage;
  final String sender;
  final String receiver;
  final String members; //채팅방 안의 유저 2명의 정보 (id, username,email..)
  final String message;
  final String roomNum;
  final bool read;
  final String createdAt;
  final String updatedAt;


  ChattingList({
    required this.id,
    required this.lastMessage,
    required this.sender,
    required this.receiver,
    required this.members,
    required this.message,
    required this.roomNum,
    required this.read,
    required this.createdAt,
    required this.updatedAt
  });

  // JSON으로부터 ChattingList 객체 생성
  factory ChattingList.fromJson(Map<String, dynamic> json) {
    return ChattingList(
      id: json['id'] ?? '',
      lastMessage: json['lastMessage'] ?? '',
      sender : json['sender'] ?? '',
      receiver: json['receiver'] ?? '',
      members: json['members'] ?? '',
      message: json['message'] ?? '',
      roomNum: json['roomNum'] ?? '',
      read: json['read'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  // ChattingList 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'lastMessage' : lastMessage,
      'sender' : sender,
      'receiver' : receiver,
      'members' : members,
      'message' : message,
      'roomNum' : roomNum,
      'read' : read,
      'createdAt' : createdAt,
      'updatedAt' : updatedAt
    };
  }



}


