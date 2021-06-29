import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_DMpro/helpers/firebase_errors.dart';
import 'package:loja_virtual_DMpro/shared/models/signed_user.dart';

class LoginRepository {
  final FirebaseAuth auth;

  LoginRepository(this.auth);

  Future<Either<String, SignedUser>> login(SignedUser user) async {
    String error;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      const Left('');
      return Right(SignedUser.fromRepository(result.user.uid));
    } catch (e) {
      debugPrint(e.toString());
      error = getErrorString(e.code.toString());
      return Left(error);
    }
  }

  Future<Either<String, User>> getCurrentUser() async {
    String error;
    try {
      final User result = auth.currentUser;
      SignedUser.fromRepository(result.uid);
      const Left('');
      return Right(result);
    } catch (e) {
      debugPrint(e.toString());
      error = getErrorString(e.code.toString());
      return Left(error);
    }
  }
}
