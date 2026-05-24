import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn.instance;
  final _facebookSignIn = FacebookAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<User?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();
      // Trigger the authentication flow
      //abre a pagina do google para login.
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        // ignore: avoid_print
        print('Google login falhou: idToken nulo');
        return null;
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    } on GoogleSignInException catch (e) {
      // ignore: avoid_print
      print('Google login cancelado ou falhou: $e');
      return null;
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      // 1. Abre o fluxo de login do Facebook
      final LoginResult result = await _facebookSignIn.login(
        permissions: ['email', 'public_profile'],
        loginBehavior: LoginBehavior.webOnly,
      );

      if (result.status == LoginStatus.success) {
        // 2. Cria a credencial com o token recebido
        final OAuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken!.tokenString,
        );

        // 3. Autentica no Firebase
        final UserCredential userCredential = await _auth.signInWithCredential(
          credential,
        );

        return userCredential.user;
      } else {
        // ignore: avoid_print
        print('Facebook login falhou: ${result.status} - ${result.message}');
        return null;
      }
    } on Exception catch (e) {
      // ignore: avoid_print
      print('Erro no login com Facebook: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _facebookSignIn.logOut();
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
