import 'package:flutter/cupertino.dart';
import 'package:loja_virtual_DMpro/src/helpers/validators.dart';
import 'package:loja_virtual_DMpro/src/models/signed_user.dart';
import 'package:loja_virtual_DMpro/src/repositories/auth_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final AuthRepository repository;

  RegisterViewModel(this.repository);

  bool loadingButton = false;
  String errorRegister = '';
  SignedUser userResult;

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

  Future<void> register(SignedUser user) async {
    _setLoadingButton(true);
    final result = await repository.register(user);
    result.fold((l) => errorRegister = l, (r) {
      userResult = r;
      errorRegister = '';
    });
    _setLoadingButton(false);
  }
}
