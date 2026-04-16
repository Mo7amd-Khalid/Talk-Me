import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    InitializationSettings settings = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );
    flutterLocalNotificationsPlugin.initialize(settings: settings);
  }

  // basic notification
  static void showBasicNotification(RemoteMessage message) async {
    NotificationDetails details = NotificationDetails(
      android: AndroidNotificationDetails(
        "id 0",
        "Basic Notification",
        priority: Priority.max,
        importance: Importance.max,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      id: 0,
      title: message.notification?.title ?? "null",
      body: message.notification?.body ?? "null",
      notificationDetails: details,
    );

  }
}
