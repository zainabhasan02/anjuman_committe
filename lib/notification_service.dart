import 'dart:convert';

import 'package:anjuman_committee/res/routes/routes_name.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // keep a reference to the plugin
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationService(this.flutterLocalNotificationsPlugin);

  initFCM() async {
    await _firebaseMessaging.requestPermission();
    final token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('onMessageOpenedApp title: ${message.notification?.title}');
      print('onMessageOpenedApp body:  ${message.notification?.body}');
      Get.toNamed(
        RoutesName.notificationScreen,
        arguments: jsonEncode({
          'title': message.notification?.title ?? '',
          'body': message.notification?.body ?? '',
        }),
      );
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message data: ${message.data}');
      print('Foreground message title: ${message.notification?.title}');
      print('Foreground message body: ${message.notification?.body}');
      if (message.notification != null) {
        showFlutterNotification(message);
      }
    });
  }

  void showFlutterNotification(RemoteMessage msg) {
    final notification = msg.notification;
    final android = msg.notification?.android;

    if (notification != null && android != null) {
      final details = NotificationDetails(
        android: AndroidNotificationDetails(
          'high_importance_channel', // id
          'High Importance Notifications', // name
          channelDescription:
              'This channel is used for important notifications.',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      );

      final payload = {
        'title': notification.title,
        'body': notification.body,
      };

      flutterLocalNotificationsPlugin.show(
        msg.hashCode,
        msg.notification?.title,
        msg.notification?.body,
        details,
        payload: jsonEncode(payload),
      );
    }
  }
}
