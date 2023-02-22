import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class AuthService {
  void listener(BuildContext context);

  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  });

  Future<void> register(
    BuildContext context, {
    required String email,
    required String password,
  });

  Future<void> logout();

  User get userDetail;
}

class AuthServiceImplement extends AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void listener(BuildContext context) {
    auth.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.of(context).pushNamed("/homepage");
      }
    });
  }

  @override
  Future<void> login(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      FocusScope.of(context).unfocus();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
    }
  }

  @override
  Future<void> register(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    try {
      FocusScope.of(context).unfocus();

      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The password provided is too weak.'),
        ));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('The account already exists for that email.'),
        ));
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    await auth.signOut();
  }

  @override
  User get userDetail => auth.currentUser!;
}
