//채팅방 안에서

class Chatting {
  final String id;
  final String message;
  final String sender;
  final String receiver;
  late String roomNum;
  final bool read; // 채팅방 리스트에서 읽은 처리 (with roomNum)
  final DateTime createdAt;

  Chatting({
    required this.id,
    required this.message,
    required this.sender,
    required this.receiver,
    required this.roomNum,
    required this.read,
    required this.createdAt,
  });

  // JSON으로부터 Chatting 객체 생성
  factory Chatting.fromJson(Map<String, dynamic> json) {
    return Chatting(
      id: json['id'] ?? '',
      message: json['message'] ?? '',
      sender: json['sender'] ?? '',
      receiver: json['receiver'] ?? '',
      roomNum: json['roomNum'] ?? '',
      read: json['read'] ?? true,
      createdAt: DateTime.parse(json['createdAt']?? DateTime.now().toIso8601String()),
    );
  }

  // Chatting 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'sender': sender,
      'receiver': receiver,
      'roomNum': roomNum,
      'read': read,
      'createdAt': createdAt.toIso8601String(), // DateTime를 문자열로 변환
    };
  }
}