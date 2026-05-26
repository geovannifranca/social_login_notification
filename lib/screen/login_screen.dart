import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:social_login_notification/screen/profile_screen.dart';
import 'package:social_login_notification/store/login_store.dart';
import 'package:social_login_notification/widget/login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _store = GetIt.I.get<LoginStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Create a account or sign in to save and see your conversation history.',
                style: TextStyle(fontSize: 26.8, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.1),
              Observer(
                builder: (context) {
                  return LoginButton(
                    isLoading: _store.isGoogleLoading,
                    pathImage: 'assets/images/google.png',
                    text: 'Continue with Google',
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await _store.loginGoogle();
                      if (!mounted) return;
                      if (_store.currentUser != null) {
                        navigator.pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              Observer(
                builder: (context) {
                  return LoginButton(
                    isLoading: _store.isFacebookLoading,
                    pathImage: 'assets/images/facebook.png',
                    text: 'Continue with facebook',
                    onPressed: () async {
                      await _store.loginFacebook();
                      if (context.mounted) {
                        if (_store.currentUser != null) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login cancelado ou falhou.'),
                            ),
                          );
                        }
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              LoginButton(
                pathImage: 'assets/images/apple.png',
                text: 'Continue with Apple',
                onPressed: () async {},
              ),
              const SizedBox(height: 40),
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Or', style: TextStyle(fontSize: 20)),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 40),
              LoginButton(
                icon: Icons.phone_android,
                text: 'Use phone number',
                onPressed: () async {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
