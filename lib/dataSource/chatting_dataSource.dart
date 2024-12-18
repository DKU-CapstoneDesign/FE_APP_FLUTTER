import 'dart:convert';
import 'package:capstonedesign/model/user.dart';
import 'package:http/http.dart' as http;
import '../model/chatting.dart';
import '../model/chattingList.dart';

class ChattingDataSource {
  String baseUrl = 'https://api.koreigner.o-r.kr';

  ////// 채팅방 생성 (게시판에서 상대방의 프로필을 통해 채팅방 생성)
  Future<ChattingList?> createChat(String sender, String receiver) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat/creating'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({ // 유저들의 닉네임을 통해 채팅방 생성
          "members": [
            {"nickname": sender},
            {"nickname": receiver}
          ]
        }),
      );
      if (response.statusCode == 200) {
        print("채팅방 생성 성공");
        // model의 ChattingList에 값을 넣기
        return ChattingList.fromJson(jsonDecode(response.body));
      } else {
        print("채팅방 생성 실패: ${response.statusCode}, ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  ////// 채팅 보내기
  Future<Chatting?> sendChat(String sender, String receiver, String message, User user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/chat'),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': user.cookie
        },
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
        // model의 Chatting에 값을 넣기
        return Chatting.fromJson(jsonDecode(response.body));
      } else {
        print('채팅 보내기 실패: ${response.statusCode}, ${response.body}');
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
    }
  }

  ////// 채팅방 목록 (sse)
  Stream<List<ChattingList>?> getChatList(String nickname) async* {
    List<ChattingList> chattingList = [];
    try {
      final request = http.Request('GET', Uri.parse('$baseUrl/api/chat/list/nickname/$nickname'));
      request.headers['Accept'] = 'text/event-stream';
      final response = await request.send();

      if (response.statusCode == 200) {
        print("채팅방 목록 가져오기 성공");

        // 서버에서 전송되는 SSE 데이터를 스트림으로 변환
        final stream = response.stream
            .transform(utf8.decoder)
            .transform(LineSplitter());

        // 각 이벤트를 처리
        await for (String event in stream) {
          if (event.startsWith('data:')) {
            final jsonData = event.substring(5).trim(); // 'data: ' 이후의 데이터 파싱
            final decodedData = jsonDecode(jsonData);
            final newChat = ChattingList.fromJson(decodedData);  // 파싱된 데이터로 ChattingList 객체 생성
            chattingList.add(newChat); // 채팅방 목록에 새 항목 추가
            yield List.from(chattingList); // 현재까지의 채팅방 목록을 스트림으로 반환
          }
        }
      } else {
        print("채팅방 목록 가져오기 실패: ${response.statusCode}");
        yield null;
      }
    } catch (e) {
      print('오류 발생: $e');
      yield null;
    }
  }

  ////// 채팅방 읽음 상태 목록 (sse)
  Future<Chatting?> getChatReadStatusList(String nickname) async {
    try {
      final response = await http.get(
          Uri.parse('$baseUrl/api/chat/list/nickname/$nickname'));
      if (response.statusCode == 200) {
        print("채팅방 읽음 목록 가져오기 성공");
        final responseData = jsonDecode(response.body);
        return responseData.map((chat) => Chatting.fromJson(chat));
      } else {
        print("채팅방 읽음 목록 가져오기 실패: ${response.body}");
        return null;
      }
    } catch (e) {
      print('오류 발생: $e');
      return null;
    }
  }

  ////// 채팅방 읽음 처리
  // 여기서 nickname은 reciever의 nickname
  Future<bool> setChatReadStatus(String roomNum, String nickname) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/chat/$roomNum/user/$nickname'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print("채팅방 읽음 성공");
        return true;
      } else {
        print('채팅방 읽음 실패: ${response.statusCode}, ${response.body}');
        return false;
      }
    } catch (e) {
      print('에러 발생: $e');
      return false;
    }
  }

  ////// 대화 내역(방 번호 기반)(sse) --- 알림
  Stream<List<Chatting>?> chatListByRoomNum(String roomNum) async* {
    List<Chatting> chatting = [];
    try {
      final request = http.Request('GET', Uri.parse('$baseUrl/api/chat/roomNum/$roomNum'));
      request.headers['Accept'] = 'text/event-stream';
      final response = await request.send();

      if (response.statusCode == 200) {
        print("대화 내역 가져오기 성공");

        // 서버에서 전송되는 SSE 데이터를 스트림으로 변환
        final stream = response.stream
            .transform(utf8.decoder)
            .transform(LineSplitter());

        // 각 이벤트를 처리
        await for (String event in stream) {
          if (event.startsWith('data:')) {
            final jsonData = event.substring(5); // 'data: ' 이후의 데이터 파싱
            final decodedData = jsonDecode(jsonData);
            final newChat = Chatting.fromJson(decodedData); //파싱된 데이터로 Chatting 객체 생성
            chatting.add(newChat);
            yield List.from(chatting); // 현재까지의 메시지 목록을 스트림으로 반환
          }
        }
      } else {
        print("대화 내역 가져오기 실패: ${response.statusCode}");
        yield null;
      }
    } catch (e) {
      print('오류 발생: $e');
      yield null;
    }
  }
}
