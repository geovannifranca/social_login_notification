import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_login_notification/firebase_options.dart';
import 'package:social_login_notification/my_app.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}
