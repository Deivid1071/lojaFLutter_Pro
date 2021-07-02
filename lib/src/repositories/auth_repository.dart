import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_DMpro/src/helpers/firebase_errors.dart';
import 'package:loja_virtual_DMpro/src/models/signed_user.dart';

class AuthRepository {
  final FirebaseAuth auth;

  AuthRepository(this.auth);

  Future<Either<String, SignedUser>> login(SignedUser user) async {
    String error;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
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
      if (result != null) {
        SignedUser.fromRepository(result.uid);
      }
      return Right(result);
    } catch (e) {
      error = getErrorString(e.code.toString());
      return Left(error);
    }
  }

  Future<Either<String, SignedUser>> register(SignedUser user) async {
    String error;
    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      SignedUser.fromRepository(result.user.uid);
      _saveData(result.user.uid, result.user.displayName, result.user.email);
      return Right(
          SignedUser(name: result.user.displayName, email: result.user.email));
    } catch (e) {
      error = getErrorString(e.code.toString());
      return Left(error);
    }
  }

  Future<void> _saveData(String id, String name, String email) async {
    await FirebaseFirestore.instance.collection('users').doc(id).set({
      'name': name,
      'email': email,
    });
  }
}
