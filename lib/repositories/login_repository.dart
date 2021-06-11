import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_DMpro/helpers/firebase_errors.dart';
import 'package:loja_virtual_DMpro/shared/models/signed_user.dart';

import 'package:loja_virtual_DMpro/src/login/login_viewmodel.dart';

class LoginRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> login(LoginViewModel model) async {
    String error;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: model.email, password: model.password);
      if (result != null) {
        SignedUser.fromRepository(result.user.uid);
      }
      error = '';
    } catch (e) {
      debugPrint(e.toString());
      error = getErrorString(e.code.toString());
    }
    return error;
  }
}
