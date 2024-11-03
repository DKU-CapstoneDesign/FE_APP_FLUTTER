import 'package:capstonedesign/model/discover_festival.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../dataSource/chatting_dataSource.dart';
import '../../dataSource/discover_dataSource.dart';
import '../../dataSource/fortune_dataSource.dart';
import '../../dataSource/post_dataSource.dart';
import '../../model/chatting.dart';
import '../../model/chattingList.dart';
import '../../model/fortune.dart';
import '../../model/user.dart';


class HomePageViewModel extends ChangeNotifier {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  List<DiscoverFestival> festivals = [];
  String fortuneToday = '';
  List<dynamic> posts = [];
  List<Chatting> messages = [];
  bool loading = true;

  final DiscoverDatasource discoverDatasource;
  final FortuneDataSource fortuneDataSource;
  final PostDataSource postDataSource;
  final ChattingDataSource chatDataSource = ChattingDataSource();
  ChattingList? chattingList;

  HomePageViewModel({
    required this.discoverDatasource,
    required this.fortuneDataSource,
    required this.postDataSource,
  }){ initializeNotifications();}


  /////// 알림 초기화 메소드
  Future<void> initializeNotifications() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: androidSettings, iOS: iosSettings);

    bool? initialized = await flutterLocalNotificationsPlugin.initialize(settings);
    print('알림 초기화 완료: $initialized');
  }

  // 메시지 불러오기 ---sse
  Future<void> fetchMessage(String currentUserNickname) async {
    if (chattingList == null) {
      print("채팅 목록이 설정되지 않았습니다.");
      return;
    }
    final messageStream = chatDataSource.chatListByRoomNum(chattingList!.id.toString());
    messageStream.listen((chatList) async {
      messages = chatList!.cast<Chatting>();
      if (messages.isNotEmpty) {
        final latestChat = messages.last; // 가장 최근 메시지를 가져옴

        // 현재 유저가 보낸 메시지가 아니면 알림 전송
        if (latestChat.sender != currentUserNickname) {
          print("새 메시지 알림 전송: ${latestChat.message} from ${latestChat.sender}");
          await _incrementNotificationCount();
          _showNotification(latestChat.sender, latestChat.message);
        }
      }
      notifyListeners();
    });
  }

  //////////// 알림 표시 메소드
  Future<void> _showNotification(String? title, String? message) async {
    const androidDetails = AndroidNotificationDetails(
        'chat_channel',
        'Chat Notifications',
        'Channel for chat notifications',
        importance: Importance.max,
        priority: Priority.max,
        showWhen: false
    );

    const NotificationDetails notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: IOSNotificationDetails()
    );

    await flutterLocalNotificationsPlugin.show(
      0, // 알림 ID
      title, // 알림 제목
      message, // 알림 내용
      notificationDetails,
    );
  }

  ////// 알림 카운트 증가
  Future<void> _incrementNotificationCount() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCount = prefs.getInt('notification_count') ?? 0;
    await prefs.setInt('notification_count', currentCount + 1);
  }
  // 축제 정보
  Future<void> getFestivals() async {
    loading = true;
    notifyListeners();
    festivals = (await discoverDatasource.getFestivals())!;
    loading = false;
    notifyListeners();
  }

  // 가장 최근 게시물
  Future<void> getPostList(User user) async {
    loading = true;
    notifyListeners();
    posts = (await postDataSource.getAllPost(user))!;
    loading = false;
    notifyListeners();
  }

  // 오늘의 운세
  Future<void> getFortune(String birthMonth, String birthDay) async {
    loading = true;
    notifyListeners();
    Fortune? fortune = await fortuneDataSource.getFortune(birthMonth, birthDay);
    fortuneToday = fortune!.answer;
    loading = false;
    notifyListeners();
  }
}