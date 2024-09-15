//채팅방 리스트에서


import 'package:capstonedesign/model/user.dart';

class ChattingList {
  final int id;
  final String lastMessage;
  final List<User> members; //채팅방 안의 유저 2명의 정보 (User 객체를 들고 와야 함)
  final DateTime createdAt;
  final DateTime updatedAt;


  ChattingList({
    required this.id,
    required this.lastMessage,
    required this.members,
    required this.createdAt,
    required this.updatedAt
  });

  // JSON으로부터 ChattingList 객체 생성
  factory ChattingList.fromJson(Map<String, dynamic> json) {
    var membersJson = json['members'] as List;
    List<User> membersList = membersJson.map((memberJson) => User.fromJson(memberJson)).toList();

    return ChattingList(
      id: json['id'] ?? 0 ,
      lastMessage: json['lastMessage'] ?? '',
      members: membersList,
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  // ChattingList 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'lastMessage' : lastMessage,
      'members': members.map((user) => user.toJson()).toList(),
      'createdAt' : createdAt.toIso8601String(), // DateTime을 문자열로 변환
      'updatedAt' : updatedAt.toIso8601String(), // DateTime을 문자열로 변환
    };
  }
}



