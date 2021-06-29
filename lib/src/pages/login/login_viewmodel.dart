import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_DMpro/src/helpers/validators.dart';
import 'package:loja_virtual_DMpro/src/models/signed_user.dart';
import 'package:loja_virtual_DMpro/src/repositories/login_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository repository;

  LoginViewModel(this.repository) {
    _loadCurrentUser();
  }

  bool loadingButton = false;
  String errorLogin = '';
  User fireBaseUser;

  bool verifyEmailValid(String email) {
    return emailValid(email);
  }

  bool verifyPasswordValid(String password) {
    return passwordValid(password);
  }

  void _setLoadingBurron(bool state) {
    loadingButton = state;
    notifyListeners();
  }

  Future<void> login(SignedUser user) async {
    _setLoadingBurron(true);
    final result = await repository.login(user);
    result.fold((l) => errorLogin = l, (r) => null);
    _setLoadingBurron(false);
  }

  Future<void> _loadCurrentUser() async {
    final result = await repository.getCurrentUser();
    result.fold((l) => errorLogin = l, (r) => fireBaseUser = r);
  }
}
