import 'package:flutter/material.dart';
import 'package:social_login_notification/screen/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social Login with Notification',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Color(0xFFF9F4EC)),
        scaffoldBackgroundColor: const Color(0xFFF9F4EC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
