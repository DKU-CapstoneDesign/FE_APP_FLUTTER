import 'dart:convert';
import 'package:capstonedesign/model/user.dart';
import 'package:http/http.dart' as http;

import '../model/chatting.dart';
import '../model/chattingList.dart';

class ChattingDataSource {
  String baseUrl =  'http://152.69.230.42:8080';
      // 'http://144.24.81.41:8080';
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
  Stream<List<ChattingList>?> getChatList(String nickname) async* {
    List<ChattingList> chattingList = [];
    try {
      // 요청 설정
      final request = http.Request('GET', Uri.parse('$baseUrl/api/chat/list/nickname/$nickname'));
      request.headers['Accept'] = 'text/event-stream';

      final response = await request.send();

      if (response.statusCode == 200) {
        print("채팅방 목록 가져오기 성공");
        print(response.reasonPhrase);

        // SSE 응답을 스트림으로 변환하여 처리
        final stream = response.stream
            .transform(utf8.decoder) // UTF-8로 디코딩
            .transform(LineSplitter()); // 줄 단위로 분리

        // SSE 이벤트를 하나씩 처리
        await for (String event in stream) {
          // SSE 데이터가 'data: '로 시작하는지 확인
          if (event.startsWith('data:')) {
            final jsonData = event.substring(5); // 'data: ' 부분을 제거
            try {
              // 받은 데이터를 JSON으로 디코딩
              final decodedData = jsonDecode(jsonData);
              print("디코딩된 데이터: $decodedData");

              // ChattingList 객체로 변환하여 리스트에 추가
              chattingList.add(ChattingList.fromJson(decodedData));

              // 중간 데이터를 반환하여 UI 업데이트
              yield List.from(chattingList); // 리스트의 복사본을 반환
            } catch (e) {
              print("JSON 파싱 오류: $e");
            }
          }
        }
      } else {
        print("채팅방 목록 가져오기 실패: ${response.statusCode}");
        yield null;
      }

      // 최종적으로 모든 데이터가 처리되면 리스트를 반환
      yield chattingList;

    } catch (e) {
      print('오류 발생: $e');
      yield null;
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
  Stream<List<Chatting>?> chatListByRoomNum(String roomNum) async* {
    List<Chatting> chatting = [];
    try {
      final request = http.Request('GET', Uri.parse('$baseUrl/api/chat/roomNum/$roomNum'));
      request.headers['Accept'] = 'text/event-stream';
      request.headers['Content-Type'] = 'text/event-stream';
      final response = await request.send();

      if (response.statusCode == 200) {
        print("대화 내역 가져오기 성공");

        // 서버에서 전송되는 SSE 데이터를 스트림으로 변환
        final stream = response.stream
            .transform(utf8.decoder)
            .transform(LineSplitter());

        // 각 이벤트를 처리
        await for (String event in stream) {
          //print(event);
          if (event.startsWith('data:')) {
            final jsonData = event.substring(5); // 'data: ' 이후의 데이터 파싱
            final decodedData = jsonDecode(jsonData);
            chatting.add(Chatting.fromJson(decodedData)); // 파싱된 데이터로 ChattingList 객체 생성
            print(chatting);
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