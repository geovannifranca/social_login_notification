import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login_notification/screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

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
            if (FirebaseAuth.instance.currentUser != null)
              Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
            const SizedBox(height: 20),
            if (FirebaseAuth.instance.currentUser != null)
              Text(FirebaseAuth.instance.currentUser!.displayName!),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () async {
                if (FirebaseAuth.instance.currentUser != null) {
                  await FirebaseAuth.instance.signOut();
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
