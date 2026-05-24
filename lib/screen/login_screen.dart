import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:social_login_notification/screen/profile_screen.dart';
import 'package:social_login_notification/widget/login_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<UserCredential> signInWithGoogle() async {
    await GoogleSignIn.instance.initialize(
      serverClientId: dotenv.get('SERVER_CLIENT_ID'),
    );
    // Trigger the authentication flow
    //abre a pagina do google para login.
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance
        .authenticate();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<User?> signInWithFacebook() async {
    try {
      // 1. Abre o fluxo de login do Facebook
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.webOnly,
      );

      if (result.status == LoginStatus.success) {
        // 2. Cria a credencial com o token recebido
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString,
        );

        // 3. Autentica no Firebase
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential);

        return userCredential.user;
      } else {
        // Cancelado ou erro
        // ignore: avoid_print
        print('Facebook login falhou: ${result.status} - ${result.message}');
        return null;
      }
    } catch (e) {
      // ignore: avoid_print
      print('Erro no login com Facebook: $e');
      return null;
    }
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
              LoginButton(
                pathImage: 'assets/images/google.png',
                text: 'Continue with Google',
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  await signInWithGoogle();
                  if (!mounted) return;
                  navigator.pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const ProfileScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 15),
              LoginButton(
                pathImage: 'assets/images/facebook.png',
                text: 'Continue with facebook',
                onPressed: () async {
                  final user = await signInWithFacebook();
                  if (user != null) {
                    // Login com sucesso — navega para a home
                    if (context.mounted) {
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
