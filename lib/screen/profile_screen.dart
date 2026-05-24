import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login_notification/core/services/auth_service.dart';
import 'package:social_login_notification/screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  final User? user;
  final AuthService _auth;
  const ProfileScreen({
    super.key,
    required this.user,
    required AuthService auth,
  }) : _auth = auth;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.user != null) Image.network(widget.user!.photoURL!),
            const SizedBox(height: 20),
            if (widget.user != null) Text(widget.user!.displayName!),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () async {
                if (widget.user != null) {
                  await widget._auth.signOut();
                  if (context.mounted) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }
                }
              },
              child: const Text('Sair', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}
