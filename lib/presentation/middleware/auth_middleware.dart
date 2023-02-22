import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/presentation/bloc/profile/profile_bloc.dart';
import 'package:kanban_board/presentation/bloc/profile/profile_event.dart';

class AuthMiddleware extends StatelessWidget {
  final Widget nextPage;

  const AuthMiddleware({
    Key? key,
    required this.nextPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      context
          .read<ProfileBloc>()
          .add(GetProfileEvent(FirebaseAuth.instance.currentUser!));

      return nextPage;
    } else {
      Future.delayed(
        const Duration(
          seconds: 1,
        ),
        () => Navigator.of(context)
            .pushNamedAndRemoveUntil("/login", (route) => false),
      );
    }

    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
