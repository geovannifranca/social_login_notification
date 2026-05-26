import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:social_login_notification/core/services/auth_service.dart';
import 'package:social_login_notification/firebase_options.dart';
import 'package:social_login_notification/my_app.dart';
import 'package:social_login_notification/store/custom_drawer_store.dart';
import 'package:social_login_notification/store/login_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(AuthService());
  getIt.registerSingleton<LoginStore>(LoginStore());
  getIt.registerSingleton<CustomDrawerStore>(CustomDrawerStore());

  runApp(const MyApp());
}
