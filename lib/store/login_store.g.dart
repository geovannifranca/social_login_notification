// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  late final _$isFacebookLoadingAtom = Atom(
    name: 'LoginStoreBase.isFacebookLoading',
    context: context,
  );

  @override
  bool get isFacebookLoading {
    _$isFacebookLoadingAtom.reportRead();
    return super.isFacebookLoading;
  }

  @override
  set isFacebookLoading(bool value) {
    _$isFacebookLoadingAtom.reportWrite(value, super.isFacebookLoading, () {
      super.isFacebookLoading = value;
    });
  }

  late final _$isGoogleLoadingAtom = Atom(
    name: 'LoginStoreBase.isGoogleLoading',
    context: context,
  );

  @override
  bool get isGoogleLoading {
    _$isGoogleLoadingAtom.reportRead();
    return super.isGoogleLoading;
  }

  @override
  set isGoogleLoading(bool value) {
    _$isGoogleLoadingAtom.reportWrite(value, super.isGoogleLoading, () {
      super.isGoogleLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'LoginStoreBase.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$currentUserAtom = Atom(
    name: 'LoginStoreBase.currentUser',
    context: context,
  );

  @override
  User? get currentUser {
    _$currentUserAtom.reportRead();
    return super.currentUser;
  }

  @override
  set currentUser(User? value) {
    _$currentUserAtom.reportWrite(value, super.currentUser, () {
      super.currentUser = value;
    });
  }

  late final _$loginGoogleAsyncAction = AsyncAction(
    'LoginStoreBase.loginGoogle',
    context: context,
  );

  @override
  Future<void> loginGoogle() {
    return _$loginGoogleAsyncAction.run(() => super.loginGoogle());
  }

  late final _$loginFacebookAsyncAction = AsyncAction(
    'LoginStoreBase.loginFacebook',
    context: context,
  );

  @override
  Future<void> loginFacebook() {
    return _$loginFacebookAsyncAction.run(() => super.loginFacebook());
  }

  late final _$logoutAsyncAction = AsyncAction(
    'LoginStoreBase.logout',
    context: context,
  );

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
isFacebookLoading: ${isFacebookLoading},
isGoogleLoading: ${isGoogleLoading},
errorMessage: ${errorMessage},
currentUser: ${currentUser}
    ''';
  }
}
