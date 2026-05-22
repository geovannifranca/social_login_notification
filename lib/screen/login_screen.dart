import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                },
              ),
              const SizedBox(height: 15),
              LoginButton(
                pathImage: 'assets/images/facebook.png',
                text: 'Continue with facebook',
                onPressed: () async {},
              ),
              const SizedBox(height: 15),
              LoginButton(
                pathImage: 'assets/images/apple.png',
                text: 'Continue with Apple',
                onPressed: () async {},
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: const Text('Or', style: TextStyle(fontSize: 20)),
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
