import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_DMpro/src/helpers/validators.dart';
import 'package:loja_virtual_DMpro/src/models/signed_user.dart';
import 'package:loja_virtual_DMpro/src/repositories/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository repository;

  LoginViewModel(this.repository) {
    _loadCurrentUser();
  }

  bool loadingButton = false;
  String errorLogin = '';
  SignedUser signedUser;

  bool verifyEmailValid(String email) {
    return emailValid(email);
  }

  bool verifyPasswordValid(String password) {
    return passwordValid(password);
  }

  void _setLoadingButton(bool state) {
    loadingButton = state;
    notifyListeners();
  }

  Future<void> login(SignedUser user) async {
    _setLoadingButton(true);
    final result = await repository.login(user);
    result.fold((l) => errorLogin = l, (r) => errorLogin = '');
    _setLoadingButton(false);
  }

  Future<void> _loadCurrentUser() async {
    User fireBaseUser;
    final result = await repository.getCurrentUser();
    result.fold((l) => errorLogin = l, (r) => fireBaseUser = r);
    if (fireBaseUser != null) {
      signedUser.name = fireBaseUser.displayName;
      signedUser.email = fireBaseUser.email;
      SignedUser.token = fireBaseUser.uid;
    }
  }
}
