import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../core/di/di.dart';
import 'local_notification_service.dart';

class PushNotificationService {

  static FirebaseMessaging messaging = getIt();

  static Future<void> init()async{
    await messaging.requestPermission();

    // background or terminated notification
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // foreground notification that handled with local notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      LocalNotificationService.showBasicNotification(message);
      print(message.notification!.title);
    });
  }

  static Future<void> handleBackgroundMessage(RemoteMessage message)async{
    await Firebase.initializeApp();
    print(message.notification?.title);
  }
}