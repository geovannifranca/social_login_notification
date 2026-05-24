import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:social_login_notification/core/services/auth_service.dart';
import 'package:social_login_notification/screen/login_screen.dart';
import 'package:social_login_notification/screen/profile_screen.dart';
import 'package:social_login_notification/store/login_store.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = GetIt.I.get<AuthService>();
  final _store = GetIt.I.get<LoginStore>();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) =>
                ProfileScreen(user: _store.currentUser, auth: _auth),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(color: Colors.green)),
    );
  }
}
