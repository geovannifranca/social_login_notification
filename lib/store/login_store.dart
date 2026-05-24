import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:social_login_notification/core/services/auth_service.dart';

part 'login_store.g.dart';

// This is the class used by rest of your codebase
class LoginStore = LoginStoreBase with _$LoginStore;

// The store-class
abstract class LoginStoreBase with Store {
  final _auth = GetIt.I.get<AuthService>();

  @observable
  bool isFacebookLoading = false;

  @observable
  bool isGoogleLoading = false;

  @observable
  String? errorMessage;

  @observable
  User? currentUser;

  @action
  Future<void> loginGoogle() async {
    isGoogleLoading = true;
    errorMessage = null;
    Future.delayed(const Duration(seconds: 3));

    try {
      final user = await _auth.signInWithGoogle();
      if (user != null) {
        currentUser = user;
      } else {
        errorMessage = 'Login cancelado.';
      }
    } catch (e) {
      errorMessage = 'Erro ao entrar com Google: $e';
    } finally {
      isGoogleLoading = false; // <- faltou zerar o loading!
    }
  }

  @action
  Future<void> loginFacebook() async {
    isFacebookLoading = true;
    errorMessage = null;
    Future.delayed(const Duration(seconds: 3));
    try {
      final user = await _auth.signInWithFacebook();
      if (user != null) {
        currentUser = user;
      } else {
        errorMessage = 'Login cancelado.';
      }
    } catch (e) {
      errorMessage = 'Erro ao entrar com Facebook: $e';
    } finally {
      isFacebookLoading = false;
    }
  }

  @action
  Future<void> logout() async {
    await _auth.signOut();
    currentUser = null;
  }
}
