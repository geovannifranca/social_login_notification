import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotificationService {
  Future<void> initalize() async {
    // ignore: unused_local_variable
    final notificationSettings = await FirebaseMessaging.instance
        .requestPermission(provisional: true);
    final fcmToken = await FirebaseMessaging.instance.getToken();

    // ignore: avoid_print
    log("TOKEN DE NOTIFICAÇÃO: $fcmToken");

    FirebaseMessaging.onMessageOpenedApp.listen((e) {
      log("a notificação foi criada");
      log(jsonEncode(e.data));
      log(e.notification!.title!);
      log(e.notification!.body!);
    });
  }
}
