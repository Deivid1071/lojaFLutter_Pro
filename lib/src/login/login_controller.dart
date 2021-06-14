import 'package:flutter/material.dart';
import 'package:loja_virtual_DMpro/helpers/validators.dart';
import 'package:loja_virtual_DMpro/repositories/login_repository.dart';
import 'package:loja_virtual_DMpro/src/login/login_viewmodel.dart';

class LoginController {
  final LoginRepository repository;

  LoginController(this.repository);

  final stateButtonLoginLoading = ValueNotifier<bool>(false);
  bool get stateButton => stateButtonLoginLoading.value;
  set stateButton(bool stateButton) =>
      stateButtonLoginLoading.value = stateButton;

  String errorLogin;

  bool verifyEmailValid(String email) {
    return emailValid(email);
  }

  bool verifyPasswordValid(String password) {
    return passwordValid(password);
  }

  Future<void> login(LoginViewModel model) async {
    stateButton = true;
    errorLogin = await repository.login(model);
    stateButton = false;
  }
}
