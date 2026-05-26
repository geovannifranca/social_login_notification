import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:social_login_notification/service/firebase_notification_service.dart';
import 'package:social_login_notification/store/login_store.dart';
import 'package:social_login_notification/widget/custom_drawer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _store = GetIt.I.get<LoginStore>();

  @override
  void initState() {
    super.initState();
    FirebaseNotificationService().initalize();
  }

  @override
  Widget build(BuildContext context) {
    final user = _store.currentUser ?? FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (user != null)
              CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
                radius: 80,
              ),
            const SizedBox(height: 20),
            if (user != null) Text(user.displayName ?? ''),
          ],
        ),
      ),
    );
  }
}
