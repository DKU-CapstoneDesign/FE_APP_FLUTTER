import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/chatting.dart';
import '../model/chattingList.dart';

class ChattingDataSource {
  String baseUrl = 'http://152.69.230.42:8080';
      //'http://158.180.86.243:8080';

  //////채팅방 생성 (게시판에서 상대방의 프로필을 통해 채팅방 생성)
  Future<ChattingList?> createChat(String sender, String receiver) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat/creating'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({ //유저들의 닉네임을 통해 채팅방 생성
          "members": [
            {"nickname": sender},
            {"nickname": receiver}
          ]
        }),
      );
      if (response.statusCode == 200) {
        print("채팅방 생성 성공");
        //model의 ChattingList에 값을 넣기
        return ChattingList.fromJson(jsonDecode(response.body));
      } else {
        print("채팅방 생성 실패: ${response.statusCode}, ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }


  //////채팅 보내기
  Future<Chatting?> sendChat(String sender, String receiver, String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "sender": sender,
          "receiver": receiver,
          "message": message
        }),
      );
      print(sender);
      print(receiver);
      print(message);

      if (response.statusCode == 200) {
        print("채팅 보내기 성공");
        //model의 Chatting에 값을 넣기
        return Chatting.fromJson(jsonDecode(response.body));
      } else {
        print('채팅 보내기 실패: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }


  //////채팅 읽음 처리
  Future<void> setChatRead(String roomNum, String receiver) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/chat/$roomNum/user/$receiver'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'matchedCount': 1,
          'modifiedCount': 1,
          'upsertedId': null
        }),
      );
      if (response.statusCode == 200) {
        print('읽음 처리 성공: ${response.body}');
      } else {
        print('읽음 처리 실패: ${response.body}');
      }
    } catch (e) {
      print('에러 발생: $e');
    }
  }


  //////채팅방 목록 (sse)
  Future<List<ChattingList>?> getChatList(String nickname) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/api/chat/list/nickname/$nickname'));
      if (response.statusCode == 200) {
        print("채팅방 목록 가져오기 성공");
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((chat) => ChattingList.fromJson(chat)).toList();
      } else {
        print("채팅방 목록 가져오기 실패: ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }


  //////채팅방 읽음 상태 목록 (sse)
  /*Future<List<ChattingList>?> getChatReadStatusList(String nickname) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/api/chat/list/nickname/$nickname'));
      if (response.statusCode == 200) {
        print("채팅방 읽음 목록 가져오기 성공");
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((chat) => ChattingList.fromJson(chat)).toList();
      } else {
        print("채팅방 읽음 목록 가져오기 실패: ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }
   */


  //////대화 내역(방 번호 기반)(sse)
  Future<List<ChattingList>?> chatListByRoomNum(String roomNum) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/api/chat/roomNum/$roomNum'));
      if (response.statusCode == 200) {
        print("대화 내역 가져오기 성공");
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((chat) => ChattingList.fromJson(chat)).toList();
      } else {
        print("대화 내역 가져오기 실패: ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }


  //////대화 내역 (송수신자 이름 기반) (sse)
  /*Future<List<ChattingList>?> chatListByNickName(String sender, String receiver) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/api/sender/$sender/receiver/$receiver'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((chat) => ChattingList.fromJson(chat)).toList();
      } else {
        print("대화 내역 가져오기 실패: ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }*/
}