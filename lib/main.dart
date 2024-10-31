import 'package:capstonedesign/view/screens/first/firstLogoPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeNotifications(); // 알림 초기화 및 권한 요청
  await _requestPermissions(); // 갤러리 및 알림 접근 권한 요청
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'First Logo Page',
      debugShowCheckedModeBanner: false,
      home: FirstLogoPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    );
  }
}


Future<void> _initializeNotifications() async {
  // Android 설정
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS 설정
  const IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );


  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('알림 클릭됨: $payload');
        await _resetNotificationCount(); // 클릭 시 카운트 초기화
      }
    },
  );
}

// 접근 권한 요청
Future<void> _requestPermissions() async {
  // 갤러리 접근 권한 요청
  if (await Permission.photos.request().isDenied) {
    print("갤러리 접근 권한이 거부되었습니다.");
  } else {
    print("갤러리 접근 권한이 허용되었습니다.");
  }
  // 알림 권한 요청 (iOS 전용)
  if (await Permission.notification.request().isDenied) {
    print("알림 권한이 거부되었습니다.");
  } else {
    print("알림 권한이 허용되었습니다.");
  }
}

// 알림 카운트 관리 기능 추가
Future<int> _getNotificationCount() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('notification_count') ?? 0;
}

Future<void> _incrementNotificationCount() async {
  final prefs = await SharedPreferences.getInstance();
  int currentCount = prefs.getInt('notification_count') ?? 0;
  await prefs.setInt('notification_count', currentCount + 1);
}

Future<void> _resetNotificationCount() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('notification_count', 0);
}