import 'package:device_apps/device_apps.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sistar/login.dart';

import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await LocalStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging fcm = FirebaseMessaging.instance;

  @override
  void initState() {
    fcm.subscribeToTopic("all");
    initNotify();
    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {

          showNotification(
              title: message.notification!.title,
              body: message.notification!.body,
              payload: message.data['action']);
      }
    });
    //app background on click action
  }

  Future<dynamic> onSelectNotification(payload) async {
    print(payload);
  }

  Future initNotify({bool initScheduled = false}) async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await _notifications.initialize(initializationSettings);
    _notifications.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  static _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static final _notifications = FlutterLocalNotificationsPlugin();

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {'/': (_) => Login(), "/home": (_) => MyHomePage()},
      title: 'sistAR',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: "/",
    );
  }
}
